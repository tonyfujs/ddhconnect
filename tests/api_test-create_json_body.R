library(testthat)

credentials <- list(cookie = dkanr::get_cookie(), token = dkanr::get_token())
url <- dkanr::get_url()
nid <- 79069

test_that("title field update works", {
  body = create_json_body(c("title"="Test Create JSON"))
  update_dataset(credentials = credentials, nid = nid, body = body, root_url = url)
  node_metadata <- get_metadata(nid = nid, credentials = credentials, root_url = url)
  expect_equal(node_metadata$title, "Test Create JSON")
})

test_that("text field update works", {
  body = create_json_body(c("body"="Test Body"))
  update_dataset(credentials = credentials, nid = nid, body = body, root_url = url)
  node_metadata <- get_metadata(nid = nid, credentials = credentials, root_url = url)
  expect_equal(node_metadata$body$und[[1]]$value, "Test Body")
})

test_that("tid field update works", {
  body = create_json_body(c("field_topic"="366"))
  update_dataset(credentials = credentials, nid = nid, body = body, root_url = url)
  node_metadata <- get_metadata(nid = nid, credentials = credentials, root_url = url)
  expect_equal(node_metadata$field_topic$und[[1]]$tid, "366")
})

test_that("upi field update works", {
  body = create_json_body(c("field_wbddh_dsttl_upi"="123"))
  update_dataset(credentials = credentials, nid = nid, body = body, root_url = url)
  node_metadata <- get_metadata(nid = nid, credentials = credentials, root_url = url)
  expect_equal(node_metadata$field_wbddh_dsttl_upi$und[[1]]$value, "123")
})

test_that("multiple tid values update works", {
  body = create_json_body(c("field_topic"="366"))
  update_dataset(credentials = credentials, nid = nid, body = body, root_url = url)
  node_metadata <- get_metadata(nid = nid, credentials = credentials, root_url = url)
  expect_equal(node_metadata$field_topic$und[[1]]$tid, "366")
})
