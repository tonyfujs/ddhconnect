library(jsonlite)

attach_resources_template <- fromJSON('./data-raw/attach_single_resource_schema.json', simplifyVector = FALSE)

# Save data
devtools::use_data(attach_resources_template,
                  overwrite = TRUE)



target_id$field_resources$und[[1]]$target_id <- jsonlite::unbox('Resource 1 (0000)')
toJSON(target_id, pretty = TRUE)

temp <- list(fi)


x <- list(target_id = "")
template$field_resources$und <- rep(template$field_resources$und, 2)
test <-
