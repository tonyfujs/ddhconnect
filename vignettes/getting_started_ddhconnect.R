## ----message=FALSE, warning=FALSE, paged.print=FALSE---------------------
library(ddhconnect)
data_catalog_url <- 'http://datacatalog.worldbank.org'
dkanr::dkanr_setup(url = data_catalog_url)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  geo_datasets <- search_catalog(fields = c("nid", "title"),
#                                 filters = c("field_wbddh_data_type" = "295"))
#  geo_datasets
#  # geo_nids = c()
#  # for (dataset in geo_datasets){
#  #   print(dataset$nid)
#  #   geo_nids = c(dataset$nid)
#  # }

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  wdi <- c("title" = "World Development Indicators")
#  search_results <- search_catalog(filters = wdi)

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  indicators_search <- search_catalog(fields = c("nid", "title"),
#                                      filters = c("title" = "World Development Indicators"))
#  wdi_nid <- indicators_search[[1]]$nid
#  indicators_resources <- get_resource_nid(nid = wdi_nid)
#  indicators_resources

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval = FALSE-------
#  indicators_resources <- get_resource_nid(nid = wdi_nid)
#  tid_download <- "986"
#  for (resource_id in indicators_resources) {
#    resource_metadata <- get_metadata(nid = resource_id)
#    if (resource_metadata$field_wbddh_resource_type$und$tid == tid_download) {
#      print(resource_metadata$title)
#      print(resource_metadata$nid)
#    }
#  }

## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  library(rcurl)
#  resource_metadata <- get_metadata(nid = 94974)
#  download_resource(resource_metadata)

