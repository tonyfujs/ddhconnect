#' download_resource
#'
#' Download a file, extracting the path from `get_metadata()` output
#'
#' @param resource_id character: Resource NID
#' @param credentials Optional list parameter. Default values are Cookie and Token generated by dkan_setup()
#'
#' @export
#'

download_resource <- function(resource_id,
                              credentials = list(cookie = dkanr::get_cookie(),
                                                 token = dkanr::get_token())){

  resource_metadata <- get_metadata(nid = resource_id, credentials = credentials)

  path <- resource_metadata$field_link_api$und[[1]]$url
  ext <- tools::file_ext(path)

  if(resource_metadata$type == "resource"){
    if(ext != ""){
      download.file(url = path, destfile = basename(path))
      out <- ext
    }else{
      warning("This resource is not downloadable")
      out <- path
    }
  }else{
    warning("This is a dataset, not a resource. Please enter the nid for a resource.")
    out <- resource_metadata$title
  }
  return(out)
}