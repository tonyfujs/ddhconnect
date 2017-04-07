connect_system <- function() {
  out <- httr::POST('https://ddhqa.worldbank.org/api/dataset/system/connect',
             httr::add_headers(.headers = c('Content-Type' = 'application/json')),
             body = list(x = '"SystemConnect":"Welcome"'),
             encode = "json")
  httr::warn_for_status(out)
  out <- httr::content(out)
  out <- out$sessid

  return(out)
}

login_service <- function(system_connect_sessid, username, password) {
  out <- httr::POST('https://ddhqa.worldbank.org/api/dataset/user/login',
                     httr::add_headers(.headers = c('Content-Type' = 'application/json')),
                     body = list(sessid = system_connect_sessid,
                                 username = username,
                                 password = password),
                     encode = "json")
  httr::warn_for_status(out)
  out <- httr::content(out)
  login_sessid <- out$sessid
  login_sessname <- out$session_name

  return(list(login_sessid = login_sessid, login_sessname = login_sessname))
}

get_token <- function(cookie) {
  out <- httr::POST('https://ddhqa.worldbank.org/services/session/token',
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie)),
                    encode = "json")
  httr::warn_for_status(out)

  out <- httr::content(out)

  return(out)
}




















