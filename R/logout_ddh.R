#' logout_ddh
#'
#' Close an existing connection with the DDH API
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param root_url character: Server's root URL
#'
#' @return list
#' @export
#'

logout_ddh <- function(credentials, root_url = production_root_url) {
  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  path <- 'api/dataset/user/logout'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    encode = "json")
  httr::warn_for_status(out)
  out <- httr::content(out)

  return(out)
}
