context("test-create_json_dataset.R")

root_url <- "http://ddh1stg.prod.acquia-sites.com/"
# use regular log in
# dkanr::dkanr_setup(url = root_url)
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
  json_template$field_topic$und <- list(list("tid" = "366"),list("tid" = "376"))
  json_template$field_wbddh_dsttl_upi$und <- list(list("target_id" = "46404"))
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
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
  json_template$field_topic$und <- list(list("tid" = "366"),list("tid" = "376"))
  json_template$field_wbddh_dsttl_upi$und <- list(list("target_id" = "46404"))
  json_template$moderation_next_state <- "unpublished"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid field names", {
  # fields <- unique(ddhconnect::get_fields(root_url = root_url)$machine_name)
  
  invalid_fields <- c("field_invalid_test")
  
  error_msg_1 <- paste0("Invalid fields: ",
                      paste(invalid_fields, collapse = "\n"))
  
  # error_msg_2 <- paste0("Please choose a valid field from:\n",
  #                       paste(fields, collapse = "\n"))
  
  
  expect_error(create_json_dataset(list("field_invalid_test" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg_1, ".*"))
})

test_that("tid fields update fails well for invalid values", {
  list_value_names <- lovs$list_value_name[lovs$machine_name == "field_topic"]
  error_msg <- paste0("Invalid value for field_topic. The valid values are:\n",
                      paste(list_value_names, collapse = "\n"))
  expect_error(create_json_dataset(list("field_topic" = c("Energy and Extractives", "Topic123")),
                                   publication_status, ddh_fields, lovs, root_url),
               paste0(error_msg, ".*"))
})

acquia_body <- list(
  "body" = "Description of an API test dataset",
  "field_exception_s" = "1. Personal Information of Bank Staff",
  "field_frequency" = "Month",
  "field_granularity_list" = "National",
  "field_license_wbddh" = "License not Applicable (AMS 6.21A)",
  "field_tags" = list("ddh", "Governance"),
  "field_topic" = list("Fragility, Conflict and Violence", "Agriculture and Food Security"),
  "field_wbddh_base_period" = "2017-01-15 12:01:01",
  "field_wbddh_collaborator_upi" = list("35258", "743"),
  "field_wbddh_country" = list("American Samoa", "Andorra"),
  "field_wbddh_data_class" = "Official Use Only",
  "field_wbddh_data_type" = "Microdata",
  "field_wbddh_dsttl_upi" = list("741", "1"),
  "field_wbddh_ds_embargo_date" = "2017-01-12 15:01:01",
  "field_wbddh_economy_coverage" = list("IBRD", "Blend"),
  "field_wbddh_end_date" = "2017-01-14 13:01:01",
  "field_wbddh_languages_supported" = "Abkhaz",
  "field_wbddh_modified_date" = "2017-01-10 17:01:01",
  "field_wbddh_next_expected_update" = "2017-01-16 11:01:01",
  "field_wbddh_release_date" = "2017-01-11 16:01:01",
  "field_wbddh_responsible" = "No",
  "field_wbddh_start_date" = "2017-01-13 14:01:01",
  "field_wbddh_version_date" = "2017-01-17 10:01:01",
  "title" = "Test Create JSON"
)
test_that("correct body for acquia", {
  body <- create_json_dataset(values = acquia_body,
                              publication_status, ddh_fields, lovs, root_url)
  # json_template <- list()
  # json_template$title <- "Test Create JSON"
  # json_template$field_topic$und <- list("366", "376")
  # json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  # json_template$type <- "dataset"
  # json_template$workflow_status <- "published"
  # json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  # expect_equal(body, json_string)
})
