#' get_metadata
#'
#' Retrieve metadata for a specific dataset
#'
#' @param nid character: The dataset node id
#' @param credentials list: object returned by the get_credentials() function
#' @param root_url character: API root URL
#'
#' @return list
#' @export
#'
#'
get_metadata <- function(nid, root_url = dkanr::get_url(), credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token())) {

  # Build url
  path <- paste0('api/dataset/node/', nid)
  url <- httr::modify_url(root_url, path = path)
  # Send request
  json_out <- dkanr::retrieve_node(nid, root_url, credentials)
  out <- jsonlite::fromJSON(json_out)

  return(out)
}
