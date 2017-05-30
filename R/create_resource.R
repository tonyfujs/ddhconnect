#' create_resource
#'
#' Create new resource in DDH
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param path character: Path to .JSON file containing the resource information to be posted on DDH
#'
#' @return list
#' @export
#'

create_resource <- function(credentials, path) {
  cookie <- credentials$cookie
  token <- credentials$token

  # CHECK: dataset_id
  out <- httr::POST(url = 'https://ddhstg.worldbank.org/api/dataset/node',
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    body = httr::upload_file(path),
                    encode = 'json')

  httr::warn_for_status(out)

  out <- httr::content(out)
  names(out) <- c('node_id', 'uri')

  return(out)
}
