#' get_user_details
#'
#' Retrieve user details: first name, last name, DDH internal ID
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param uid numeric: UPI number
#'
#' @return character
#' @export
#'

get_user_details <- function(credentials, uid) {
  cookie <- credentials$cookie
  token <- credentials$token

  uid <- stringr::str_pad(uid, pad = '0', side = 'left', width = 9)
  my_url <- paste0('https://ddhqa.worldbank.org/api/dataset/views/getuserdetails?uid=', uid)

  out <- httr::GET(url = my_url,
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'Cookie' =  cookie,
                                                  'X-CSRF-Token' = token,
                                                  'charset' = 'utf-8')))
  httr::warn_for_status(out)

  out <- httr::content(out)
  out <- unlist(out)

  return(out)
}
