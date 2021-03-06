#' get_metadata
#'
#' Retrieve metadata for a specific dataset or resource
#'
#' @param nid character: The dataset node id
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return list
#' @export
#'
#'

get_metadata <- function(nid,
                         root_url = dkanr::get_url(),
                         credentials = list(cookie = dkanr::get_cookie(),
                                            token = dkanr::get_token())) {

  # Send request
  json_out <- dkanr::retrieve_node(nid, root_url, credentials)
  out <- jsonlite::fromJSON(json_out, simplifyVector = FALSE)

  return(out)
}
