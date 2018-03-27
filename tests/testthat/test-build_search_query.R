context("test-build_search_query.R")

test_that("single field works", {
  expect_equal(build_search_query(fields = "nid"),
               "limit=200&fields=[,nid,]&")
})

test_that("multiple fields works", {
  expect_equal(build_search_query(fields = c("nid", "uuid", "title")),
               "limit=200&fields=[,nid,uuid,title,]&")
})

test_that("single filter works", {
  expect_equal(build_search_query(filters = c("field_wbddh_data_type" = 294)),
               "limit=200&fields=[,,]&filter[field_wbddh_data_type]=294")
})

test_that("multiple filters works", {
  expect_equal(build_search_query(filters = c("field_wbddh_data_type" = 294,
                                              "status" = 1)),
               "limit=200&fields=[,,]&filter[field_wbddh_data_type]=294&
               filter[status]=1")
})

test_that("string filter value works", {
  expect_equal(
    build_search_query(filters = c("field_wbddh_data_type" = "Microdata")),
    "limit=200&fields=[,,]&filter[field_wbddh_data_type]=Microdata"
  )
})

test_that("combination of fields, filters and limit works", {
  expect_equal(build_search_query(fields = c("nid", "uuid", "title",
                                             "field_contact_email",
                                             "field_wbddh_data_type",
                                             "status"),
                                  filters = c("field_wbddh_data_type" = 294,
                                              "status" = 1),
                                  limit = 100),
               "limit=100&fields=[,nid,uuid,title,field_contact_email,
               field_wbddh_data_type,status,]&filter[field_wbddh_data_type]=294&
               filter[status]=1")
})
