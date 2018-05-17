#' get_lov_fields
#'
#' Retrieve list of lov fields
#' @param data_type character: Takes a value among "Timeseries", "Microdata" or "Geospatial"
#'
#' @return vector
#' @export
#'
#'

get_lov_fields <- function(root_url = dkanr::get_url()) {
  lovs <- get_lovs(root_url)
  lov_fields <- unique(lovs$machine_name)
  return(lov_fields)
}
