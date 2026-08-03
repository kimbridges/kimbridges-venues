#' Supply text and use OpenAI to interpret the body of text.
#' @param analysis_text A character string with the text to be interpreted.
#' @param AI_role A character string defining how the LLM is to behave.
#' @param analysis_prompt A character string saying exactly what you are looking for in the text.
#' @param LLM A character string with the name of the model such as gpt-4o or gpt-3.5-turbo.
#' @param apiKey The OpenAI API key.
#' @param connecttimeout The number of seconds maximum wait for a response.
#' @keywords GPT, OpenAI, API, text, interpretation
#' @export
#' @examples
analyzeTXT <- function (analysis_text,
                        AI_role,
                        analysis_prompt,
                        LLM,
                        apiKey=apiKey,
                        connecttimeout = 90){

# Set the API endpoint for chat completions
api_endpoint <- "https://api.openai.com/v1/chat/completions"

## Clean text
formatted_text <- analysis_text %>%
  str_c(analysis_text, collapse = "\\n")

# Construct the API request Body
request_body <- list(
  model = LLM,
  messages = list(
    list(role = "system", content = AI_role),
    list(role = "user", content = str_c(analysis_prompt, formatted_text))
  )
)

## Execute the POST request to the OpenAI API.
api_response <- POST(
  config = httr::config(connecttimeout = connecttimeout), ## seconds: Avoid timeout
  url = api_endpoint,
  body = request_body,
  encode = "json" ,
  add_headers("Authorization" = paste("Bearer", apiKey), 
              "Content-Type" = "application/json"))

## Process the response from the API.
response_data <- content(api_response, "parsed")

## Extract the summary from the API's response.
api_summary <- response_data$choices[[1]]$message$content

return(api_summary)

} ## End function analyzeTXT
