replicate_resource <- function(n, template = ddhconnect::attach_resources_template) {

  template$field_resources$und <- rep(template$field_resources$und, n)

  return(template)

}

build_search_query <- function(fields,
                               filters,
                               limit) {
  limit_text <- paste0('limit=', limit)
  fields_text <- paste(fields, collapse = ',')
  fields_text <- paste0('fields=[,', fields_text, ',]')
  filters_text <- dkanr::filters_to_text_query(filters, 'filter')

  out <- paste(limit_text, fields_text, filters_text, sep = '&')
}

construct_datatypes_lookup <- function(root_url = dkanr::get_url()){
  lovs <- get_lovs(root_url)
  data_type_lovs <- subset(lovs, lovs$machine_name == "field_wbddh_data_type")
  datatypes_lkup <- data_type_lovs$tid
  names(datatypes_lkup) <- data_type_lovs$list_value_name
  return(datatypes_lkup)
}
