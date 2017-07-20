#' search_ddh
#'
#' Search DHH using the search_api service
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param query character: full text query
#' @param root_url character: API root URL
#'
#' @return list
#'

search_ddh <- function(credentials, query = 'limit=20&fields=[,nid,uuid,title,]&filter[field_wbddh_data_type]=294', root_url = production_root_url) {
  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  path <- 'search-service/search_api/datasets'
  url <- httr::modify_url(root_url, path = path, query = query)
  # Send request
  out <- httr::GET(url = url,
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'charset' = 'utf-8',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    encode = 'json')

  httr::warn_for_status(out)

  out <- httr::content(out)

  return(out)
}
