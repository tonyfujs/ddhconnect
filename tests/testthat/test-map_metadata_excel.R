context("test-map_metadata_excel.R")
root_url <- "https://newdatacatalogstg.worldbank.org"

dkanr::dkanr_setup(url = root_url)

test_that("multiple field lookup works", {
  machine_name_values <- map_metadata_excel("../../data-raw/test-map_metadata_excel.xlsx")
  updated_resource_data <-  c("body" = "Test Body",
                              "field_wbddh_dsttl_upi" = "46404",
                              "title" = "TEST TITLE",
                              "workflow_status" = "published")
  expect_equal(machine_name_values, updated_resource_data)
})


test_that("Mapping warning with invalid Metadata Field is present with value", {
  warning_message <- paste0("The following Metadata fields are invalid, and won't be mapped to the appropriate machine_name: MISS")
  expect_warning(map_metadata_excel("../../data-raw/test-map_metadata_excel.xlsx"), warning_message)
})
