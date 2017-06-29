#' get_user_details
#'
#' Retrieve user details: first name, last name, DDH internal ID
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param uid numeric: UPI number
#' @param root_url character: API root URL
#'
#' @return character
#' @export
#'

get_user_details <- function(credentials, uid, root_url = production_root_url) {
  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  uid <- stringr::str_pad(uid, pad = '0', side = 'left', width = 9)
  path <- 'internal/getuserdetails'
  url <- httr::modify_url(root_url, path = path, query = list(uid = uid))
  # Send request
  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'Cookie' =  cookie,
                                                  'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')))
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- unlist(out)

  return(out)
}
