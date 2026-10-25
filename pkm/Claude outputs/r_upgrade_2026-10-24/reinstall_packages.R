# ==============================================================================
# reinstall_packages.R -- rebuild Kim's package library in R 4.6.1
# Inventory: packages_R4.3.3.csv (495 packages, taken from R 4.3.3 on 2026-10-24)
# ==============================================================================

INV_DIR <- "G:/My Drive/Projects_Index/Claude outputs/r_upgrade_2026-10-24"

# ---- PART A: Kim runs this by hand, first, in the NEW R --------------------
# (If asked "Would you like to use a personal library instead?" -> Yes, and Yes
#  to create it.)  This restores the Claude bridge; then tell Claude.
#
#   install.packages(c("remotes", "BiocManager"))
#   remotes::install_github("IMNMV/ClaudeR")
#   ... then start the ClaudeR server the way you normally do.

# ---- PART B: Claude runs the rest through the bridge -----------------------
reinstall_all <- function(inv_dir = INV_DIR) {
  options(repos = c(CRAN = "https://cloud.r-project.org"))
  inv <- read.csv(file.path(inv_dir, "packages_R4.3.3.csv"), stringsAsFactors = FALSE)
  have <- function() rownames(installed.packages())
  fail <- character()

  # 1. CRAN (binaries)
  cran <- setdiff(inv$Package[inv$route == "cran"], have())
  if (length(cran)) install.packages(cran, type = "binary")

  # 2. Bioconductor
  bio <- setdiff(inv$Package[inv$route == "bioc"], c(have(), "BiocVersion"))
  if (length(bio)) BiocManager::install(bio, update = FALSE, ask = FALSE)

  # 3. GitHub (other people's packages and Kim's published ones)
  gh <- inv[inv$route == "github" & !inv$Package %in% have(), ]
  for (i in seq_len(nrow(gh))) {
    # archive download: no GitHub API, so no token (both stored tokens were dead, 2026-10-24)
    r <- "fail"
    for (br in c("main", "master")) {
      r <- tryCatch({ remotes::install_url(sprintf("https://github.com/%s/%s/archive/refs/heads/%s.zip",
                        gh$RemoteUsername[i], gh$RemoteRepo[i], br), upgrade = "never", quiet = TRUE); "ok" },
                    error = function(e) conditionMessage(e))
      if (identical(r, "ok")) break
    }
    if (!identical(r, "ok")) fail <- c(fail, gh$Package[i])
  }

  # 4. Kim's own packages from their source folders (bucket 2)
  loc <- setdiff(inv$Package[inv$route == "local"], have())
  for (p in loc) {
    r <- tryCatch({ remotes::install_local(file.path("G:/My Drive/Projects", p),
                                           upgrade = "never", quiet = TRUE); "ok" },
                  error = function(e) conditionMessage(e))
    if (!identical(r, "ok")) fail <- c(fail, p)
  }

  missing <- setdiff(inv$Package, c(have(), "translations"))
  out <- inv[inv$Package %in% missing, ]
  write.csv(out, file.path(inv_dir, "still_missing_R4.6.csv"), row.names = FALSE)
  message(nrow(inv) - nrow(out), " of ", nrow(inv), " restored; ",
          nrow(out), " missing (see still_missing_R4.6.csv)")
  invisible(out)
}
