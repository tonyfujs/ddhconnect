#' get_user_details
#'
#' Retrieve user details: first name, last name, DDH internal ID
#'
#' @param credentials list: authentication token and cookie
#' @param uid numeric: UPI number
#' @param root_url character: API root URL
#'
#' @return character
#' @export
#'

get_user_details <- function(credentials = list(cookie = dkanr::get_cookie(), token = dkanr::get_token()), uid, root_url = dkanr::get_url()) {
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
  dkanr:::err_handler(out)

  out <- httr::content(out)
  out <- unlist(out)

  return(out)
}
