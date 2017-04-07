#' create_dataset
#'
#' Create new dataset in DDH
#'
#' @param credentials list: object returned by the get_credentials() function
#' @param path character: Path to .JSON file containing the dataset information to be posted on DDH
#'
#' @return list
#' @export
#'

create_dataset <- function(credentials, path) {
  cookie <- credentials$cookie
  token <- credentials$token

  out <- httr::POST(url = 'https://ddhqa.worldbank.org/api/dataset/node',
                    httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                   'Cookie' =  cookie,
                                                   'X-CSRF-Token' = token)),
                    body = httr::upload_file(path),
                    encode = 'json')

  httr::warn_for_status(out)
}
