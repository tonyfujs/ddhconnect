context("test-json_body_multiple_values")

values <- list("type" = "resource",
               "test_field" = c("one", "two", "three", "four"),
               "field_tags" = c("one", "two", "three", "four"),
               "preformatted_field" = "one;two;three")

######################################
#CAN'T FIND collapse_multiple_values()
######################################
# test_that("creates correct format for general field", {
#   output <- collapse_multiple_values(values = values, field_name = "test_field")
#   expected <- "one;two;three;four"
#   expect_equal(output, expected)
# })
# 
# test_that("creates correct format for tags", {
#   output <- collapse_multiple_values(values = values, field_name = "field_tags")
#   expected <- "\"\"one\"\" \"\"two\"\" \"\"three\"\" \"\"four\"\""
#   expect_equal(output, expected)
# })
# 
# test_that("does not change preformatted field", {
#   output <- collapse_multiple_values(values = values, field_name = "preformatted_field")
#   expected <- "one;two;three"
#   expect_equal(output, expected)
# })
# 
# test_that("does not change single value", {
#   output <- collapse_multiple_values(values = values, field_name = "type")
#   expected <- "resource"
#   expect_equal(output, expected)
# })

# required_fields <- list(
#   "body" = "multiple values json body",
#   "field_best_bets" = list("something", "else"),
#   "field_license_wbddh" = "Creative Commons Attribution 4.0",
#   "field_topic" = list("Jobs", "Poverty"),
#   "field_frequency" = "Periodicity not specified",
#   # "field_tags" = list("Africa", "ALADI"),
#   "field_wbddh_collaborator_upi" = list("49436", "741"),
#   "field_wbddh_country" = list("Afghanistan", "Albania"),
#   "field_wbddh_dsttl_upi" = list("49436", "741"),
#   "field_wbddh_ds_source" = list("Academia", "Civil Society"),
#   "field_wbddh_data_class" = "Public",
#   "field_wbddh_data_type" = "Other",
#   "field_wbddh_economy_coverage" = list("High Income", "Low Income"),
#   "field_wbddh_economy_coverage" = "Economy Coverage not specified",
#   "field_granularity_list" = list("National", "Regional"),
#   "field_wbddh_languages_supported" = list("English", "Spanish"),
#   "title" = "test multiple values",
#   "type" = "dataset",
#   "workflow_status" = "published"
# )

# temp <- create_json_dataset(required_fields)
