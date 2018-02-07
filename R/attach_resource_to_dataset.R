#' attach_resource_to_dataset
#'
#' Attach resource to a dataset in DDH
#'
#' @param dataset_nid character: node id of the dataset to which the resources are to be attached
#' @param resource_nids character vector: node ids of the resources to be attached
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return list
#' @export
#'

attach_resource_to_dataset <- function(dataset_nid,
                                       resource_nids,
                                       root_url = dkanr::get_url(),
                                       credentials = list(cookie = dkanr::get_cookie(),
                                                          token = dkanr::get_token())) {

  body <- create_json_attach(resource_nids = resource_nids)
  out <- dkanr::update_node(nid = dataset_nid, url = root_url,
                            body = body, credentials = credentials)

  return(jsonlite::fromJSON(out))
}
