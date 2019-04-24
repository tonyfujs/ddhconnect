#' get_lov_fields
#'
#' Retrieve list of lov fields
#' @param root_url string: API root URL
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
