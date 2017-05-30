get_datasets_list <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other')) {

  limit <- 500

  # Identify datasets to be listed
  datatypes_lkup <- c(293, 294, 295, 853)
  names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')
  dtype <- datatypes_lkup[datatype]
  # get a count datasets
  count_url <- paste0('https://ddhstg.worldbank.org/search-service/search_api/datasets?limit=1&fields=[nid,uuid]&filter[status]=1&filter[field_wbddh_data_type]=', dtype)
  count <- httr::GET(url = count_url,
                     httr::add_headers(.headers = c('charset' = 'utf-8')),
                     httr::accept_json())
  httr::warn_for_status(count)
  count <- httr::content(count)
  count <- as.numeric(count$count)
  # retrieve list of datsets
  iterations <- ceiling(count / limit)
  out <- vector(mode = 'list', length = iterations)

  for (i in 1:iterations) {
    temp_offset <- (i - 1) * 500
    temp_url <- paste0('https://ddhstg.worldbank.org/search-service/search_api/datasets?limit=500&fields=[nid,uuid,title,field_wbddh_data_type]&filter[status]=1&filter[field_wbddh_data_type]=', dtype, '&offset=', temp_offset)
    temp_resp <- httr::GET(url = temp_url,
                           httr::add_headers(.headers = c('charset' = 'utf-8')),
                           httr::accept_json())
    httr::warn_for_status(temp_resp)
    temp_resp <- httr::content(temp_resp)
    temp_resp <- temp_resp$result
    temp_resp <- purrr::map_chr(temp_resp, 'uuid')
    out[[i]] <- temp_resp
  }

  out <- sort(as.numeric(unlist(out)))

  return(out)

}
