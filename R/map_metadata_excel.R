#' map_metadata_excel
#'
#' Extract pretty_names and metadata values. Map the values to the corresponding machine_names
#'
#' @param path character: Takes path to an excel file containing metadata
#'
#' @import dplyr
#' @import readxl
#' @return vector
#' @export
#'

map_metadata_excel <- function(path) {

  metadata_df <- read_xlsx(path)

  #extract metadata
  input_fields <-
    metadata_df %>% select("Metadata field", "Value")

  df_references <- ddhconnect::ui_names_lookup

  #map metadata values to correct machine_names
  machine_names <-
    df_references %>%
    left_join(
      input_fields,
      by = c("ui_names" = "Metadata field") ,
      copy = TRUE,
      ignore.case = TRUE) %>%
    na.omit()

  #retrieve misses/invalid fields
  misses <-
    input_fields %>%
    anti_join(
      df_references,
      by = c("Metadata field" = "ui_names"),
      copy = TRUE,
      ignore.case = TRUE) %>%
    na.omit() %>%
    select("Metadata field")

  if (nrow(misses) > 0) {
    warning(paste0("The following Metadata fields are invalid, and won't be mapped to the appropriate machine_name: ", misses))
  }

  #create vector of machine names and values
  machine_names[]     <- lapply(machine_names, as.character)
  updated_data        <- c(machine_names[, "Value"])
  names(updated_data) <- c(machine_names[, "machine_names"])
  updated_data        <- c(updated_data, c("workflow_status" = "published"))

  return(updated_data)
}
