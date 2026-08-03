# elevenlabs_dialogue.R
# ---------------------------------------------------------------------------
# A small R harness for the ElevenLabs Text-to-Dialogue (Eleven v3) endpoint.
# Built from scratch 2026-06-03 for the Audio project.
#
# HTTP layer: the `curl` package + `jsonlite` directly (no httr2). This avoids
# the httr2 (>=1.2) requirement for curl >= 6.4.0; curl 6.2.2 works fine here
# and needs no compilation.
#
# Design facts (from the current ElevenLabs API reference, 2026-06-03):
#   - Endpoint: POST https://api.elevenlabs.io/v1/text-to-dialogue
#   - Auth header: xi-api-key
#   - Body: { inputs: [ {text, voice_id}, ... ], model_id, seed?, settings? }
#   - Speaker is the per-turn voice_id; it is NOT encoded in the text.
#   - Delivery tags are natural-language, wrapped in [square brackets], inline.
#   - Max 10 unique voice IDs; keep total of all inputs[].text <= 2000 chars
#     per request (longer requests error or terminate early when streamed).
#   - Returns a binary audio file (default mp3_44100_128).
#
# The ELEVENLABS_API_KEY is read from the environment (.Renviron).
# ---------------------------------------------------------------------------

# --- configuration ---------------------------------------------------------

el_api_key <- function() {
  key <- Sys.getenv("ELEVENLABS_API_KEY", unset = "")
  if (!nzchar(key)) {
    stop("ELEVENLABS_API_KEY is not set. Add it to ~/.Renviron or call ",
         "Sys.setenv(ELEVENLABS_API_KEY = '...').", call. = FALSE)
  }
  key
}

EL_BASE <- "https://api.elevenlabs.io"

`%||%` <- function(a, b) if (is.null(a)) b else a

# --- low-level HTTP helpers (curl) -----------------------------------------

# GET that returns parsed JSON.
el_get_json <- function(path) {
  h <- curl::new_handle()
  curl::handle_setopt(h, connecttimeout = 60L, timeout = 300L)
  curl::handle_setheaders(h, "xi-api-key" = el_api_key())
  resp <- curl::curl_fetch_memory(paste0(EL_BASE, path), handle = h)
  if (resp$status_code >= 400L) {
    stop("GET ", path, " failed [", resp$status_code, "]: ",
         rawToChar(resp$content), call. = FALSE)
  }
  jsonlite::fromJSON(rawToChar(resp$content), simplifyVector = FALSE)
}

# POST JSON body; returns the raw response bytes (audio).
el_post_raw <- function(path, body, query = NULL) {
  url <- paste0(EL_BASE, path)
  if (!is.null(query)) {
    url <- paste0(url, "?",
                  paste(names(query), unlist(query), sep = "=", collapse = "&"))
  }
  json <- jsonlite::toJSON(body, auto_unbox = TRUE, null = "null")
  h <- curl::new_handle()
  curl::handle_setopt(h, customrequest = "POST", postfields = json,
                      connecttimeout = 60L, timeout = 300L)
  curl::handle_setheaders(h,
    "xi-api-key"   = el_api_key(),
    "Content-Type" = "application/json")
  resp <- curl::curl_fetch_memory(url, handle = h)
  if (resp$status_code >= 400L) {
    stop("POST ", path, " failed [", resp$status_code, "]: ",
         rawToChar(resp$content), call. = FALSE)
  }
  resp$content
}

# --- voice catalog ---------------------------------------------------------
# List available voices so we can pick voice_ids for each speaker.
# Returns a data frame: voice_id, name, category.

el_list_voices <- function() {
  voices <- el_get_json("/v1/voices")$voices
  data.frame(
    voice_id = vapply(voices, `[[`, character(1), "voice_id"),
    name     = vapply(voices, `[[`, character(1), "name"),
    category = vapply(voices, function(v) v$category %||% NA_character_,
                      character(1)),
    stringsAsFactors = FALSE
  )
}

