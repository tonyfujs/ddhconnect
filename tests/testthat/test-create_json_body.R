context("test-create_json_body.R")
root_url <- "https://datacatalog.worldbank.org"

dkanr::dkanr_setup(url = 'https://datacatalog.worldbank.org/')

# httptest::start_capturing(path = './tests/testthat')
# get_lovs()
# get_fields()
# httptest::stop_capturing()

test_that("title field update works", {

  body <- create_json_body(list("title"="Test Create JSON"), node_type = "resource")
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$type <- "resource"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("text field update works", {
  body <- create_json_body(list("body"="Test Body"), node_type = "dataset")
  json_template <- list()
  json_template$body$und <- vector("list", length = 1)
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid field update works", {
  body <- create_json_body(list("field_topic"="Energy and Extractives"), node_type = "dataset")
  json_template <- list()
  json_template$field_topic$und <- list("366")
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("multiple tid value update works", {
  body <- create_json_body(list("field_topic"=c("Energy and Extractives", "Poverty")), node_type = "dataset")
  json_template <- list()
  json_template$field_topic$und <- list("366", "376")
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid fields update fails well for invalid field names", {
  fields <- unique(get_fields(root_url = root_url)$machine_name)
  invalid_fields <- c("field_invalid_test")
  error_msg <- paste0("Invalid fields: ", paste(invalid_fields, collapse = "\n"),
                      "\nPlease choose a valid field from:\n")
  expect_error(create_json_body(list("field_invalid_test"=c("Energy and Extractives", "Topic123")), node_type = "dataset"),
               paste0(error_msg, ".*"))
})

test_that("tid fields update fails well for invalid values", {
  lovs <- get_lovs(root_url = root_url)
  error_msg <- paste0("Invalid value for field_topic",
                      ". The valid values are:\n")
  expect_error(create_json_body(list("field_topic"=c("Energy and Extractives", "Topic123")), node_type = "dataset"),
               paste0(error_msg, ".*"))
})

test_that("upi field update works", {
  body <- create_json_body(values = list("field_wbddh_dsttl_upi" = "46404"),
                          node_type = "dataset",
                          root_url = root_url)
  json_template <- list()
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("multiple field update works", {
  body = create_json_body(list("title"="Test Create JSON", "body"="Test Body",
                            "field_topic"="Energy and Extractives", "field_wbddh_dsttl_upi"="46404"),
                          node_type = "dataset")
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$field_topic$und <- list("366")
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

