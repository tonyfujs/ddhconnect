context("test-create_json_body.R")
root_url <- "https://datacatalog.worldbank.org"

test_that("title field update works", {
  body <- create_json_body(values = c("title" = "Test Create JSON"),
                           node_type = "dataset",
                           root_url = root_url)
  json_template <- list()
  json_template$title <- "Test Create JSON"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

test_that("text field update works", {
  body <- create_json_body(values = c("body" = "Test Body"),
                          node_type = "dataset",
                          root_url = root_url)
  json_template <- list()
  json_template$body$und <- vector("list", length = 1)
  json_template$body$und[[1]]$value <- "Test Body"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})
# TID fields require call to get_lovs()
# test_that("tid field update works", {
#   body <- create_json_body(values = c("field_topic" = "366"),
#                           node_type = "dataset",
#                           root_url = root_url)
#   json_template <- list()
#   json_template$field_topic$und <- list("366")
#   json_template$type <- "dataset"
#   json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
#   expect_equal(body, json_string)
# })

test_that("upi field update works", {
  body <- create_json_body(values = c("field_wbddh_dsttl_upi" = "46404"),
                          node_type = "dataset",
                          root_url = root_url)
  json_template <- list()
  json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})
# TID fields require call to get_lovs()
# test_that("multiple values update works", {
#   body <- create_json_body(values = c("title" = "Test Create JSON",
#                                      "body" = "Test Body",
#                                      "field_topic" = "366",
#                                      "field_wbddh_dsttl_upi" = "46404"),
#                           node_type = "dataset",
#                           root_url = root_url)
#   json_template <- list()
#   json_template$title <- "Test Create JSON"
#   json_template$body$und[[1]]$value <- "Test Body"
#   json_template$field_topic$und <- list("366")
#   json_template$field_wbddh_dsttl_upi$und$autocomplete_hidden_value <- "46404"
#   json_template$type <- "dataset"
#   json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
#   expect_equal(body, json_string)
# })
