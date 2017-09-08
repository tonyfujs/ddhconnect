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
  # System connect
  system_connect_sessid <- connect_system(root_url = root_url)
  # Login service
  login_session_info <- login_service(system_connect_sessid = system_connect_sessid,
                                      username = username,
                                      password = password,
                                      root_url = root_url)

  # Get token
  cookie <- paste0(login_session_info$login_sessname, '=', login_session_info$login_sessid)
  temp_token <- get_token(cookie = cookie, root_url = root_url)
  token <- get_token(cookie = cookie, root_url = root_url)

  credentials <- list(cookie = cookie, token = token)
  return(credentials)
}
