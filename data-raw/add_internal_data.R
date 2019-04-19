library(jsonlite)

attach_resources_template <- fromJSON('./data-raw/attach_single_resource_schema.json', simplifyVector = FALSE)

production_root_url <- 'https://datacatalog.worldbank.org'
stg_root_url <- 'http://ddh1stg.prod.acquia-sites.com'

test_dataset_update_json  <- fromJSON('data-raw/test_dataset_update.json', simplifyVector = FALSE)
test_resource_update_json <- fromJSON('data-raw/test_resource_update.json', simplifyVector = FALSE)

mandatory_text_fields <- readLines('data-raw/mandatory_text_fields.txt')

dataset_json_format_lookup      <- read.csv("./data-raw/dataset_json_format_lookup.csv", stringsAsFactors = FALSE)
resource_json_format_lookup     <- read.csv("./data-raw/resource_json_format_lookup.csv", stringsAsFactors = FALSE)
blank_fields_json_format_lookup <- read.csv("./data-raw/blank_fields_json_format_lookup.csv", stringsAsFactors = FALSE)

names(dataset_json_format_lookup)       <- c("machine_names", "json_template")
names(resource_json_format_lookup)      <- c("machine_names", "json_template")
names(blank_fields_json_format_lookup)  <- c("machine_names", "json_template")

machine_names_multiple_values <- read.csv("./data-raw/machine_names_multiple_values.csv", stringsAsFactors = FALSE)
ui_names_lookup <- read.csv("./data-raw/ui_names_lookup.csv", stringsAsFactors = FALSE)
names(ui_names_lookup) <- c("machine_names", "ui_names")

gs_required_fields <- read.csv("./data-raw/gs_required_fields.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)
md_required_fields <- read.csv("./data-raw/md_required_fields.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)
ts_required_fields <- read.csv("./data-raw/ts_required_fields.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)
other_required_fields <- read.csv("./data-raw/other_required_fields.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE)

# Save data
usethis::use_data(attach_resources_template,
                  test_dataset_update_json,
                  test_resource_update_json,
                  ui_names_lookup,
                  overwrite = TRUE)

usethis::use_data(production_root_url,
                  stg_root_url,
                  mandatory_text_fields,
                  overwrite = TRUE,
                  internal = TRUE)

usethis::use_data(dataset_json_format_lookup,
                  resource_json_format_lookup,
                  blank_fields_json_format_lookup,
                  overwrite = TRUE)

usethis::use_data(gs_required_fields,
                  md_required_fields,
                  ts_required_fields,
                  other_required_fields,
                  overwrite = TRUE)
