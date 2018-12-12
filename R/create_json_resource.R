#' create_json_resource
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values list: list of corresponding values that need to be updated
#' @param publication_status string: status to post the mode, takes values of c("published", "unpublished", "draft")
#' @param ddh_fields dataframe: table of all the data catalog fields by node type
#' @param lovs dataframe: lookup table of the data catalog tids and values
#' @param root_url string: API root URL
#'
#' @import dplyr
#' @return json string
#' @export
#'

create_json_resource <- function(values = list("title" = "Test Resource Title",
                                               "body" = "Test Resource Body",
                                               "field_wbddh_data_class" = "Public",
                                               "field_wbddh_resource_type" = "Resource Type not specified",
                                               "field_format" = "Format Not Specified",
                                               "field_link_api" = "www.google.com",
                                               "field_ddh_harvest_src" = "Finances",
                                               "field_ddh_harvest_sys_id" = "8675309"),
                                 publication_status = "published",
                                 ddh_fields = ddhconnect::get_fields(),
                                 lovs = ddhconnect::get_lovs(),
                                 root_url = dkanr::get_url()) {

  values_fields <- names(values)
  valid_fields <- unique(c(ddh_fields$machine_name[ddh_fields$node_type == "resource"], "type", "moderation_next_state"))
  invalid_fields <- setdiff(values_fields, valid_fields)
  if (length(invalid_fields) > 0) {
    stop(paste0("Invalid fields: ", paste(invalid_fields, collapse = "\n"),
    "\nPlease choose a valid field from:\n",
    paste(valid_fields, collapse = "\n")))
  }

  values["type"] <- "resource"
  values["moderation_next_state"] <- publication_status

  # get the correct JSON formats from the lookup table
  json_formats <- ddhconnect::resource_json_format_lookup
  json_body <- create_json_body(values, json_formats, lovs, root_url)
  return(json_body)
}
