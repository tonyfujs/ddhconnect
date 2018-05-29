## ----message=FALSE, warning=FALSE, paged.print=FALSE---------------------
library(dkanr)
library(ddhconnect)
dkanr_setup(
  url = 'https://datacatalog.worldbank.org',
  username = Sys.getenv("username"),
  password = Sys.getenv("password")
)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  metadata = c("title" = "Test Poverty Map",
#             "body" = "Dataset to test the addition of poverty map datasets into DDH.",
#             "field_topic" = "Poverty",
#             "field_wbddh_data_class" = "Public",
#             "field_wbddh_data_type" = "Geospatial",
#             "field_wbddh_languages_supported" = "English",
#             "field_frequency" = "Periodicity not specified",
#             "field_wbddh_economy_coverage" = "Blend",
#             "field_wbddh_country" = "Afghanistan;Albania;Algeria",
#             "field_license_wbddh" = "Custom License",
#             "workflow_status" = "published")

## ------------------------------------------------------------------------
tid_mapping <- get_lovs()
head(tid_mapping)

## ------------------------------------------------------------------------
tid_mapping[tid_mapping$machine_name == "field_topic", c("machine_name", "list_value_name", "tid")]

## ----message = FALSE, warning = FALSE, paged.print = FALSE, eval = FALSE----
#  metadata = c("title" = "Test Poverty Map",
#             "body" = "Dataset to test the addition of poverty map datasets into DDH.",
#             "field_topic" = "376",
#             "field_wbddh_data_class" = "358",
#             "field_wbddh_data_type" = "295",
#             "field_wbddh_languages_supported" = "337",
#             "field_frequency" = "18",
#             "field_wbddh_economy_coverage" = "1013",
#             "field_wbddh_country" = "35;36;37",
#             "field_license_wbddh" = "1341",
#             "workflow_status" = "published")
#  json_dataset <- create_json_body(values = metadata,
#                                   node_type = "dataset")

## ----message = FALSE, warning = FALSE, paged.print = FALSE, eval = FALSE----
#  resp_dataset <- create_dataset(body = json_dataset)

## ----message = FALSE, warning = FALSE, paged.print = FALSE, eval = FALSE----
#  your_dataset <- get_metadata(resp_dataset$nid)
#  your_dataset

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  resource_metadata <-  c("title" = "Test Poverty Map Resource",
#                          "field_wbddh_data_class" = "358",
#                          "field_wbddh_resource_type" = "986",
#                          "workflow_status" = "published")
#  json_resource <- create_json_body(values = resource_metadata,
#                                    node_type = "resource")
#  resp_resource <- create_resource(body = json_resource)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  attach_file_to_resource(resource_nid = resp_resource$nid, file_path = "PATH TO YOUR FILE")

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  attach_resources_to_dataset(dataset_nid = resp_dataset$nid, resource_nid = resp_resource$nid)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  search_results <- search_catalog(fields = c("nid", "title"),
#                                   filters = c("title" = "Test Poverty Map"))
#  poverty_map_nid <- search_results[[1]]$nid

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  update_dataset_metadata <- c("field_wbddh_country" = "59",
#                               "field_tags" = "1236",
#                               "workflow_status" = "published")
#  update_dataset_json <- create_json_body(values = update_dataset_metadata, node_type = “dataset”)
#  resp_update_dataset <- update_dataset(nid = poverty_map_nid, body = update_dataset_json)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  update_resource_metadata <-  c("field_format" = "666",
#                                 "workflow_status" = "published")
#  update_resource_json <- create_json_body(values = update_resource_metadata, node_type = “resource”)
#  resource_nid <- get_resource_nid(poverty_map_nid)
#  resp_update_resource <- update_resource(nid = resource_nid, body = resource_json)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  logout_ddh()

