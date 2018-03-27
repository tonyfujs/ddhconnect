#' create_json_attach
#'
#' Create a json according to predefined template
#'
#' @param resource_nids character: node ids of the resources
#' @param root_url string: API root URL
#'
#' @return json
#' @export
#'

create_json_attach <- function(resource_nids, root_url = dkanr::get_url()) {

  json_template <- list()
  json_template$workflow_status <- jsonlite::unbox("published")
  json_template$field_resources$und <- vector("list", length = length(resource_nids))

  for (i in 1:length(resource_nids)) {
    resource_nid <- resource_nids[[i]]
    metadata <- get_metadata(nid = resource_nid, root_url = root_url)
    resource_title <- metadata$title
    json_template$field_resources$und[[i]]$target_id <- paste0(resource_title,
                                                               " (",
                                                               resource_nid,
                                                               ")")
  }

  return(jsonlite::toJSON(json_template, auto_unbox = TRUE, pretty = TRUE))
}
