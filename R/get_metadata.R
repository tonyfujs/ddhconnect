#' get_metadata
#'
#' Retrieve metadata for a specific dataset
#'
#' @param id character: The dataset UUID
#' @param root_url character: API root URL
#'
#' @return list
#' @export
#'
#'
get_metadata <- function(id, root_url = production_root_url) {

  # Build url
  path <- 'api/3/action/package_show'
  url <- httr::modify_url(root_url, path = path, query = list(id = id))
  # Send request
  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'charset' = 'utf-8')))
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- out$result[[1]]

  return(out)
}
