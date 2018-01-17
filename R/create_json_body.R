#' create_json_body
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values character vector: list of correspodning values that need to be updated
#'
#' @import dplyr
#' @return json string
#' @export
#'

create_json_body <- function(values = c("title" = "Test Create JSON",
                                        "body" = "Test Creation of JSON",
                                        "field_wbddh_dsttl_upi" = "123",
                                        "field_wbddh_country" = "43;45"),
                             node_type = "dataset") {
  json_body <- list()
  if (node_type == "dataset") {
    json_formats <- ddhconnect::dataset_json_format_lookup
  } else if (node_type == "resource") {
    json_formats <- ddhconnect::resource_json_format_lookup
  }

  machine_names <- json_formats$machine_names
  to_update <- subset(json_formats, machine_names %in% names(values))
  for (i in 1:nrow(to_update)) {
    field_name <- to_update[i, 1]
    json_template <- jsonlite::fromJSON(to_update[i, 2])
    # title and status
    if (is.character(json_template[[field_name]])) {
      json_template[[field_name]] <- ddhconnect:::safe_unbox(ddhconnect:::safe_assign(values[[field_name]]))
    } else if (is.null(names(json_template[[field_name]]$und))) {
      json_template[[field_name]]$und <- unlist(stringr::str_split(values[[field_name]], pattern = ';'))
    } else {
      subfield_name <- names(json_template[[field_name]]$und)
      json_template[[field_name]]$und[[subfield_name]] <- safe_unbox(safe_assign(values[[field_name]]))
    }
    json_body <- c(json_body, json_template)
  }
  return(jsonlite::toJSON(json_body))
}
