#' delete_dataset
#'
#' Delete existing dataset in DDH
#'
#' @param nid character: Node ID of the dataset to be updated
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return list
#' @export
#'

delete_dataset <- function(nid,
                           root_url = dkanr::get_url(),
                           credentials = list(cookie = dkanr::get_cookie(),
                                              token = dkanr::get_token())) {
  out <- dkanr::delete_node(nid = nid,
                            url = root_url,
                            credentials = credentials)

  return(jsonlite::fromJSON(out))
}
