get_datasets_count <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other')) {

  path = 'search-service/search_api/datasets'
  limit = 1
  datatypes_lkup <- c(293, 294, 295, 853)
  names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')



  # Create URL
  url <- 'https://ddh.worldbank.org'
  url <- httr::modify_url(url = url,
                          path = path,
                          query = list(limit = limit)
                          )

  datatype = match.arg(datatype)
  if (datatype != 'all') {
    datatype_filter <- unname(datatypes_lkup[datatype])
    datatype_filter <- paste0('filter[field_wbddh_data_type]=', datatype_filter)
    url <- paste0(url, '&', datatype_filter)
  }

  # Query
  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c('charset' = 'utf-8')),
                   httr::accept_json())
  httr::warn_for_status(out)

  out <- httr::content(out)
  count <- as.numeric(out$count)

  return(count)
}
