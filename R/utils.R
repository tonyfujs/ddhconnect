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

metadata_list_values_to_df <- function(metadata, lovs = ddhconnect::get_lovs()) {
  i <- 1
  list_value_names <-  vector(mode = "character")
  machine_names <-  vector(mode = "character")
  lov_fields <- unique(lovs$machine_name)

  for(x in 1:length(metadata)) {
    machine_name <- names(metadata)[x]
    if(!machine_name %in% lov_fields) {next}
    for(y in 1:length(metadata[[x]])) {
      list_value_names[[i]] <- unlist(metadata[[x]][y])
      machine_names[[i]] <- machine_name
      i <- i + 1
    }
  }

  data.frame(machine_name = machine_names, list_value_name = list_value_names, stringsAsFactors = FALSE)
}

safe_unbox <- purrr::possibly(jsonlite::unbox, otherwise = "")

safe_assign <- function(x) {
  if (length(x) > 0) {
    return(as.character(x))
  } else {
    return("")
  }
}
