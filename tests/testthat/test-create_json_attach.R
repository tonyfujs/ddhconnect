context("test-create_json_attach.R")

json_template <- list()
json_template$workflow_status <- jsonlite::unbox("published")

test_that("single resource works", {
  json_template$field_resources$und <- vector("list", length = 1)
  json_template$field_resources$und[[1]]$target_id <- "Greater than 3 MB file (125939)"
  expect_equal(create_json_attach(resource_nids = 125939), jsonlite::toJSON(json_template, auto_unbox = T, pretty = T))
})

test_that("multiple resources work", {
  json_template$field_resources$und <- vector("list", length = 2)
  json_template$field_resources$und[[1]]$target_id <- "Greater than 3 MB file (125939)"
  json_template$field_resources$und[[2]]$target_id <- "Less than 3 MB file (125938)"

  expect_equal(create_json_attach(resource_nids = c(125939, 125938)), jsonlite::toJSON(json_template, auto_unbox = T, pretty = T))
})
