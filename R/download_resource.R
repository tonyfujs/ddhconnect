#' download_resource
#'
#' Download a resource file, extracting the path from `get_metadata()` output
#'
#' @param resource_nid character: Resource NID
#' @param credentials list: authentication token and cookie
#'
#' @export
#'

download_resource <- function(resource_nid,
                              credentials = list(cookie = dkanr::get_cookie(),
                                                 token = dkanr::get_token())){

  resource <- get_metadata(nid = resource_nid,
                           credentials = credentials)

  path_locs <- c(resource[[1]]$field_link_api$und[[1]]$url,
                 resource[[1]]$field_link_remote_file$und[[1]]$url,
                 resource[[1]]$field_upload$und[[1]]$uri)
  path <- unname(unlist(path_locs))

  if (grepl("^public", path)) {
    base <- "https://datacatalog.worldbank.org/sites/default/files/"
    file_str <- gsub("^public://", "", path)
    path <- paste0(base, file_str)
  }

  if (resource[[1]]$type == "resource") {
    ext <- tools::file_ext(path)
    if (ext != "") {
      curl::curl_download(url = path, destfile = basename(path))
      out <- ext
    } else {
      warning("This resource cannot be downloaded")
      out <- path
    }
  } else {
    warning("This is a dataset, not a resource. Please enter the nid for a resource.")
    out <- resource[[1]]$title
  }
  return(out)
}
