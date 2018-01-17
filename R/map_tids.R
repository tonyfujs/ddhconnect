#' map_tids
#'
#' Map strings to tids
#'
#' @param values character vector: list of corresponding values that need to be checked for tids
#' @param credentials (optional) list: authentication token and cookie
#'
#' @return values character vector
#' @export
#'
#'

map_tids <- function(values) {
  lovs_df <- ddhconnect::get_lovs()
  keep <- intersect(names(values), lovs_df$machine_name)
  lovs_subset <- lovs_df[which(lovs_df$machine_name %in% keep), ]

  for (field_name in keep) {
    val_split <- unlist(strsplit(values[field_name], ";"))
    for (val in val_split) {
      map_tid <- lovs_subset[grep(val, lovs_subset$list_value_name, ignore.case = TRUE), ]$tid
      val_split[val_split == val] <- map_tid
    }
    values[field_name] <- paste(val_split, collapse = ";")
  }
  return(values)
}
