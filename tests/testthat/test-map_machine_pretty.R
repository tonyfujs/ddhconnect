context("test-map_metadata_excel.R")
root_url <- "https://newdatacatalogstg.worldbank.org"

dkanr::dkanr_setup(url = root_url)

test_that("mapping for machine_name to pretty_name works", {
  machine <- c("field_wbddh_dsttl_upi","body","title")
  mapped_values <- map_machine_pretty(machine, "machine", "pretty")
  pretty_values <- c("ttl_name","description","resource_description","title","resource_title")
  pretty_values <- data.frame(pretty_values)
  colnames(pretty_values) <- "pretty_name"
  pretty_values[] <- lapply(pretty_values, as.character)
  expect_equal(mapped_values,pretty_values)
})

test_that("mapping for pretty_name to machine_name works", {
  pretty <- c("ttl_name","description","resource_description","title","resource_title")
  mapped_values <- map_machine_pretty(pretty, "pretty", "machine")
  machine_values <- c("field_wbddh_dsttl_upi","body","body","title","title")
  machine_values <- data.frame(machine_values)
  colnames(machine_values) <- "machine_name"
  machine_values[] <- lapply(machine_values, as.character)
  expect_equal(mapped_values,machine_values)
})

test_that("Mapping warning with invalid data passed", {
  warning_message <- paste0("The following fields could not be mapped: INVALID")
  invalid_values <- c("field_wbddh_dsttl_upi","body","INVALID")
  expect_warning(map_machine_pretty(invalid_values, "machine", "pretty"), warning_message)
})
