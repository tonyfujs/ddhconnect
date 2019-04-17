#' create_blank_json_body
#'
#' Create the JSON body for updating the given fields or creating a new dataset
#'
#' @param values vector: vector of fields to make blank
#' @param publication_status string: status to post the mode, takes values of c("published", "unpublished", "draft")
#' @param root_url string: API root URL
#' @param type string: indicates whether the JSON body is for a "dataset" or a "resource"
#' @param root_url string: API root URL
#'
#' @return json string
#' @export
#'

create_blank_json_body <- function(values = c("title","body"),
                             publication_status = "published",
                             type = "dataset",
                             root_url = dkanr::get_url()) {

    # Retireve JSON formats
    json_formats <- blank_fields_json_format_lookup

    # Flag invalid fields
    invalid_fields <- values[!values %in% machine_names]
    if(length(invalid_fields)>0){
        warning(paste0("The following invalid fields won't be passed: ",paste0(invalid_fields, collapse = ", ")))
    }

    # Append required fields
    values <- c(values,c("type", "moderation_next_state"))
    machine_names <- json_formats$machine_names
    to_update     <- subset(json_formats, machine_names %in% values)
    json_body     <- list()
    for (i in 1:nrow(to_update)) {
      field_name    <- to_update[i, 1]
      json_template <- jsonlite::fromJSON(to_update[i, 2])
      if(field_name == "moderation_next_state"){
        json_template$moderation_next_state <- publication_status
      } else if(field_name == "type"){
        json_template$type <- type
      }

      json_body[field_name] <- json_template
    }

    return(jsonlite::toJSON(json_body, auto_unbox = T))
}
