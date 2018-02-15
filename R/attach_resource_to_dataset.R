#' attach_resources_to_dataset
#'
#' Attach resources to a dataset in DDH
#'
#' @param dataset_nid character: node id of the dataset to which the resources are to be attached
#' @param resource_nids character vector: node ids of the resources to be attached
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return list
#' @export
#'

attach_resources_to_dataset <- function(dataset_nid,
                                       resource_nids,
                                       root_url = dkanr::get_url(),
                                       credentials = list(cookie = dkanr::get_cookie(),
                                                          token = dkanr::get_token())) {

  body <- create_json_attach(resource_nids = resource_nids)
  # purrr::map(resource_nids, dkanr::update_node(nid = dataset_nid,
  #                                              body = body))
  for(i in 1:length(resource_nids)) {
    tryCatch( {
      dkanr::update_node(nid = dataset_nid, body = body)
    }, error = function(e) {
      print("Returns an error")
    })
  }

  # return(jsonlite::fromJSON(out))
}
