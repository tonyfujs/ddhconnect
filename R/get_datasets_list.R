#' get_datasets_list()
#'
#' @param datatype character: Restrict the list to a specific type of dataset. Available options are: "all", "timeseries", "geospatial", or "other"
#' @param root_url character: API root URL
#'
#' @return numeric vector
#' @export
#'
#'

# get_datasets_list <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other'),
#                               root_url = production_root_url) {
#
#   # Identify datasets to be listed
#   datatypes_lkup <- c('293', '294', '295', '853')
#   names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')
#   dtype <- datatypes_lkup[datatype]
#
#   # Define the parameters for the search
#   fields = c('nid', 'uuid', 'title', 'field_wbddh_data_type')
#   filters = c('field_wbddh_data_type'=dtype, 'status'=1)
#   limit = 500
#   credentials = list(cookie='a', token='b')
#   path = 'search-service/search_api/datasets'
#
#   out = search_catalog(fields, filters, limit, credentials, path, root_url)
#
# }


get_datasets_list <- function(datatype = c('all', 'timeseries', 'microdata', 'geospatial', 'other'),
                              root_url = production_root_url) {

  limit <- 500

  # Identify datasets to be listed
  datatypes_lkup <- c('293', '294', '295', '853')
  names(datatypes_lkup) <- c('timeseries', 'microdata', 'geospatial', 'other')
  dtype <- datatypes_lkup[datatype]
  inv_datatypes_lkup <- names(datatypes_lkup)
  names(inv_datatypes_lkup) <- datatypes_lkup
  # get a count datasets
  count_url <- paste0(root_url,
                      '/search-service/search_api/datasets?limit=1&fields=[nid,]&filter[status]=1')
  if(datatype != 'all') {
    count_url <- paste0(count_url, '&filter[field_wbddh_data_type]=', dtype)
  }
  count <- httr::GET(url = count_url,
                     httr::add_headers(.headers = c('charset' = 'utf-8')),
                     httr::accept_json())
  httr::warn_for_status(count)
  count <- httr::content(count)
  count <- as.numeric(count$count)
  # retrieve list of datsets
  iterations <- ceiling(count / limit)
  nid <- vector(mode = 'list', length = iterations)
  uuid <- vector(mode = 'list', length = iterations)
  title <- vector(mode = 'list', length = iterations)
  field_wbddh_data_type <- vector(mode = 'list', length = iterations)

  for (i in 1:iterations) {
    temp_offset <- (i - 1) * 500
    temp_url <- paste0(root_url,
                       '/search-service/search_api/datasets?limit=500&fields=[nid,uuid,title,field_wbddh_data_type,]',
                       '&offset=',
                       temp_offset,
                       '&filter[status]=1')
    if(datatype != 'all') {
      temp_url <- paste0(temp_url, '&filter[field_wbddh_data_type]=', dtype)
    }
    temp_resp <- httr::GET(url = temp_url,
                           httr::add_headers(.headers = c('charset' = 'utf-8')),
                           httr::accept_json())
    httr::warn_for_status(temp_resp)
    temp_resp <- httr::content(temp_resp)
    temp_resp <- temp_resp$result
    nid[[i]] <- names(temp_resp)
    uuid[[i]] <- purrr::map_chr(temp_resp, 'uuid')
    title[[i]] <- purrr::map_chr(temp_resp, 'title')
    field_wbddh_data_type[[i]] <- purrr::map_chr(temp_resp, function(x) x$field_wbddh_data_type$und[[1]]$tid)
  }

  nid <- unlist(nid)
  uuid <- unlist(uuid)
  title <- unlist(title)
  field_wbddh_data_type <- unlist(field_wbddh_data_type)
  field_wbddh_data_type <- inv_datatypes_lkup[field_wbddh_data_type]

  out <- data.frame(nid = nid, uuid = uuid, title = title, data_type = field_wbddh_data_type, stringsAsFactors = FALSE)

  return(out)

}
