#' download_resource
#'
#' Download a resource file, extracting the path from `get_metadata()` output
#'
#' @param resource_nid character: Resource NID
#' @param root_url string: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @export
#'

download_resource <- function(resource_nid,
                              root_url = dkanr::get_url(),
                              credentials = list(cookie = dkanr::get_cookie(),
                                                 token = dkanr::get_token())){

  resource <- get_metadata(nid = resource_nid,
                           root_url = dkanr::get_url(),
                           credentials = credentials)

  resource_url <- dkanr::get_resource_url(resource)
  ext <- tools::file_ext(resource_url)
  file_name <- basename(resource_url)

  if (ext != "") {
    curl::curl_download(url = resource_url, destfile = file_name)
  } else {
    warning("This resource cannot be downloaded")
  }
  return(file_name)
}
