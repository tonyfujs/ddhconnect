library(jsonlite)

attach_resources_template <- fromJSON('./data-raw/attach_single_resource_schema.json', simplifyVector = FALSE)

# Save data
devtools::use_data(attach_resources_template,
                  overwrite = TRUE)
