#' create_json_dataset
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

create_json_dataset <- function(values = list("title" = "Test Create JSON",
                                          "body" = "Test Creation of JSON",
                                          "field_wbddh_dsttl_upi" = "123",
                                          "field_topic" = "Poverty",
                                          "field_wbddh_country" = c("Antigua and Barbuda","Armenia"),
                                          "field_wbddh_data_class" = "Not Specified",
                                          "field_wbddh_data_type" = "Other",
                                          "field_license_wbddh" = "Data not available"),
                                publication_status = "published",
                                ddh_fields = ddhconnect::get_fields(),
                                lovs = ddhconnect::get_lovs(),
                                root_url = dkanr::get_url()) {

  values_fields <- names(values)
  valid_fields <- unique(c(ddh_fields$machine_name[ddh_fields$node_type == "dataset"],
                           "type", "moderation_next_state", "field_exception_s"))
  invalid_fields <- setdiff(values_fields, valid_fields)
  if (length(invalid_fields) > 0) {
    stop(paste0("Invalid fields: ", paste(invalid_fields, collapse = "\n"),
    "\nPlease choose a valid field from:\n",
    paste(valid_fields, collapse = "\n")))
  }

  values["type"] <- "dataset"
  values["moderation_next_state"] <- publication_status

  # get the correct JSON formats from the lookup table
  json_formats <- ddhconnect::dataset_json_format_lookup
  json_body <- create_json_body(values, json_formats, lovs, root_url)
  return(json_body)
}
