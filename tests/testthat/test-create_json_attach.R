context("test-create_json_attach.R")
root_url <- "https://datacatalog.worldbank.org"

json_template <- list()
json_template$workflow_status <- jsonlite::unbox("published")

test_that("single resource works", {
  json_template$field_resources$und <- vector("list", length = 1)
  json_template$field_resources$und[[1]]$target_id <- "SDG Dashboard (94934)"
  expect_equal(create_json_attach(resource_nids = 94934,
                                  root_url = root_url),
               jsonlite::toJSON(json_template, auto_unbox = T, pretty = T))
})

test_that("multiple resources work", {
  json_template$field_resources$und <- vector("list", length = 2)
  json_template$field_resources$und[[1]]$target_id <- "SDG Dashboard (94934)"
  json_template$field_resources$und[[2]]$target_id <- "API documentation (94935)"

  expect_equal(create_json_attach(resource_nids = c(94934, 94935),
                                  root_url = root_url),
               jsonlite::toJSON(json_template, auto_unbox = T, pretty = T))
})
