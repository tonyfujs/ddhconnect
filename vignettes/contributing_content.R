## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  library(dkanr)
#  library(dhhconnect)
#  dkanr_setup(
#    url = 'http://datacatalog.worldbank.com',
#    username = 'YOUR_USERNAME',
#    password = 'YOUR_PASSWORD'
#  )

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  credentials <- list(cookie = dkanr::get_cookie(), token = dkanr::get_token())
#  get_user_details(credentials, uid = "YOUR_UPI_#")

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  dataset_metadata = c("title" = "YOUR DATASET TITLE",
#                       "field_wbddh_country" = "YOUR DATASET COUNTRY")
#  mapped_values <- map_tids(dataset_metadata)

## ----message = FALSE, warning = FALSE, paged.print = FALSE, eval = FALSE----
#  dataset_json <- create_json_body(values = mapped_values, node_type = “dataset”)
#  create_dataset(credentials, body = dataset_json)

## ----message = FALSE, warning = FALSE, paged.print = FALSE, eval = FALSE----
#  your_dataset <- get_metadata("YOUR NID")
#  your_dataset

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  resource_metadata <- c("title" = "YOUR RESOURCE TITLE",
#       "field_wbddh_country" = "YOUR RESOURCE COUNTRY")
#  resource_json <- create_json_body(values = resource_metadata, node_type = “resource”)
#  create_resource(body = resource_json)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  attach_file_to_resource(resource_nid = "YOUR RESOURCE NID", file_path = "YOUR FILE PATH")

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  attach_resource_to_dataset(dataset_nid = "YOUR DATASET NID"
#    resource_nid = c("YOUR RESOURCE NID 1", "YOUR RESOURCE NID 2")
#  )

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  indicators_search <- search_catalog(fields = c("nid", "title"),
#                                      filters = c("title" = "World Development Indicators"))
#  wdi_nid <- indicators_search[[1]]$nid

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  update_metadata = c("title" = "YOUR DATASET TITLE",
#       "field_wbddh_country" = "YOUR DATASET COUNTRY")
#  mapped_values <- map_tids(update_metadata)
#  dataset_json = create_json_body(values = mapped_values, node_type = “dataset”)
#  update_dataset(credentials, body = dataset_json)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  resource_metadata = c("title" = "YOUR RESOURCE TITLE",
#       "field_wbddh_country" = "YOUR RESOURCE COUNTRY")
#  resource_json = create_json_body(values = resource_metadata, node_type = “resource”)
#  update_resource(credentials, body = resource_json)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  logout_ddh()

