context("test-create_json_body.R")
root_url <- "https://datacatalog.worldbank.org"

# start_capturing(path = './tests/testthat')
# get_lovs()
# stop_capturing()

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

test_that("tid fields update fail well", {
  body <- create_json_body(list("field_topic"=c("Energy and Extractives", "Poverty")), node_type = "dataset")
  json_template <- list()
  json_template$field_topic$und <- list("366")
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
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

