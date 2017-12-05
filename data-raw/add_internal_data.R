library(jsonlite)

attach_resources_template <- fromJSON('./data-raw/attach_single_resource_schema.json', simplifyVector = FALSE)

production_root_url <- 'https://datacatalog.worldbank.org'
stg_root_url <- 'https://newdatacatalogstg.worldbank.org/'

test_dataset_update_json <- fromJSON('data-raw/test_dataset_update.json', simplifyVector = FALSE)
test_resource_update_json <- fromJSON('data-raw/test_resource_update.json', simplifyVector = FALSE)

mandatory_text_fields <- readLines('data-raw/mandatory_text_fields.txt')

dataset_json_format_lookup <- read.csv("./data-raw/dataset_json_format_lookup.csv", stringsAsFactors = FALSE)

# Save data
devtools::use_data(attach_resources_template,
                   test_dataset_update_json,
                   test_resource_update_json,
                   overwrite = TRUE)

devtools::use_data(production_root_url,
                   stg_root_url,
                   mandatory_text_fields,
                   overwrite = TRUE,
                   internal = TRUE)

devtools::use_data(dataset_json_format_lookup, overwrite = TRUE)
