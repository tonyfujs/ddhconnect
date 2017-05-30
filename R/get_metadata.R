#' get_metadata
#'
#' Retrieve metadata for a specific dataset
#'
#' @param credentials list: object returned by get_credentials()
#' @param node numeric: The dataset node
#'
#' @return dataframe
#' @export
#'
#'
get_metadata <- function(credentials, node) {
  cookie <- credentials$cookie
  token <- credentials$token

  url <- 'https://ddhstg.worldbank.org'
  path <- paste0('node/', node, '.json')
  url <- httr::modify_url(url = url, path = path)

  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'Cookie' =  cookie,
                                                  'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')))
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- dplyr::bind_rows(out)

  return(out)
}
