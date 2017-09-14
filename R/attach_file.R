#' attach_file
#'
#' Attach a file in DDH
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param file_path character: path to file on local machine
#' @param resource_id numeric: id of the resource to which you want to add the file
#' @param root_url character: API root URL
#'
#' @export
#'

attach_file <- function(credentials, file_path = "C:/Users/wb523589/ddh/GDP.csv", resource_id = 94673, root_url = production_root_url) {
  # construct the body of the POST request
  body = list('files[1]' = httr::upload_file(file_path), 'field_name' = c('field_upload'), 'attach' = c(1))
  
  # credentials
  cookie <- credentials$cookie
  token <- credentials$token
  
  # build query
  path <- paste0('api/dataset/node/', resource_id, '/attach_file')
  url <- httr::modify_url(root_url, path = path)
  
  out <- httr::POST(url = url,
                    httr::add_headers(.headers = c('Content-Type' = 'multipart/form-data',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    body = body)
  
  try(out <- httr::content(out))
  
  if(!is.null(out)){
    stop(print(out))
  }
}