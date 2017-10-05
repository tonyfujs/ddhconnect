#' get_resource_nid
#'
#' Return ALL resources node IDs associated with a dataset
#'
#' @param nid character: The DATASET node id
#' @param root_url character: API root URL
#'
#' @return character
#' @export
#'
#'
get_resource_nid <- function(nid, root_url = dkanr::get_url()) {

  out <- get_metadata(nid = nid, root_url = root_url)

  out <- unname(unlist(out$field_resources))

  return(out)
}
