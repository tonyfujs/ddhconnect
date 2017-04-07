#' get_credentials
#'
#' This function facilitate the authentication process with the DDH API.
#'
#' @param username character: Your DDH API username
#' @param password character: Your DDH API password
#'
#' @return list
#' @export
#'

get_credentials <- function(username, password) {
  # System connect
  system_connect_sessid <- connect_system()
  # Login service
  login_session_info <- login_service(system_connect_sessid = system_connect_sessid,
                                      username = username,
                                      password = password)

  # Get token
  cookie <- paste0(login_session_info$login_sessname, '=', login_session_info$login_sessid)
  token <- get_token(cookie = cookie)

  credentials <- list(cookie = cookie, token = token)
  return(credentials)
}
