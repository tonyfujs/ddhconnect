#' download_resource
#'
#' Download a resource file, extracting the path from `get_metadata()` output
#'
#' @param resource_nid character: Resource NID
#' @param destination string: file path to save the file, defaults to current working directory
#' @param root_url string: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @export
#'

download_resource <- function(resource_nid,
                              destination = getwd(),
                              root_url = dkanr::get_url(),
                              credentials = list(cookie = dkanr::get_cookie(),
                                                 token = dkanr::get_token())) {

  resource <- get_metadata(nid = resource_nid,
                           root_url = root_url,
                           credentials = credentials)

  resource_url <- dkanr::get_resource_url(resource)
  ext <- tools::file_ext(resource_url)
  file_name <- basename(resource_url)
  dest_path <- paste0(destination, "/", file_name)

  if (ext != "") {
    curl::curl_download(url = resource_url, destfile = file_name)
  } else {
    warning("This resource cannot be downloaded")
  }

  return(file_name)
}
