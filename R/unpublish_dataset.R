#' unpublish_dataset
#'
#' Unpublish existing dataset in DDH
#'
#' @param nid character: Node ID of the dataset to be unpublished
#' @param root_url character: API root URL
#' @param credentials list: DDH API authentication token and cookie
#'
#' @return list
#' @export
#'

unpublish_dataset <- function(nid,
                              root_url = dkanr::get_url(),
                              credentials = list(cookie = dkanr::get_cookie(),
                                                token = dkanr::get_token())) {

  json_template <- jsonlite::fromJSON("{}")
  json_template$workflow_status <- jsonlite::unbox("unpublished")
  json_body <- jsonlite::toJSON(json_template, pretty = TRUE)

  out <- ddhconnect::update_dataset(nid = nid,
                                    body = json_body,
                                    root_url = root_url,
                                    credentials = credentials)

  return(out)
}
