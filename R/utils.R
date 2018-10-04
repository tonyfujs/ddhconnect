#' @import dplyr
#' @import readxl

replicate_resource <- function(n, template = ddhconnect::attach_resources_template) {

  template$field_resources$und <- rep(template$field_resources$und, n)

  return(template)

}

build_search_query <- function(fields = "",
                               filters = "",
                               limit = 200) {
  limit_text <- paste0("limit=", limit)
  fields_text <- paste(fields, collapse = ",")
  fields_text <- paste0("fields=[,", fields_text, ",]")
  filters_text <- dkanr::filters_to_text_query(filters, "filter")

  out <- paste(limit_text, fields_text, filters_text, sep = "&")
  return(out)
}

construct_datatypes_lookup <- function(root_url = dkanr::get_url()) {
  lovs <- get_lovs(root_url)
  data_type_lovs <- subset(lovs, lovs$machine_name == "field_wbddh_data_type")
  datatypes_lkup <- data_type_lovs$tid
  names(datatypes_lkup) <- data_type_lovs$list_value_name
  return(datatypes_lkup)
}

metadata_list_values_to_df <- function(metadata, lovs_df) {
  i = 1
  num_values = length(unlist(metadata))
  list_value_names <-  vector(mode = "character")
  machine_names <-  vector(mode = "character")
  lov_fields <- unique(lovs_df$machine_name)

  for(x in 1:length(metadata)) {
    machine_name <- names(metadata)[x]
    if(!machine_name %in% lov_fields) {next}
    for(y in 1:length(metadata[[x]])) {
      list_value_names <- c(list_value_names, metadata[[x]][y])
      machine_names <- c(machine_names, machine_name)
      i = i + 1
    }
  }

  data.frame(machine_name = machine_names, list_value_name = list_value_names, stringsAsFactors = FALSE)
}

safe_unbox <- purrr::possibly(jsonlite::unbox, otherwise = "")

safe_assign <- function(x) {
  if (length(x) > 0) {
    return(x)
  } else {
    return("")
  }
}

map_metadata_excel <- function(path) {
  input_fields <- read_xlsx(path) %>%
    select("Metadata field", "Value")
  df_references<-ddhconnect::machine_name_metadata_references

  machine_names <- df_references %>%
    left_join(input_fields, by = c("input_name" = "Metadata field") , copy = TRUE, ignore.case = TRUE) %>%
    na.omit()

  misses <-input_fields %>%
    anti_join(df_references, by = c("Metadata field" = "input_name"), copy = TRUE, ignore.case = TRUE) %>%
    na.omit() %>%
    select("Metadata field")

  if(nrow(misses) > 0) {
    warning(paste0("The following Metadata fields are invalid, and won't be mapped to the appropriate machine_name: ", misses))
  }

  machine_names[] <- lapply(machine_names, as.character)
  updated_data        <- c(machine_names[,"Value"])
  names(updated_data) <- c(machine_names[,"machine_name"])
  updated_data        <- c(updated_data, c("workflow_status" = "published"))

  return(updated_data)
}

map_machine_pretty <- function(data_vector,from,to) {
  data <- data.frame(data_vector)
  all_fields <- tbl_df(get_fields()) %>%
  select("machine_name", "pretty_name") %>%
  unique()

  if( (from == "machine") & (to == "pretty" ) ){

    colnames(data) <- "machine_name"
    output <- all_fields %>%
      right_join(data, by = "machine_name" , copy = TRUE, ignore.case = TRUE) %>%
      select("pretty_name","machine_name") %>%
      na.omit() %>%
      unique()

    misses <-data %>%
        anti_join(output, by = c("machine_name"), copy = TRUE, ignore.case = TRUE) %>%
        select("machine_name")

  }
  else if ( (from == "pretty") & (to == "machine" ) ){

    colnames(data) <- "pretty_name"
    output <- all_fields %>%
      right_join(data, by = "pretty_name" , copy = TRUE, ignore.case = TRUE) %>%
      select("machine_name","pretty_name") %>%
      na.omit() %>%
      unique()

    misses <-data %>%
      anti_join(output, by = c("pretty_name"), copy = TRUE, ignore.case = TRUE) %>%
      select("pretty_name")
  }

  if(nrow(misses) > 0) {
    warning(paste0("The following fields could not be mapped: ", misses[,1]))
  }

  return(data.frame(output[,1]))
}
