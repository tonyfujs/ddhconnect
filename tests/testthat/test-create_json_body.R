context("test-create_json_body.R")

test_that("title field update works", {
  body <- create_json_body(c("title"="Test Create JSON"))
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("text field update works", {
  body = create_json_body(c("body"="Test Body"))
  json_template <- list()
  json_template$body$und <- vector("list", length = 1)
  json_template$body$und[[1]]$value <- "Test Body"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("tid field update works", {
  body = create_json_body(c("field_topic"="366"))
  json_template <- list()
  json_template$field_topic$und <- list("366")
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("upi field update works", {
  body = create_json_body(c("field_wbddh_dsttl_upi"="46404"))
  json_template <- list()
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("multiple tid values update works", {
  body = create_json_body(c("title"="Test Create JSON", "body"="Test Body",
                            "field_topic"="366", "field_wbddh_dsttl_upi"="46404"))
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$field_topic$und <- list("366")
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})
