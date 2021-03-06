#' get_fields
#'
#' Retrieve list of fields (machine names + screen names) for each data type
#' @param root_url character: API root URL
#' @param credentials list: authentication token and cookie
#'
#' @return dataframe
#' @export
#'
#'

get_fields <- function(root_url = dkanr::get_url(),
                       credentials = list(cookie = dkanr::get_cookie(),
                                          token = dkanr::get_token())) {

  # Build url
  path <- "internal/ddh_fields"
  url <- httr::modify_url(root_url, path = path)
  # Send request
  out <- httr::GET(url = url,
                   httr::add_headers(.headers = c("Content-Type" = "application/json",
                                                  "charset" = "utf-8",
                                                  Cookie = credentials$cookie,
                                                  `X-CSRF-Token` = credentials$token)),
                   httr::accept_json())
  httr::warn_for_status(out)

  out <- httr::content(out)

  out <- plyr::ldply(out, data.frame, stringsAsFactors = FALSE)
  out <- reshape2::melt(out, id = ".id")
  out[["variable"]] <- as.character(out[["variable"]])
  out <- tidyr::separate_(out,
                          col = "variable",
                          into = c("type", "machine_name"),
                          sep = "\\.")
  names(out) <- c("data_type", "node_type", "machine_name", "pretty_name")

  out <- out[!is.na(out$pretty_name), ]

  return(out)
}
