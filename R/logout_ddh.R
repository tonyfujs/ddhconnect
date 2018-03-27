#' logout_ddh
#'
#' Close an existing connection with the DDH API
#'
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return list
#' @export
#'

logout_ddh <- function(root_url = dkanr::get_url(),
                       credentials = list(cookie = dkanr::get_cookie(),
                                          token = dkanr::get_token())) {

  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  path <- "api/dataset/user/logout"
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
                    httr::add_headers(.headers = c("Content-Type" = "application/json",
                                                   "Cookie" =  cookie,
                                                   "X-CSRF-Token" = token)),
                    encode = "json")
  dkanr:::err_handler(out)
  out <- httr::content(out)

  return(out)
}
