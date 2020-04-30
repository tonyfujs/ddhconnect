#' get_iso3
#'
#' Retrieve list of country names and iso3 codes accepted by DDH
#' @param root_url character: API root URL
#'
#' @return dataframe
#' @export
#'

get_iso3 <- function(root_url = dkanr::get_url()) {
  # Build url
  path <- "api/taxonomy/listvalues"
  url <- httr::modify_url(root_url, path = path)
  # Send request
  out <- jsonlite::fromJSON(url)
  # keep only country names LOVs
  out <- out[out[["vocabulary_name"]] == "geographical_coverage",
             c("list_value_name", "field_wbddh_country_iso3")]
  names(out) <- c("country_name", "iso3")

  return(out)
}
