#' get_metadata
#'
#' Retrieve metadata for a specific dataset
#'
#' @param nid character: The dataset node id
#' @param credentials list: object returned by the get_credentials() function
#' @param root_url character: API root URL
#'
#' @return list
#' @export
#'
#'
get_metadata <- function(nid, credentials, root_url = production_root_url) {

  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  path <- paste0('api/dataset/node/', nid)
  url <- httr::modify_url(root_url, path = path)
  # Send request
  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c(`Content-Type` = 'application/json',
                                                  charset = 'utf-8',
                                                  Cookie = cookie,
                                                  `X-CSRF-Token` = token)))
  httr::warn_for_status(out)

  out <- httr::content(out)

  return(out)
}
