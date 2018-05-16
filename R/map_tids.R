#' map_tids
#'
#' Map strings to tids
#'
#' @param values character vector: list of corresponding values that need to be checked for tids
#' @param root_url character: API root URL
#'
#' @import dplyr
#' @return list: list of metadata with some of the fields to be converted to
#' @export
#'
#'

map_tids <- function(values,
                     root_url = dkanr::get_url()) {
  lovs_df <- get_lovs(root_url = root_url)
  # check for valid values
  values_df <- metadata_list_values_to_df(values, lovs_df)
  invalid_df <- values_df %>%
                left_join(lovs_df) %>%
                filter(is.na(tid))

  errors <- c()
  if(nrow(invalid_df) > 0) {
    for(machine_name in invalid_df$machine_name) {
      # if the machine_name is valid
      if(machine_name %in% lovs_df$machine_name) {
        errors <- c(errors,
                    paste0("Invalid value for ", machine_name,
                           ". The valid values are:\n",
                           paste(lovs_df[lovs_df$machine_name == machine_name, "list_value_name"],
                           collapse = "\n"))
                    )
      }
      else {
        errors <- c(errors,
                    paste0("Invalid machine name: ", machine_name,
                           ". The valid machine names are:\n",
                           paste(unique(lovs_df$machine_name), collapse = "\n"))
                    )
      }
    }
    stop(paste(errors, collapse = "\n\n"))
  }

  keep <- intersect(names(values), lovs_df$machine_name)
  lovs_subset <- lovs_df[which(lovs_df$machine_name %in% keep), ]

  for (field_name in keep) {
    val_split <- values[field_name][[1]]
    for (val in val_split) {
      map_tid <- lovs_subset[lovs_subset$list_value_name == val, 'tid']
      val_split[val_split == val] <- map_tid
    }
    values[[field_name]] <- val_split
  }
  return(values)
}
