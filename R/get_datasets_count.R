get_datasets_count <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other'),
                               root_url = dkanr::get_url(),
                               credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token())) {

  limit <- 1
  datatypes_lkup <- c(293, 294, 295, 853)
  names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')

  query <- paste0("limit=", limit)

  datatype = match.arg(datatype)
  if (datatype != 'all') {
    datatype_filter <- unname(datatypes_lkup[datatype])
    datatype_filter <- paste0('filter[field_wbddh_data_type]=', datatype_filter)
    query <- paste0(query, '&', datatype_filter)
  }

  out <- search_ddh(credentials, query, root_url)
  count <- as.numeric(out$count)
  
  return(count)
}
