#' get_lovs
#'
#' Retrieve controlled vocabulary / list of values (LOVs) accepted by DDH
#'
#'
#' @return dataframe
#' @export
#'
#'
get_lovs <- function() {
  # cookie <- credentials$cookie
  # token <- credentials$token

  out <- httr::GET(url = 'https://datacatalogbetastg.worldbank.org/internal/listvalues',
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  # 'Cookie' =  cookie,
                                                  # 'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')),
                   httr::accept_json())
  httr::warn_for_status(out)

  out <- httr::content(out)

  n_values <- length(out)
  # Create empty vectors to hold data
  vocabulary_name <- vector(mode = 'character', length = n_values)
  machine_name <- vector(mode = 'character', length = n_values)
  list_value_name <- vector(mode = 'character', length = n_values)
  tid <- vector(mode = 'character', length = n_values)
  # Fill out vectors
  vocabulary_name <- purrr::map_chr(out, 'vocabulary_name')
  machine_name <- purrr::map_chr(out, 'machine_name')
  list_value_name <- purrr::map_chr(out, 'list_value_name')
  tid <- purrr::map_chr(out, 'tid')


  out <- data.frame(vocabulary_name, machine_name, list_value_name, tid, stringsAsFactors = FALSE)

  return(out)
}
