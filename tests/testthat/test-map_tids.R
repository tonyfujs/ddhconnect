context("map strings to tids")
root_url <- "https://newdatacatalogstg.worldbank.org"

dkanr::dkanr_setup(url = root_url)

# httptest::start_capturing(path = './tests/testthat')
# get_lovs()
# httptest::stop_capturing()

springsteen <- list("thunder" = "road",
                    "born" = "to run",
                    "dancing" = "in the dark")
test_that("Vector should not change when it contains no lov fields", {
  expect_equal(
    map_tids(springsteen),
    springsteen)
})


old <- list("field_wbddh_gps_ccsas" = "Gender")
new <- list("field_wbddh_gps_ccsas" = "432")
test_that("Single lov field works", {
  expect_equal(map_tids(old), new)
})



old_springsteen <- list("thunder" = "road",
                     "born" = "to run",
                     "dancing" = "in the dark",
                     "field_wbddh_gps_ccsas" = "Gender",
                     "field_wbddh_ds_source" = "Academia",
                     "field_ddh_harvest_src" = "Finances",
                     "field_wbddh_country" = "Albania",
                     "field_wbddh_data_class" = "Public")
new_springsteen <- list("thunder" = "road",
                     "born" = "to run",
                     "dancing" = "in the dark",
                     "field_wbddh_gps_ccsas" = "432",
                     "field_wbddh_ds_source" = "949",
                     "field_ddh_harvest_src" = "1015",
                     "field_wbddh_country" = "36",
                     "field_wbddh_data_class" = "358")
test_that("Multiple lov fields works", {
  expect_equal(
    map_tids(old_springsteen),
    new_springsteen)
})



old_springsteen <- list("thunder" = "road",
                     "born" = "to run",
                     "dancing" = "in the dark",
                     "field_tags"= c("Rainfall", "Water", "Urban Growth"),
                     "field_wbddh_country" = c("Canada", "Europe & Central Asia", "Armenia"))
new_springsteen <- list("thunder" = "road",
                     "born" = "to run",
                     "dancing" = "in the dark",
                     "field_tags" = c("1237","1235","1240"),
                     "field_wbddh_country" = c("73","841","45"))
test_that("Multiple lov fields that can take multiple values works", {
  expect_equal(
    map_tids(old_springsteen),
    new_springsteen)
})

test_that("map_tids fails well for invalid list values", {
  lovs <- get_lovs(root_url = root_url)
  error_msg <- paste0("Invalid value for field_topic",
                      ". The valid values are:\n")
  expect_error(create_json_body(list("field_topic"=c("Energy and Extractives", "Topic123")), node_type = "dataset"),
               paste0(error_msg, ".*"))
})
