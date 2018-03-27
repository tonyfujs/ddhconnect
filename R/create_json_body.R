#' create_json_body
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values character vector: list of correspodning values that need to be updated
#' @param node_type string: type of node to upload (dataset or resource)
#' @param root_url string: API root URL
#'
#' @import dplyr
#' @return json string
#' @export
#'

create_json_body <- function(values = c("title" = "Test Create JSON",
                                        "body" = "Test Creation of JSON",
                                        "field_wbddh_dsttl_upi" = "123",
                                        "field_wbddh_country" = "43;45"),
                             node_type = "dataset",
                             root_url = dkanr::get_url()) {
  json_body <- list()
  if (node_type == "dataset") {
    json_formats <- ddhconnect::dataset_json_format_lookup
  } else if (node_type == "resource") {
    json_formats <- ddhconnect::resource_json_format_lookup
  }
  else {
    stop("Invalid value for node_type.
         node_type must either be \"dataset\" or \"resource\".")
  }
  values["type"] <- node_type

  machine_names <- json_formats$machine_names
  to_update <- subset(json_formats, machine_names %in% names(values))
  for (i in 1:nrow(to_update)) {
    field_name <- to_update[i, 1]
    json_template <- jsonlite::fromJSON(to_update[i, 2])
    # title and status
    if (is.character(json_template[[field_name]])) {
      json_template[[field_name]] <- safe_unbox(
                                       safe_assign(values[[field_name]])
                                     )
    }
    # controlled vocabulary fields
    else if (is.null(names(json_template[[field_name]]$und))) {
      vals <- unlist(stringr::str_split(values[[field_name]], pattern = ";"))
      # check for invalid values
      lovs <- get_lovs(root_url)
      if (nrow(lovs %>% filter(machine_name == field_name & tid %in% vals))
          != length(vals)){
        invalid_vals <- setdiff(values,
                                lovs %>%
                                filter(machine_name == field_name &
                                        tid %in% vals) %>%
                                pull(tid))
        stop(paste0("Invalid values for ", field_name, ": ",
                   paste(invalid_vals, collapse = " "),
                   "\nPlease choose from the valid values for ", field_name,
                   ":\n",
                   paste(lovs %>%
                         filter(machine_name == field_name) %>%
                         pull(tid), collapse = ", ")))
      }
      json_template[[field_name]]$und <- vals
    }
    # free text fields
    else {
      subfield_name <- names(json_template[[field_name]]$und)
      json_template[[field_name]]$und[[subfield_name]] <-
                                  safe_unbox(safe_assign(values[[field_name]]))
    }
    json_body <- c(json_body, json_template)
  }
  return(jsonlite::toJSON(json_body))
}
