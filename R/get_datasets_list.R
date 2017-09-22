#' get_datasets_list()
#'
#' @param datatype character: Restrict the list to a specific type of dataset. Available options are: "all", "timeseries", "geospatial", or "other"
#' @param credentials list: API authentication credentials
#' @param root_url character: API root URL
#'
#' @return numeric vector
#' @export
#'
#'

get_datasets_list <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other'),
                                   credentials, root_url = production_root_url) {

  # Identify datasets to be listed
  datatypes_lkup <- c('293', '294', '295', '853')
  names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')
  dtype <- datatypes_lkup[datatype]
  inv_datatypes_lkup <- names(datatypes_lkup)
  names(inv_datatypes_lkup) <- datatypes_lkup

  # Define the parameters for the search
  fields = c('nid', 'uuid', 'title', 'field_wbddh_data_type')
  filters = c('status'=1)
  if(datatype != 'all') {
    filters = c('field_wbddh_data_type'=unname(dtype), filters)
  }
  limit = 500
  path = 'search-service/search_api/datasets'

  out = search_catalog(fields, filters, limit, credentials, path, root_url)

  nid <- purrr::map_chr(out, 'nid')
  uuid <- purrr::map_chr(out, 'uuid')
  title <- purrr::map_chr(out, 'title')
  field_wbddh_data_type <- purrr::map_chr(out, function(x) x$field_wbddh_data_type$und[[1]]$tid)
  field_wbddh_data_type <- inv_datatypes_lkup[field_wbddh_data_type]

  out <- data.frame(nid = nid, uuid = uuid, title = title, data_type = field_wbddh_data_type, stringsAsFactors = FALSE)
  rownames(out) <- nid

  return(out)

}
