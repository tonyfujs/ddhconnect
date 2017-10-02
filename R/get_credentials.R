#' get_credentials
#'
#' This function facilitate the authentication process with the DDH API.
#'
#' @param username character: Your DDH API username
#' @param password character: Your DDH API password
#' @param root_url character: API root URL
#'
#' @return list
#' @export
#'

get_credentials <- function(username, password, root_url = production_root_url) {
  dkanr_setup(root_url, username, password)
  settings = dkanr_settings()
  credentials <- list(cookie = settings$cookie, token = settings$token)
  return(credentials)
}
