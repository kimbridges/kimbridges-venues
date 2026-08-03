#' Supply a question and use OpenAI to answer the question by using its knowledge set.
#' @param prompt A character string with the question.
#' @param LLM A character string with the name of the model such as gpt-4o or gpt-3.5-turbo.
#' @param temperature A value from 0 to 1 that controls the fidelity of the response (1=best).
#' @param apiKey The OpenAI API key.
#' @param connecttimeout The number of seconds maximum wait for a response.
#' @keywords GPT, OpenAI, API, images
#' @export
#' @examples
queryOAI <- function(prompt, 
                    LLM,
                    temperature,
                    apiKey=apiKey,
                    connecttimeout = 90) {
  
  response <- POST(
    url = "https://api.openai.com/v1/chat/completions", 
    config = httr::config(connecttimeout = connecttimeout), ## seconds: Avoid timeout
    add_headers(Authorization = paste("Bearer", apiKey)),
    content_type_json(),
    encode = "json",
    body = list(
      model = LLM,
      temperature = temperature,
      messages = list(list(
        role = "user", 
        content = prompt
      ))
    )
  )
  
  if(status_code(response)>200) {
    stop(content(response))}
  
  trimws(content(response)$choices[[1]]$message$content)
  
} ## End queryOAI function
