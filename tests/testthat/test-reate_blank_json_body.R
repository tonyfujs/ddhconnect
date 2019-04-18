context("test-create_blank_json_body.R")

# Test passing user entity fields (e.g field_wbddh_collaborator_upi)
test_that("Passing entity field works", {
  body <- create_blank_json_body("field_wbddh_collaborator_upi",
                                 type = "dataset",
                                 publication_status = "published"
                           )
  json_template <- list()
  json_template$field_wbddh_collaborator_upi$und <- list()
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

# Test passing taxonomy fields (e.g field_wbddh_gps_ccsas)
test_that("Passing blank taxonomy field works", {
  body <- create_blank_json_body("field_wbddh_gps_ccsas",
                                 type = "dataset",
                                 publication_status = "published"
  )

  json_template <- list()
  json_template$field_wbddh_gps_ccsas$und <- list()
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

# Test passing date fields (e.g field_wbddh_base_period)
test_that("Passing blank date field works", {
  body <- create_blank_json_body("field_wbddh_base_period",
                                 type = "dataset",
                                 publication_status = "published"
  )
  json_template <- list()
  json_template$field_wbddh_base_period$und <- list()
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

# Test passing free text fields (e.g field_wbddh_series_information)
test_that("Passing blank free text field works", {
  body <- create_blank_json_body("field_wbddh_series_information",
                                 type = "dataset",
                                 publication_status = "published"
  )

  json_template <- list()
  json_template$field_wbddh_series_information$und <- list()
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})

# Test passing multiple fields
test_that("Passing multiple blank fields works", {
  body <- create_blank_json_body(c("field_wbddh_series_information","field_wbddh_base_period",
                                   "field_wbddh_collaborator_upi"),
                                 type = "dataset",
                                 publication_status = "published"
  )

  json_template <- list()
  json_template$field_wbddh_base_period$und  <- list()
  json_template$field_wbddh_collaborator_upi$und         <- list()
  json_template$field_wbddh_series_information$und    <- list()
  json_template$moderation_next_state <- "published"
  json_template$type <- "dataset"
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})


# Should return warning with invalid fields being passed
test_that("Passing invalid fields returns warning", {

  values <- c("FAIL_1","FAIL_2")

  expect_warning(create_blank_json_body(values, type = "dataset", publication_status = "published"))
})

# Test passing blank fields for resources (e.g field_ddh_harvest_src)
test_that("Passing resource fields", {
  body <- create_blank_json_body(c("body","field_format",
                                   "field_ddh_harvest_src",
                                   "field_ddh_harvest_sys_id"),
                                 type = "resource",
                                 publication_status = "published"
  )

  json_template           <- list()
  json_template$body$und  <- list()
  json_template$field_ddh_harvest_src$und     <- list()
  json_template$field_ddh_harvest_sys_id$und  <- list()
  json_template$moderation_next_state         <- "published"
  json_template$type                          <- "resource"
  json_template$field_format$und              <- list()
  json_string <- jsonlite::toJSON(json_template, auto_unbox = TRUE)
  expect_equal(body, json_string)
})


