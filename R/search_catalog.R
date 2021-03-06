#' search_catalog
#'
#' Helper function to search the DDH data catalog
#'
#' @param fields character vector: fields to be returned by the search
#' @param filters named character vector: filters to be applied to the search
#' @param limit numeric: Maximum number of records to retrieve by search iteration
#' @param root_url character: API root URL
#' @param credentials list: API authentication credentials
#'
#' @return list
#' @export
#'

search_catalog <- function(fields = c("nid", "uuid", "title",
                                      "field_contact_email",
                                      "field_wbddh_data_type",
                                      "status"),
                           filters = c("field_wbddh_data_type" = 294,
                                       "status" = 1),
                           limit = 200,
                           root_url = dkanr::get_url(),
                           credentials = list(cookie = dkanr::get_cookie(),
                                              token = dkanr::get_token())) {

  # Build queries
  query_count <- build_search_query(fields = fields,
                                     filters = filters,
                                     limit = 1)
  query <- build_search_query(fields = fields,
                              filters = filters,
                              limit = limit)

  # get a count datasets
  count <- search_ddh(query = query_count,
                      root_url = root_url,
                      credentials = credentials)
  count <- as.numeric(count$count)

  # Return query
  iterations <- ceiling(count / limit)
  out <- vector(mode = "list", length = count)

  if (length(out) > 0) {
    for (i in 1:iterations) {
      temp_offset <- (i - 1) * limit
      temp_query <- paste0(query, "&offset=", temp_offset)
      temp_resp <- search_ddh(credentials = credentials,
                              query = temp_query,
                              root_url = root_url)
      temp_resp <- temp_resp$result
      index <- (1 + temp_offset):(temp_offset + length(temp_resp))
      out[index] <- purrr::map(temp_resp, function(x) x)
    }
  } else {
    warning("Your query returned no results. Please try again.")
  }

  return(out)
}
