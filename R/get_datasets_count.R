get_datasets_count <- function(datatype = c('All', 'Time Series', 'Microdata', 'Geospatial', 'Other'),
                               root_url = dkanr::get_url(),
                               credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token())) {

  limit <- 1
  datatypes_lkup <- construct_datatypes_lookup(root_url)

  query <- paste0("limit=", limit)

  datatype = match.arg(datatype)
  if (datatype != 'All') {
    datatype_filter <- unname(datatypes_lkup[datatype])
    datatype_filter <- paste0('filter[field_wbddh_data_type]=', datatype_filter)
    query <- paste0(query, '&', datatype_filter)
  }

  out <- search_ddh(credentials, query, root_url)
  count <- as.numeric(out$count)

  return(count)
}
