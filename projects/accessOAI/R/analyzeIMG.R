#' Supply an image and use OpenAI to interpret the image.
#' @param analysis_image Either a URL for an image or a link to a locally stored image.
#' @param AI_role A character string defining how the LLM is to behave.
#' @param analysis_prompt A character string saying exactly what you are looking for in the image.
#' @param LLM A character string with the name of the model such as gpt-4o or gpt-3.5-turbo.
#' @param apiKey The OpenAI API key.
#' @param connecttimeout The number of seconds maximum wait for a response.
#' @keywords GPT, OpenAI, API, images
#' @export
#' @examples
analyzeIMG <- function (analysis_image,
                        AI_role,
                        analysis_prompt,
                        LLM,
                        apiKey=apiKey,
                        connecttimeout = 90) {

## Set the API endpoint for chat completions
api_endpoint <- "https://api.openai.com/v1/chat/completions"

## This handles images from the web (starting with "http") and
## from locally stored files in a slightly different way. 

## Find out the kind of image.
prefix <- tolower(substr(analysis_image,1,4))

## If this is an internet image, don't change it.
if(prefix != "http"){
  
  ## Make JPG images base64.
  txt_img <- base64enc::base64encode(analysis_image)
  analysis_image <- paste0("data:image/jpeg;base64,", txt_img)
  }  ## end prefix test

## Build the API request.
request_body <- list(
  model = LLM,
  messages = list(
    list(role = "system", content = AI_role),
    list(role = "user",   content = analysis_prompt),
    list(role = "user", 
         content = list(
         list(type = "image_url", image_url = list(url = analysis_image))
         ) ## content
      ) ## list
    ) ## messages
  ) ## request_body

## Execute the POST request to the OpenAI API.
api_response <- POST(
  config = httr::config(connecttimeout = connecttimeout), ## seconds: Avoid timeout
  url = api_endpoint,
  body = request_body,
  encode = "json" ,
  add_headers("Authorization" = paste("Bearer", apiKey), 
              "Content-Type" = "application/json")
  ) ## api_response

## Process the response from the API.
response_data <- content(api_response, "parsed")

## Extract the summary from the API's response.
api_summary <- response_data$choices[[1]]$message$content

return(api_summary)

} ## End function analyzeIMG
