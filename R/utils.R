replicate_resource <- function(n, template = ddhconnect::attach_resources_template) {

  template$field_resources$und <- rep(template$field_resources$und, n)

  return(template)

}


filters_to_text_query <- function(filters) {
  out <- purrr::map2_chr(filters, names(filters),
                         function(x, y) {
                           paste0('filter[', y, ']=', x)})
  out <- paste(out, collapse = '&')

  return(out)
}


build_search_query <- function(fields,
                               filters,
                               limit) {
  limit_text <- paste0('limit=', limit)
  fields_text <- paste(fields, collapse = ',')
  fields_text <- paste0('fields=[,', fields_text, ',]')
  filters_text <- filters_to_text_query(filters)

  out <- paste(limit_text, fields_text, filters_text, sep = '&')
}
