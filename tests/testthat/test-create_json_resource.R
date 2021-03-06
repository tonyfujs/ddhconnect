context("test-create_json_resource.R")

root_url <- "http://ddh1stg.prod.acquia-sites.com"

# Make sure enviroment variables for stg username and passowrd are setup
dkanr::dkanr_setup(url = root_url,
                   username = Sys.getenv("ddh_username"),
                   password = Sys.getenv("ddh_stg_password"))


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
                              publication_status = publication_status,
                              ddh_fields = ddh_fields, 
                              lovs = lovs, 
                              root_url = root_url)
  json_template <- list()
  json_template$title <- "Test Resource Title"
  json_template$body$und[[1]]$value <- "Test Resource Body"
  json_template$field_dataset_ref$und <- list(list("target_id" = "111"))
  json_template$field_ddh_harvest_src$und <- list(list("tid" = "1015"))
  json_template$field_ddh_harvest_sys_id$und[[1]]$value <- "8675309"
  json_template$field_format$und <- list(list("tid" = "1271"))
  json_template$field_link_api$und[[1]]$url <- "www.google.com"
  json_template$field_wbddh_data_class$und <- list(list("tid" = "358"))
  json_template$field_wbddh_resource_type$und <- list(list("tid" = "877"))
  json_template$type <- "resource"
  json_template$moderation_next_state <- "published"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("basic resource json body builds correctly with unpublished", {
  body <- create_json_resource(values = list("title" = "Test Resource Title",
                                             "body" = "Test Resource Body",
                                             "field_wbddh_data_class" = "Public"),
                              publication_status = "unpublished",
                              ddh_fields = ddh_fields,
                              lovs = lovs,
                              root_url = root_url)
  json_template <- list()
  json_template$title <- "Test Resource Title"
  json_template$body$und[[1]]$value <- "Test Resource Body"
  json_template$field_dataset_ref$und <- list(list("target_id" = "111"))
  json_template$field_wbddh_data_class$und <- list(list("tid" = "358"))
  json_template$type <- "resource"
  json_template$moderation_next_state <- "unpublished"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid field names", {
  resource_fields <- ddh_fields
  fields <- unique(resource_fields$machine_name[resource_fields$node_type == "resource"])
  invalid_fields <- c("field_invalid_test")
  error_msg <- paste0("Invalid fields: ",
                      paste(invalid_fields, collapse = "\n"),
                      "\nPlease choose a valid field from:\n",
                      paste(fields, collapse = "\n"))
  expect_error(create_json_resource(list("field_invalid_test" = c("Energy and Extractives", "Topic123")),
                                    publication_status = publication_status,
                                    ddh_fields = ddh_fields, lovs = lovs,
                                    root_url = root_url),
               paste0(error_msg, ".*"))
})

test_that("tid fields update fails well for invalid values", {
  list_value_names <- lovs$list_value_name[lovs$machine_name == "field_wbddh_data_class"]
  error_msg <- paste0("Invalid value for field_wbddh_data_class. The valid values are:\n",
                      paste(list_value_names, collapse = "\n"))
  expect_error(create_json_resource(list("field_wbddh_data_class" = c("Energy and Extractives", "Topic123")),
                                   publication_status = publication_status,
                                   ddh_fields = ddh_fields, lovs = lovs,
                                   root_url = root_url),
               paste0(error_msg, ".*"))
})

acquia_resource <- c(
  "body" = "have yourself a merry little christmas",
  "field_dataset_ref" = "159981",
  "field_wbddh_data_class" = "Public",
  "field_wbddh_resource_type" = "API",
  "title" = "judy garland"
)

test_that("correct body for acquia", {
  body <- create_json_resource(values = acquia_resource,
                               publication_status = publication_status,
                               dataset_nid = "159981",
                               ddh_fields = ddh_fields,
                               lovs = lovs,
                               root_url = root_url)
  # json_template <- list()
  # json_template$title <- "Test Create JSON"
  # json_template$field_topic$und <- list("366", "376")
  # json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  # json_template$type <- "dataset"
  # json_template$workflow_status <- "published"
  # json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  # expect_equal(body, json_string)
})


