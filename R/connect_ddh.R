connect_ddh <- function(path, body = NULL) {

  # if(!is.null(credentials)){
  #   cookie <- credentials$cookie
  #   token <- credentials$token
  # }

  # Build url
  url <- httr::modify_url("https://ddh.worldbank.org", path = path)
  # Make the request
  resp <- httr::GET(url,
            body = body,
            httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                           # 'Cookie' =  cookie,
                                           # 'X-CSRF-Token' = token,
                                           'charset' = 'utf-8'))
  )
  # CHECK: response in expected format
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Parse response
  jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  resp
}
