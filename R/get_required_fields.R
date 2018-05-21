#' get_required_fields
#'
#' Retrieve list of required fields for a data type
#' @param data_type character: One value out of "Timeseries", "Microdata", "Geospatial" and "Other"
#'
#' @return vector
#' @export
#'
#'

get_required_fields <- function(datatype = "Other") {
  if(datatype == "Timeseries") {
    required_fields <- ddhconnect::ts_required_fields$field
  }
  else if(datatype == "Microdata") {
    required_fields <- ddhconnect::md_required_fields$field
  }
  else if(datatype == "Geospatial") {
    required_fields <- ddhconnect::gs_required_fields$field
  }
  else {
    required_fields <- ddhconnect::other_required_fields$field
  }
  return(required_fields)
}
