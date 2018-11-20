library(testthat)
context("test-metadata_list_values_to_df.R")

# constants
lovs_df <- ddhconnect::get_lovs()

# tests
test_that("metadata with no lovs machine names returns empty df", {
  dataset_metadata <- list("field_topic" = c("thank", "you", "next"),
                           "field_wbddh_data_class" = "test")

  out_df <- data.frame("machine_name" = c("field_topic", "field_topic", "field_topic", "field_wbddh_data_class"),
                       "list_value_name" = c("thank", "you", "next", "test"),
                       stringsAsFactors = FALSE)
  expect_identical(
    ddhconnect:::metadata_list_values_to_df(metadata = dataset_metadata, lovs_df),
    out_df
    )
})

test_that("metadata with no lovs machine names returns empty df", {
  dataset_metadata <- list(thank_you = "next",
                           no_tears = c("left", "to", "cry"))
  temp <- ddhconnect:::metadata_list_values_to_df(metadata = dataset_metadata, lovs_df)
  expect_equal(nrow(temp), 0)
})