# --- script parsing --------------------------------------------------------
# Canonical script format (adopted 2026-06-03):
#   - One turn per line:  SPEAKER: spoken text with optional [delivery] tags
#   - Blank lines are ignored.
#   - A line that is ONLY a bracketed beat (e.g. "[silence]") is a structural
#     beat: it is NOT sent to the engine. It is dropped from the sent text and
#     marked as a chunk-break hint instead (a natural place to split).
#   - SPEAKER is mapped to a voice_id via the voice_map; the label never
#     reaches the API.
#
# Returns a data frame: speaker, text, is_break (logical).

el_parse_script <- function(path) {
  lines <- readLines(path, warn = FALSE)
  lines <- trimws(lines)
  lines <- lines[nzchar(lines)]

  speaker <- character(0)
  text    <- character(0)
  is_break <- logical(0)

  beat_re    <- "^\\[[^]]*\\]$"           # a line that is only a [bracket] beat
  speaker_re <- "^([A-Za-z0-9_]+):\\s*(.*)$"

  for (ln in lines) {
    if (grepl(beat_re, ln)) {
      if (length(is_break)) is_break[length(is_break)] <- TRUE
      next
    }
    m <- regmatches(ln, regexec(speaker_re, ln))[[1]]
    if (length(m) == 3) {
      speaker  <- c(speaker, m[2])
      text     <- c(text, trimws(m[3]))
      is_break <- c(is_break, FALSE)
    } else if (length(text)) {
      text[length(text)] <- trimws(paste(text[length(text)], ln))
    }
  }

  data.frame(speaker = speaker, text = text, is_break = is_break,
             stringsAsFactors = FALSE)
}

# --- chunking ---------------------------------------------------------------
# Split a parsed turn table into batches whose total text length is <= max_chars.
# Breaks are taken only at turn boundaries, preferring lines flagged is_break
# (natural conversational seams) so a chunk edge never falls mid-exchange.
# Returns a list of data frames (each a renderable batch).

el_chunk_turns <- function(turns, max_chars = 1900L) {
  batches <- list()
  start <- 1L
  n <- nrow(turns)
  i <- 1L
  running <- 0L
  last_break <- NA_integer_

  while (i <= n) {
    add <- nchar(turns$text[i])
    if (running + add > max_chars && i > start) {
      cut <- if (!is.na(last_break) && last_break >= start) last_break else (i - 1L)
      batches[[length(batches) + 1L]] <- turns[start:cut, , drop = FALSE]
      start <- cut + 1L
      running <- sum(nchar(turns$text[start:i]))
      last_break <- NA_integer_
    } else {
      running <- running + add
    }
    if (isTRUE(turns$is_break[i])) last_break <- i
    i <- i + 1L
  }
  if (start <= n) {
    batches[[length(batches) + 1L]] <- turns[start:n, , drop = FALSE]
  }
  batches
}

# --- the API call -----------------------------------------------------------
# Render one batch of turns to an audio file.

el_render_dialogue <- function(turns, voice_map, out_file,
                               model_id = "eleven_v3",
                               seed = NULL,
                               output_format = "mp3_44100_128") {

  unknown <- setdiff(unique(turns$speaker), names(voice_map))
  if (length(unknown)) {
    stop("No voice_id mapped for speaker(s): ", paste(unknown, collapse = ", "),
         call. = FALSE)
  }
  if (length(unique(voice_map[turns$speaker])) > 10L) {
    stop("More than 10 unique voice IDs in one request (API limit).",
         call. = FALSE)
  }
  total <- sum(nchar(turns$text))
  if (total > 2000L) {
    warning("Batch text is ", total, " chars (> 2000). Render may fail; ",
            "chunk first with el_chunk_turns().", call. = FALSE)
  }

  inputs <- lapply(seq_len(nrow(turns)), function(k) {
    list(text = turns$text[k], voice_id = unname(voice_map[turns$speaker[k]]))
  })

  body <- list(inputs = inputs, model_id = model_id)
  if (!is.null(seed)) body$seed <- as.integer(seed)

  audio <- el_post_raw("/v1/text-to-dialogue", body,
                       query = list(output_format = output_format))
  writeBin(audio, out_file)
  invisible(out_file)
}

