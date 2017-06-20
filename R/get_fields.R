#' get_fields
#'
#' Retrieve list of fields (machine names + screen names) for each data type
#'
#' @return dataframe
#' @export
#'
#'
get_fields <- function() {
  # cookie <- credentials$cookie
  # token <- credentials$token

  out <- httr::GET(url = 'https://datacatalogbetastg.worldbank.org/internal/ddh_fields',
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  # 'Cookie' =  cookie,
                                                  # 'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')),
                   httr::accept_json())
  httr::warn_for_status(out)

  out <- httr::content(out)

  # df_length <- purrr::map_int(out, function(x) length(x[['dataset']]) + length(x[['resource']]))

  return(out)
}
