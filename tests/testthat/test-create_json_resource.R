context("test-create_json_resource.R")

root_url <- "https://newdatacatalogstg.worldbank.org"
dkanr::dkanr_setup(url = root_url)
ddh_fields <- ddhconnect::get_fields()
lovs <- ddhconnect::get_lovs()
publication_status <- "published"


# httptest::start_capturing(path = './tests/testthat')
# get_lovs()
# get_fields()
# httptest::stop_capturing()

test_that("basic resource json body builds correctly", {
  body <- create_json_resource(values = list("title" = "Test Resource Title",
                                             "body" = "Test Resource Body",
                                             "field_wbddh_data_class" = "Public",
                                             "field_wbddh_resource_type" = "Resource Type not specified",
                                             "field_format" = "Format Not Specified",
                                             "field_link_api" = "www.google.com",
                                             "field_ddh_harvest_src" = "Finances",
                                             "field_ddh_harvest_sys_id" = "8675309"),
                              publication_status, ddh_fields, lovs, root_url)
  json_template <- list()
  json_template$title <- "Test Resource Title"
  json_template$body$und[[1]]$value <- "Test Resource Body"
  json_template$field_wbddh_data_class$und$tid <- "358"
  json_template$field_wbddh_resource_type$und$tid <- "877"
  json_template$field_link_api$und[[1]]$url <- "www.google.com"
  json_template$type <- "resource"
  json_template$field_format$und$tid <- "1271"
  json_template$field_ddh_harvest_src$und$tid <- "1015"
  json_template$field_ddh_harvest_sys_id$und[[1]]$value <- "8675309"
  json_template$workflow_status <- "published"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("basic resource json body builds correctly with unpublished", {
  body <- create_json_resource(values = list("title" = "Test Resource Title",
                                             "body" = "Test Resource Body",
                                             "field_wbddh_data_class" = "Public"),
                              publication_status = "unpublished",
                              ddh_fields, lovs, root_url)
  json_template <- list()
  json_template$title <- "Test Resource Title"
  json_template$body$und[[1]]$value <- "Test Resource Body"
  json_template$field_wbddh_data_class$und$tid <- "358"
  json_template$type <- "resource"
  json_template$workflow_status <- "unpublished"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid field names", {
  resource_fields <- ddhconnect::get_fields(root_url = root_url)
  fields <- unique(resource_fields$machine_name[resource_fields$node_type == "resource"])
  invalid_fields <- c("field_invalid_test")
  error_msg <- paste0("Invalid fields: ",
                      paste(invalid_fields, collapse = "\n"),
                      "\nPlease choose a valid field from:\n",
                      paste(fields, collapse = "\n"))
  expect_error(create_json_resource(list("field_invalid_test" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg, ".*"))
})

test_that("tid fields update fails well for invalid values", {
  list_value_names <- lovs$list_value_name[lovs$machine_name == "field_wbddh_data_class"]
  error_msg <- paste0("Invalid value for field_wbddh_data_class. The valid values are:\n",
                      paste(list_value_names, collapse = "\n"))
  expect_error(create_json_resource(list("field_wbddh_data_class" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg, ".*"))
})
