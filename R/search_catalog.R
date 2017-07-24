#' search_catalog
#'
#' Helper function to search the DDH data catalog
#'
#' @param path character: path to the search_api
#' @param fields character vector: fields to be returned by the search
#' @param filters named character vector: filters to be applied to the search
#' @param limit numeric: Maximum number of records to retrieve by search iteration
#' @param credentials list: API authentication credentials
#' @param root_url character: API root URL
#'
#' @return
#' @export
#'

search_catalog <- function(fields = c('nid', 'uuid', 'title', 'field_contact_email', 'field_wbddh_data_type', 'status'),
                           filters = c('field_wbddh_data_type'=294, 'status'=1),
                           limit = 200,
                           credentials,
                           path = 'search-service/search_api/datasets',
                           root_url = production_root_url) {


  # Build queries
  query_count <- build_search_query(fields = fields,
                                     filters = filters,
                                     limit = 1)
  query <- build_search_query(fields = fields,
                              filters = filters,
                              limit = limit)

  # get a count datasets
  count <- search_ddh(credentials = credentials,
                      query = query_count,
                      root_url = root_url)
  count <- as.numeric(count$count)
  #if (count < limit) {limit <- count}

  # Return query
  iterations <- ceiling(count / limit)
  out <- vector(mode = 'list', length = count)

  for (i in 1:iterations) {
    temp_offset <- (i - 1) * limit
    temp_query <- paste0(query, '&offset=', temp_offset)
    temp_resp <- search_ddh(credentials = credentials,
                            query = temp_query,
                            root_url = root_url)
    temp_resp <- temp_resp$result
    index <- (1 + temp_offset):(temp_offset + length(temp_resp))
    out[index] <- purrr::map(temp_resp, function(x) x)
  }

  return(out)
}