# --- end-to-end convenience -------------------------------------------------
# Parse a script, chunk it, render each chunk to numbered files in out_dir.
# Returns the vector of written file paths (in order).

el_render_script <- function(script_path, voice_map, out_dir,
                             stem = "dialogue", seed = NULL,
                             output_format = "mp3_44100_128",
                             max_chars = 1900L) {
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
  turns   <- el_parse_script(script_path)
  batches <- el_chunk_turns(turns, max_chars = max_chars)
  paths   <- character(length(batches))

  for (b in seq_along(batches)) {
    out <- file.path(out_dir, sprintf("%s_part%02d.mp3", stem, b))
    el_render_dialogue(batches[[b]], voice_map, out,
                       seed = seed, output_format = output_format)
    message(sprintf("Rendered part %d/%d (%d turns, %d chars) -> %s",
                    b, length(batches), nrow(batches[[b]]),
                    sum(nchar(batches[[b]]$text)), out))
    paths[b] <- out
  }
  paths
}

# ===========================================================================
# Cast files + WAV assembly (added 2026-06-03, second test)
# ---------------------------------------------------------------------------
# Two additions driven by the Nike_challenge test:
#  1. Voices can be specified in a file (a "cast" file) instead of an
#     interactive choice, so trying different voices is just an edit + re-run.
#  2. Rendered parts can be assembled into ONE WAV with real silence inserted
#     at the structural-beat seams and a silent tail (fixes the abrupt end and
#     makes a [silence] beat actually audible). Done in PCM so concatenation is
#     sample-accurate and needs no audio package.
# ===========================================================================

# Read the voice catalog written by write.table(el_list_voices(), sep="\t").
el_read_catalog <- function(path) {
  read.delim(path, stringsAsFactors = FALSE)
}

# Resolve a voice spec (a voice_id, an exact catalogue name, or an unambiguous
# partial name) to a voice_id.
el_resolve_voice <- function(spec, catalog) {
  spec <- trimws(spec)
  # A bare ElevenLabs voice_id (20 alphanumeric chars) passes through,
  # whether or not it is in the local catalogue.
  if (grepl("^[A-Za-z0-9]{20}$", spec)) return(spec)
  if (spec %in% catalog$voice_id) return(spec)
  exact <- which(tolower(catalog$name) == tolower(spec))
  if (length(exact) == 1L) return(catalog$voice_id[exact])
  part <- grep(spec, catalog$name, ignore.case = TRUE, fixed = FALSE)
  if (length(part) == 1L) return(catalog$voice_id[part])
  if (length(part) == 0L)
    stop("No voice matches '", spec, "'. Check voice_catalog.tsv.", call. = FALSE)
  stop("Voice '", spec, "' is ambiguous; matches: ",
       paste(catalog$name[part], collapse = " | "),
       ". Use the full name or the voice_id.", call. = FALSE)
}

# Load a cast file into a named voice_id vector (names are SPEAKER labels).
# Cast-file format (lines):  SPEAKER = voice name OR voice_id
#   - blank lines and lines starting with # are ignored
#   - the right-hand side is resolved against the catalogue
el_load_cast <- function(cast_path, catalog_path) {
  catalog <- el_read_catalog(catalog_path)
  lines <- readLines(cast_path, warn = FALSE)
  lines <- trimws(lines)
  lines <- lines[nzchar(lines) & !startsWith(lines, "#")]
  speaker <- character(0); vid <- character(0)
  for (ln in lines) {
    m <- regmatches(ln, regexec("^([A-Za-z0-9_]+)\\s*=\\s*(.+)$", ln))[[1]]
    if (length(m) != 3) stop("Bad cast line: ", ln, call. = FALSE)
    speaker <- c(speaker, m[2])
    vid     <- c(vid, el_resolve_voice(m[3], catalog))
  }
  stats::setNames(vid, speaker)
}

