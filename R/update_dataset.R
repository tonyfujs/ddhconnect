#' update_dataset
#'
#' Update existing in DDH
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param nid character: Node ID of the dataset to be updated
#' @param body character: JSON body to be sent to the server
#'
#' @return list
#' @export
#'

update_dataset <- function(credentials, nid, body) {
  cookie <- credentials$cookie
  token <- credentials$token
  
  out <- httr::PUT(url = 'https://ddh.worldbank.org/api/dataset/node',
                   httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                  'Cookie' =  cookie,
                                                  'X-CSRF-Token' = token)),
                   body = body,
                   encode = 'json')
  
  httr::warn_for_status(out)
  
  out <- httr::content(out)
  names(out) <- c('node_id', 'uri')
  
  return(out)
}
