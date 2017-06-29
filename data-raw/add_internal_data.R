library(jsonlite)

attach_resources_template <- fromJSON('./data-raw/attach_single_resource_schema.json', simplifyVector = FALSE)

production_root_url <- 'https://newdatacatalog.worldbank.org'
stg_root_url <- 'https://datacatalogbetastg.worldbank.org/'

# Save data
devtools::use_data(attach_resources_template,
                  overwrite = TRUE)

devtools::use_data(production_root_url,
                   stg_root_url,
                   overwrite = TRUE,
                   internal = TRUE)
