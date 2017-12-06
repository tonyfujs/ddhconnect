connect_system <- function(root_url) {
  # Build url
  path <- 'api/dataset/system/connect'
  url <- httr::modify_url(root_url, path = path)

  out <- httr::POST(url,
             httr::accept_json(),
             body = list(x = '"SystemConnect":"Welcome"'),
             encode = 'json')
  httr::stop_for_status(out, task = 'connect to DDH')
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
  httr::stop_for_status(out, task = 'retrieve session ID via login service')
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
  httr::stop_for_status(out, task = 'retrieve token')

  out <- httr::content(out)

  return(out)
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


err_handler <- function(x) {
  if (x$status_code > 201) {
    obj <- try({
      err <- jsonlite::fromJSON(httr::content(x, "text", encoding = "UTF-8"))$form_errors
      errmsg <- paste('error:', err[[1]])
      list(err = err, errmsg = errmsg)
    }, silent = TRUE)
    if (class(obj) != "try-error") {
      stop(sprintf("%s - %s",
                   httr::http_status(x)$message,
                   obj$errmsg),
           call. = FALSE)
    } else {
      obj <- {
        err <- httr::http_condition(x, "error")
        errmsg <- httr::content(x, "text", encoding = "UTF-8")
        list(err = err, errmsg = errmsg)
      }
      stop(sprintf("%s - %s\n  %s",
                   x$status_code,
                   obj$err[["message"]],
                   obj$errmsg),
           call. = FALSE)
    }
  }
}

safe_unbox <- purrr::possibly(jsonlite::unbox, otherwise = '')
safe_assign <- function(x) {if (length(x) > 0) {x} else {""}}