# Render a batch of turns and RETURN the raw audio bytes (any output_format).
el_dialogue_bytes <- function(turns, voice_map,
                              output_format = "mp3_44100_128",
                              model_id = "eleven_v3", seed = NULL) {
  unknown <- setdiff(unique(turns$speaker), names(voice_map))
  if (length(unknown))
    stop("No voice for speaker(s): ", paste(unknown, collapse = ", "), call. = FALSE)
  inputs <- lapply(seq_len(nrow(turns)), function(k)
    list(text = turns$text[k], voice_id = unname(voice_map[turns$speaker[k]])))
  body <- list(inputs = inputs, model_id = model_id)
  if (!is.null(seed)) body$seed <- as.integer(seed)
  el_post_raw("/v1/text-to-dialogue", body,
              query = list(output_format = output_format))
}

# A raw vector of N seconds of 16-bit PCM silence (zeros).
el_silence_pcm <- function(seconds, sample_rate, channels = 1L, bits = 16L) {
  raw(as.integer(round(seconds * sample_rate) * channels * bits / 8))
}

# Write 16-bit PCM bytes to a .wav file (canonical 44-byte header).
el_write_wav <- function(pcm, out_file, sample_rate, channels = 1L, bits = 16L) {
  datalen    <- length(pcm)
  byterate   <- as.integer(sample_rate * channels * bits / 8)
  blockalign <- as.integer(channels * bits / 8)
  con <- file(out_file, "wb"); on.exit(close(con))
  writeChar("RIFF", con, eos = NULL)
  writeBin(as.integer(36 + datalen), con, size = 4, endian = "little")
  writeChar("WAVE", con, eos = NULL)
  writeChar("fmt ", con, eos = NULL)
  writeBin(16L, con, size = 4, endian = "little")            # fmt chunk size
  writeBin(1L,  con, size = 2, endian = "little")            # PCM
  writeBin(as.integer(channels),    con, size = 2, endian = "little")
  writeBin(as.integer(sample_rate), con, size = 4, endian = "little")
  writeBin(byterate,   con, size = 4, endian = "little")
  writeBin(blockalign, con, size = 2, endian = "little")
  writeBin(as.integer(bits), con, size = 2, endian = "little")
  writeChar("data", con, eos = NULL)
  writeBin(as.integer(datalen), con, size = 4, endian = "little")
  writeBin(pcm, con)
  invisible(out_file)
}

# End-to-end: parse a script, chunk it, render each chunk as PCM, splice the
# parts with `seam` seconds of silence between chunks and a `tail` of silence
# at the end, and write ONE wav. ElevenLabs TTS PCM is 16-bit mono.
# sample_rate falls back to 24000 if the requested rate is above the account tier.
el_assemble_wav <- function(script, voice_map, out_file,
                            sample_rate = 44100L, tail = 1.0, seam = 0.7,
                            max_chars = 1900L, seed = 42L) {
  turns   <- el_parse_script(script)
  batches <- el_chunk_turns(turns, max_chars = max_chars)
  render_at <- function(rate) lapply(batches, function(bt)
    el_dialogue_bytes(bt, voice_map,
                      output_format = paste0("pcm_", rate), seed = seed))
  rate <- as.integer(sample_rate)
  pcm_parts <- tryCatch(render_at(rate), error = function(e) {
    message("pcm_", sample_rate, " not available (", conditionMessage(e),
            "); falling back to pcm_24000.")
    rate <<- 24000L
    render_at(rate)
  })
  seam_sil <- el_silence_pcm(seam, rate)
  tail_sil <- el_silence_pcm(tail, rate)
  out <- pcm_parts[[1]]
  for (b in seq_along(pcm_parts)[-1]) out <- c(out, seam_sil, pcm_parts[[b]])
  out <- c(out, tail_sil)
  el_write_wav(out, out_file, sample_rate = rate, channels = 1L, bits = 16L)
  message(sprintf("Assembled %d part(s) @ %d Hz -> %s  (seam %.2fs, tail %.2fs)",
                  length(pcm_parts), rate, out_file, seam, tail))
  invisible(out_file)
}
