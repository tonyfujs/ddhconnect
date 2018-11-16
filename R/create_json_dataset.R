#' create_json_dataset
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values list: list of corresponding values that need to be updated
#' @param node_type string: type of node to upload (dataset or resource)
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
                                          "field_wbddh_country" = c("Antigua and Barbuda","Armenia")),
                                workflow_status = "published",
                                ddh_fields = NULL,
                                root_url = dkanr::get_url()) {

  if (missing(ddh_fields)) {
    ddh_fields <- dkanr::get_fields(root_url)
  }

  values_fields <- names(values)
  valid_fields <- unique(ddh_fields$machine_name[ddh_fields$node_type == "dataset"])
  invalid_fields <- setdiff(values_fields, valid_fields)
  if (length(invalid_fields) > 0) {
    stop(paste0("Invalid fields: ", paste(invalid_fields, collapse = "\n"),
    "\nPlease choose a valid field from:\n",
    paste(valid_fields, collapse = "\n")))
  }

  values["type"] <- "resource"
  values["workflow_status"] <- workflow_status

  # get the correct JSON formats from the lookup table
  json_formats <- ddhconnect::dataset_json_format_lookup
  json_body <- create_json_body(values, json_formats, root_url)
  return(jsonlite::toJSON(json_body))
}
