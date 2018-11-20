context("test-create_json_dataset.R")

root_url <- "https://newdatacatalogstg.worldbank.org"
dkanr::dkanr_setup(url = root_url)
ddh_fields <- ddhconnect::get_fields()
lovs <- ddhconnect::get_lovs()
publication_status <- "published"


# httptest::start_capturing(path = './tests/testthat')
# get_lovs()
# get_fields()
# httptest::stop_capturing()

# TODO: add tests for multiple values when we get the format back

test_that("basic dataset json body builds correctly", {
  body <- create_json_dataset(values = list("title" = "Test Create JSON",
                                            "field_topic" = c("Energy and Extractives", "Poverty"),
                                            "field_wbddh_dsttl_upi" = "46404"),
                              publication_status, ddh_fields, lovs, root_url)
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$field_topic$und <- list("366", "376")
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_template$workflow_status <- "published"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("basic dataset json body builds correctly with unpublished", {
  body <- create_json_dataset(values = list("title" = "Test Create JSON",
                                            "field_topic" = c("Energy and Extractives", "Poverty"),
                                            "field_wbddh_dsttl_upi" = "46404"),
                              publication_status = "unpublished",
                              ddh_fields, lovs, root_url)
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$field_topic$und <- list("366", "376")
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_template$workflow_status <- "unpublished"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid field names", {
  fields <- unique(ddhconnect::get_fields(root_url = root_url)$machine_name)
  invalid_fields <- c("field_invalid_test")
  error_msg <- paste0("Invalid fields: ",
                      paste(invalid_fields, collapse = "\n"),
                      "\nPlease choose a valid field from:\n",
                      paste(fields, collapse = "\n"))
  expect_error(create_json_dataset(list("field_invalid_test" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg, ".*"))
})

test_that("tid fields update fails well for invalid values", {
  list_value_names <- lovs$list_value_name[lovs$machine_name == "field_topic"]
  error_msg <- paste0("Invalid value for field_topic. The valid values are:\n",
                      paste(list_value_names, collapse = "\n"))
  expect_error(create_json_dataset(list("field_topic" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg, ".*"))
})
