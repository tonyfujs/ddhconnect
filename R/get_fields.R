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

  out <- plyr::ldply(out, data.frame, stringsAsFactors = FALSE)
  out <- reshape2::melt(out, id = '.id')
  out[['variable']] <- as.character(out[['variable']])
  out <- tidyr::separate_(out, col = 'variable', into = c('type', 'machine_name'), sep = '\\.')
  names(out) <- c('data_type', 'node_type', 'machine_name', 'pretty_name')

  out <- out[!is.na(out$pretty_name), ]

  return(out)
}
