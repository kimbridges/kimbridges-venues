# ------------------------------------------------------------------------------
# Generic Reference Map Engine
# ------------------------------------------------------------------------------
library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(patchwork)
library(ggspatial)
library(ggrepel)
library(yaml)
library(jsonlite)
library(curl)



query_llm_yaml <- function(user_prompt, 
                           api_key = Sys.getenv("OPENAI_API_KEY"),
                           model = "gpt-4o-mini") {
  
  api_key <- trimws(api_key)
  if (api_key == "") {
    stop("OPENAI_API_KEY is not set. Check Sys.getenv('OPENAI_API_KEY')")
  }
  
  system_instructions <- "You are a cartographic assistant. Given a study site description, return ONLY a valid YAML block matching this schema:
country_name: '<Country>'
subdivision_name: '<Admin-1 or empty string>'
inset_corner: '<tr|tl|br|bl>'
output_pdf: '<name.pdf>'
main_bbox_wgs84:
  - <xmin>
  - <ymin>
  - <xmax>
  - <ymax>
study_bbox_wgs84:
  - <xmin>
  - <ymin>
  - <xmax>
  - <ymax>
sites:
  - name: '<Name>'
    lon: <lon>
    lat: <lat>
    type: '<Study Site|Market Town>'
Return ONLY the raw YAML text. Do not include markdown ticks or conversational text."
  
  payload <- list(
    model = model,
    temperature = 0.1,
    messages = list(
      list(role = "system", content = system_instructions),
      list(role = "user", content = user_prompt)
    )
  )
  
  h <- new_handle()
  handle_setheaders(h,
                    "Content-Type"  = "application/json",
                    "Authorization" = paste0("Bearer ", api_key)
  )
  handle_setopt(h,
                post = TRUE,
                postfields = toJSON(payload, auto_unbox = TRUE)
  )
  
  req <- curl_fetch_memory("https://api.openai.com/v1/chat/completions", handle = h)
  res_text <- rawToChar(req$content)
  
  if (req$status_code != 200) {
    stop("OpenAI API call failed (HTTP ", req$status_code, "):\n", res_text)
  }
  
  res_json <- fromJSON(res_text)
  raw_content <- res_json$choices$message$content[[1]]
  
  # Strip markdown fences if present
  clean_yaml <- gsub("^```yaml\\s*|```\\s*$", "", raw_content)
  clean_yaml <- gsub("^```\\s*|```\\s*$", "", clean_yaml)
  
  yaml::read_yaml(text = clean_yaml)
}

