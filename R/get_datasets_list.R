#' get_datasets_list()
#'
#' @param datatype character: Restrict the list to a specific type of dataset. Available options are: "All", "Time Series", "Microdata", "Geospatial", or "Other"
#' @param root_url character: API root URL
#' @param credentials list: API authentication credentials
#'
#' @return numeric vector
#' @export
#'
#'

get_datasets_list <- function(datatype = "All",
                              root_url = dkanr::get_url(),
                              credentials = list(cookie = dkanr::get_cookie(),
                                                 token = dkanr::get_token())) {

  # Identify datasets to be listed
  datatypes_lkup <- construct_datatypes_lookup(root_url)
  dtype <- datatypes_lkup[datatype]
  inv_datatypes_lkup <- names(datatypes_lkup)
  names(inv_datatypes_lkup) <- datatypes_lkup

  # Define the parameters for the search
  fields <- c("nid", "uuid", "title", "field_wbddh_data_type")
  filters <- c("status" = 1)
  if (datatype != "All") {
    filters <- c("field_wbddh_data_type" = unname(dtype), filters)
  }
  limit <- 500

  out <- search_catalog(fields, filters, limit, root_url, credentials)

  nid <- purrr::map_chr(out, "nid")
  uuid <- purrr::map_chr(out, "uuid")
  title <- purrr::map_chr(out, "title")
  field_wbddh_data_type <- purrr::map_chr(out,
                            function(x) x$field_wbddh_data_type$und[[1]]$tid)
  field_wbddh_data_type <- inv_datatypes_lkup[field_wbddh_data_type]

  out <- data.frame(nid = nid,
                    uuid = uuid,
                    title = title,
                    data_type = field_wbddh_data_type,
                    stringsAsFactors = FALSE)
  rownames(out) <- nid

  return(out)

}
