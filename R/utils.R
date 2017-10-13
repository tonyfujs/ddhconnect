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
