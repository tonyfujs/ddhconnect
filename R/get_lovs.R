#' get_lovs
#'
#' Retrieve controlled vocabulary / list of values (LOVs) accepted by DDH
#'
#' @param credentials
#'
#' @return dataframe
#' @export
#'
#'
get_lovs <- function(credentials) {
  cookie <- credentials$cookie
  token <- credentials$token

  out <- httr::GET(url = 'https://ddh.worldbank.org/api/dataset/views/taxonomylist',
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'Cookie' =  cookie,
                                                  'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')),
                   httr::accept_json())
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- dplyr::bind_rows(out)

  return(out)
}
