context("test-create_json_body.R")
root_url <- "http://ddh1stg.prod.acquia-sites.com"

dkanr::dkanr_setup(url = root_url)
lovs <- ddhconnect::get_lovs()

# httptest::start_capturing(path = './tests/testthat')
# get_lovs()
# get_fields()
# httptest::stop_capturing()

test_that("title field update works", {
  body <- create_json_body(list("title" = "Test Create JSON",
                                "type" = "resource"),
                           json_formats = ddhconnect::resource_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$type <- "resource"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("text field update works", {
  body <- create_json_body(list("body" = "Test Body",
                                "type" = "dataset"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$body$und <- vector("list", length = 1)
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid field update works", {
  body <- create_json_body(list("field_topic" = "Energy and Extractives",
                                "type" = "dataset"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$field_topic$und <- list( list("tid" = "366"))
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("multiple tid value update works", {
  body <- create_json_body(list("field_topic" = c("Energy and Extractives", "Poverty"),
                                "type" = "dataset"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$field_topic$und <- list(list("tid" = "366"),list("tid" = "376"))
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid values", {
  error_msg <- paste0("Invalid value for field_topic",
                      ". The valid values are:\n")
  expect_error(create_json_body(list("field_topic" = c("Energy and Extractives", "Topic123")),
                                json_formats = ddhconnect::dataset_json_format_lookup,
                                lovs = lovs),
               paste0(error_msg, ".*"))
})

test_that("upi field update works", {
  body <- create_json_body(values = list("field_wbddh_dsttl_upi" = "46404",
                                         "type" = "dataset"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("multiple field update works", {
  body = create_json_body(list("title" = "Test Create JSON",
                               "body" = "Test Body",
                               "field_topic" = "Energy and Extractives",
                               "field_wbddh_dsttl_upi" = "46404",
                               "type" = "dataset"),
                          json_formats = ddhconnect::dataset_json_format_lookup,
                          lovs = lovs)
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$field_topic$und <- list("366")
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("can handle multiple values", {
  body <- create_json_body(values = list("field_tags" = c("Africa", "ALADI", "ANDEAN", "ANZCERTA"),
                                         "type" = "dataset"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$field_tags$und$value_field <- "\"\"Africa\"\" \"\"ALADI\"\" \"\"ANDEAN\"\" \"\"ANZCERTA\"\""
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})


test_that("multiple resource fields generates body", {
  body <- create_json_body(values = list("title" = "Test Resource Title",
                                         "body" = "Test Resource Body",
                                         "field_wbddh_data_class" = "Public",
                                         "field_wbddh_resource_type" = "Resource Type not specified",
                                         "field_format" = "Format Not Specified",
                                         "field_link_api" = "www.google.com",
                                         "field_ddh_harvest_src" = "Finances",
                                         "field_ddh_harvest_sys_id" = "8675309",
                                         "type" = "resource"),
                           json_formats = ddhconnect::resource_json_format_lookup,
                           lovs = lovs)
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
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("map_metadata_excel works", {

  body <- create_json_body(map_metadata_excel("../../data-raw/test-map_metadata_excel.xlsx"),
                           json_formats = ddhconnect::dataset_json_format_lookup,
                           lovs = lovs)
  json_template <- list()
  json_template$title <- "TEST TITLE"
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  # json_template$type <- "dataset" #leaving out due to change in func and parameters
  json_template$workflow_status <- "published"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)

  expect_equal(body, json_string)
})
