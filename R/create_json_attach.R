#' create_json_attach
#'
#' Create a json according to predefined template
#'
#' @param resource_nid character: resource node id
#' @param json_template list: List generated from JSON template
#'
#' @return json
#' @export
#'

create_json_attach <- function(resource_nids) {

  json_template <- list()
  json_template$workflow_status <- jsonlite::unbox("published")
  json_template$field_resources$und <- vector("list", length = length(resource_nids))

  for(i in 1:length(resource_nids)) {
    resource_nid <- resource_nids[[i]]
    metadata <- get_metadata(resource_nid)
    resource_title <- metadata$title
    json_template$field_resources$und[[i]]$target_id <- paste0(resource_title,
                                                               " (",
                                                               resource_nid,
                                                               ")")
  }

  return(jsonlite::toJSON(json_template, auto_unbox = TRUE, pretty = TRUE))
}
