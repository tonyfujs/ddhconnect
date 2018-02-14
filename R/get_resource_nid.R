#' get_resource_nid
#'
#' Return ALL resources node IDs associated with a dataset
#'
#' @param nid character: The DATASET node id
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return character
#' @export
#'
#'
get_resource_nid <- function(nid,
                             root_url = dkanr::get_url(),
                             credentials = list(cookie = dkanr::get_cookie(),
                                                token = dkanr::get_token())) {

  out <- get_metadata(nid = nid,
                      root_url = root_url,
                      credentials = credentials)

  out <- unname(unlist(out$field_resources))

  return(out)
}
