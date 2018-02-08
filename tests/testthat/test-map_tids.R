# context("map strings to tids")
#
#
# # login required before running tests due to get_lovs
# springsteen <- c("thunder" = "road",
#                  "born" = "to run",
#                  "dancing" = "in the dark")
# test_that("Vector should not change when it contains no lov fields", {
#   expect_equal(
#     map_tids(springsteen),
#     springsteen)
# })
#
#
# old <- c("field_wbddh_gps_ccsas" = "Gender")
# new <- c("field_wbddh_gps_ccsas" = "432")
# test_that("Single vector", {
#   expect_equal(map_tids(old), new)
# })
#
#
#
# old_springsteen <- c("thunder" = "road",
#                      "born" = "to run",
#                      "dancing" = "in the dark",
#                      "field_wbddh_gps_ccsas" = "GeNDeR",
#                      "field_wbddh_ds_source" = "Academia",
#                      "field_ddh_harvest_src" = "finances",
#                      "field_wbddh_country" = "AUSTRIA")
# new_springsteen <- c("thunder" = "road",
#                      "born" = "to run",
#                      "dancing" = "in the dark",
#                      "field_wbddh_gps_ccsas" = "432",
#                      "field_wbddh_ds_source" = "949",
#                      "field_ddh_harvest_src" = "1015",
#                      "field_wbddh_country" = "48")
# test_that("Multiple lov fields with different caps values", {
#   expect_equal(
#     map_tids(old_springsteen),
#     new_springsteen)
# })
#
#
#
# old_springsteen <- c("thunder" = "road",
#                      "born" = "to run",
#                      "dancing" = "in the dark",
#                      "field_tags"= "Rainfall;Water;Urban Growth",
#                      "field_wbddh_country" = "canada;Europe & Central Asia;ARMENIA")
# new_springsteen <- c("thunder" = "road",
#                      "born" = "to run",
#                      "dancing" = "in the dark",
#                      "field_tags" = "1237;1235;1240",
#                      "field_wbddh_country" = "73;841;45")
# test_that("Multiple lov fields that can take multiple values", {
#   expect_equal(
#     map_tids(old_springsteen),
#     new_springsteen)
# })
