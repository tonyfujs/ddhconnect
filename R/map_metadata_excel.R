#' map_metadata_excel
#'
#' Extract metadata from an excel file. Map the values to the corresponding machine_names.
#' The file has to have "Metadata field" and "Values" columns.
#' @param path string: Takes path to an excel file containing metadata
#'
#' @import dplyr
#' @import readxl
#' @return vector
#' @export
#'

map_metadata_excel <- function(path) {

  metadata_df <- readxl::read_xlsx(path)

  #extract metadata
  input_fields <- metadata_df[,c("Metadata field", "Value")]


  df_references <- ddhconnect::ui_names_lookup

  #map metadata values to correct machine_names
  machine_names <- dplyr::left_join(df_references, input_fields,
                             by = c("ui_names" = "Metadata field"), copy = TRUE,
                             ignore.case = TRUE) %>% stats::na.omit()

  #retrieve misses/invalid fields
  misses <- dplyr::anti_join(input_fields, df_references,
            by = c("Metadata field" = "ui_names"), copy = TRUE,
            ignore.case = TRUE) %>% stats::na.omit()


  if (nrow(misses) > 0) {
    warning(paste0("The following Metadata fields are invalid, and won't be mapped to the appropriate machine_name: ", misses$`Metadata field`))
  }

  #create vector of machine names and values
  machine_names[]     <- lapply(machine_names, as.character)
  updated_data        <- c(machine_names[, "Value"])
  names(updated_data) <- c(machine_names[, "machine_names"])
  updated_data        <- c(updated_data, c("workflow_status" = "published"))

  return(updated_data)
}
