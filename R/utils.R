connect_system <- function(root_url) {
  # Build url
  path <- 'api/dataset/system/connect'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
             httr::accept_json(),
             body = list(x = '"SystemConnect":"Welcome"'),
             encode = 'json')
  httr::warn_for_status(out)
  out <- httr::content(out)
  out <- out$sessid

  return(out)
}

login_service <- function(system_connect_sessid, username, password, root_url) {
  # Build url
  path <- 'api/dataset/user/login'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
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

get_token <- function(cookie, root_url) {

  # Build url
  path <- 'services/session/token'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie)),
                    encode = "json")
  httr::warn_for_status(out)

  out <- httr::content(out)

  return(out)
}


logout_ddh <- function(credentials, username, password, root_url = production_root_url) {
  cookie <- credentials$cookie
  token <- credentials$token

  # Build url
  path <- 'api/dataset/user/logout'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    body = list(username = username,
                                password = password),
                    encode = "json")
  httr::warn_for_status(out)
  out <- httr::content(out)
}

replicate_resource <- function(n, template = ddhconnect::attach_resources_template) {

  template$field_resources$und <- rep(template$field_resources$und, n)

  return(template)

}



filters_to_text_query <- function(filters) {
  out <- purrr::map2_chr(filters, names(filters),
                         function(x, y) {
                           paste0('filter[', y, ']=', x)})
  out <- paste(out, collapse = '&')

  return(out)
}


build_search_query <- function(fields,
                               filters,
                               limit) {
  limit_text <- paste0('limit=', limit)
  fields_text <- paste(fields, collapse = ',')
  fields_text <- paste0('fields=[,', fields_text, ',]')
  filters_text <- filters_to_text_query(filters)

  out <- paste(limit_text, fields_text, filters_text, sep = '&')

}
















