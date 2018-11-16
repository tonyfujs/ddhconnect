#' create_json_body
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values list: list of corresponding values that need to be updated
#' @param json_formats dataframe: lookup table for machine name and expected value (dataset or resource)
#' @param root_url string: API root URL
#'
#' @import dplyr
#' @return json string
#' @export
#'

create_json_body <- function(values = list("title" = "Test Create JSON",
                                          "body" = "Test Creation of JSON"),
                             json_formats = ddhconnect::dataset_json_format_lookup,
                             root_url = dkanr::get_url()) {

  values <- map_tids(values, root_url)

  machine_names <- json_formats$machine_names
  to_update <- subset(json_formats, machine_names %in% names(values))
  json_body <- list()
  for (i in 1:nrow(to_update)) {
    field_name <- to_update[i, 1]
    json_template <- jsonlite::fromJSON(to_update[i, 2])
    if (is.character(json_template[[field_name]])) {
      # title and status
      json_template[[field_name]] <- safe_unbox(
                                       safe_assign(values[[field_name]])
                                     )
    } else if (is.null(names(json_template[[field_name]]$und))) {
      # controlled vocabulary fields
      vals <- values[[field_name]]
      json_template[[field_name]]$und <- vals
    } else {
      # free text fields
      subfield_name <- names(json_template[[field_name]]$und)
      json_template[[field_name]]$und[[subfield_name]] <-
                                  safe_unbox(safe_assign(values[[field_name]]))
    }
    json_body[field_name] <- json_template
  }
  return(jsonlite::toJSON(json_body))
}

format_tags <- function(value_string) {
  vals <- unlist(strsplit(test_string, split = ";"))
  out <- paste0('\"\"', vals, '\"\"', collapse = " ")
  return(out)
}
