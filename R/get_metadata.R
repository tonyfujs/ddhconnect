#' get_metadata
#'
#' Retrieve metadata for a specific dataset
#'
#' @param id character: The dataset UUID
#'
#' @return list
#' @export
#'
#'
get_metadata <- function(id) {

  url <- 'https://ddhstg.worldbank.org/api/3/action/package_show?id='
  url <- paste0(url, id)

  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'charset' = 'utf-8')))
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- out$result[[1]]

  return(out)
}
