#' get_resource_nid
#'
#' Return ALL resources node IDs associated with a dataset
#'
#' @param nid character: The DATASET node id
#' @param credentials list: object returned by the get_credentials() function
#' @param root_url character: API root URL
#'
#' @return character
#' @export
#'
#'
get_resource_nid <- function(nid, credentials, root_url = production_root_url) {

  out <- get_metadata(nid = nid, credentials = credentials, root_url = root_url)

  out <- unname(unlist(out$field_resources))

  return(out)
}
