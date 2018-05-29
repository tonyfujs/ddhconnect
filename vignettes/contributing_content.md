DDHCONNECT: Contributing Content
================================

With proper authorization, you can add and update datasets and resources to the Data Catalog through `ddhconnect`.

------------------------------------------------------------------------

Terminology
-----------

The World Bank Data Catalog is built using the DKAN platform. In line with DKAN terminology, the term "dataset" refers to a node that has the metadata for the data and the term "resource" refers to a node that has the data file, link to the data file or any supporting document. In the Data Catalog, every "dataset" is required to have one or more attached "resources".

------------------------------------------------------------------------

Setting Up Your Connection
--------------------------

First, set up your connection and authenticate your credentials using `dkanr::dkanr_setup()`. You can contact the World Bank's IT Services to obtain login information to access the API's extended services, provided that you are authorized for these credentials. You can save your credentials as environment variables using `Sys.setenv()`.

``` r
Sys.setenv(username = "YOUR USERNAME", password = "YOUR PASSWORD")
```

``` r
library(dkanr)
library(ddhconnect)
dkanr_setup(
  url = 'https://datacatalog.worldbank.org',
  username = Sys.getenv("username"),
  password = Sys.getenv("password")
)
```

------------------------------------------------------------------------

Adding Content
--------------

To add content to the Data Catalog, first add the metadata as a dataset node and then add the corresponding data files, links and supporting documentation as resource nodes. Consider the case where we want to add a dataset about poverty maps, with the following metadata and attach a zip file containing the data as a resource.

``` r
metadata = list("title" = "Test Poverty Map",
           "body" = "Dataset to test the addition of poverty map datasets into DDH.",
           "field_topic" = "Poverty",
           "field_wbddh_data_class" = "Public",
           "field_wbddh_data_type" = "Geospatial",
           "field_wbddh_languages_supported" = "English",
           "field_frequency" = "Periodicity not specified",
           "field_wbddh_economy_coverage" = "Blend",
           "field_wbddh_country" = c("Afghanistan","Albania","Algeria"),
           "field_license_wbddh" = "Custom License",
           "workflow_status" = "published")
```

Many of the fields here (Ex: `field_topic`, `field_wbddh_data_class`) take a controlled list of values as input. To view the fields that take a controlled list of values, use `get_lov_fields()`.

``` r
lov_fields <- get_lov_fields()
lov_fields
```

    ##  [1] "field_format"                     "field_tags"                      
    ##  [3] "field_topic"                      "field_wbddh_data_type"           
    ##  [5] "field_wbddh_data_class"           "field_wbddh_economy_coverage"    
    ##  [7] "field_wbddh_gps_ccsas"            "field_wbddh_kind_of_data"        
    ##  [9] "field_wbddh_languages_supported"  "field_license_wbddh"             
    ## [11] "field_wbddh_mode_data_collection" "field_wbddh_ds_source"           
    ## [13] "field_wbddh_spatial_data_type"    "field_wbddh_region"              
    ## [15] "field_wbddh_country"              "field_wbddh_periodicity"         
    ## [17] "field_wbddh_api_format"           "field_wbddh_resource_type"       
    ## [19] "field_wbddh_update_frequency"     "field_granularity_list"          
    ## [21] "field_ddh_harvest_src"            "field_exception_s_"              
    ## [23] "field_frequency"                  "workflow_status"

You can view the valid list of values that these controlled fields using `get_lovs()`. The `list_value_name` column in the dataframe shows the valid values:

``` r
lovs <- get_lovs()
head(lovs)
```

    ##   vocabulary_name machine_name list_value_name  tid
    ## 1 resource_format field_format             APF  964
    ## 2 resource_format field_format            data 1364
    ## 3 resource_format field_format             CSV   14
    ## 4 resource_format field_format         CSV ZIP  659
    ## 5 resource_format field_format             DBF 1207
    ## 6 resource_format field_format           EXCEL 1194

### Adding a new dataset

To add a new dataset to the Data Catalog, begin by formatting your metadata into a named list with the field names and corresponding values. Pass this named vector to `create_json_body()`, to format the metadata in the required JSON format. You can find the required metadata fields for a given data type using `get_required_fields()`. In our example, we want to add a geospatial dataset.

``` r
get_required_fields("Geospatial")
```

    ##  [1] "title"                           "body"                           
    ##  [3] "field_topic"                     "field_wbddh_data_class"         
    ##  [5] "field_wbddh_data_type"           "field_wbddh_languages_supported"
    ##  [7] "field_frequency"                 "field_wbddh_economy_coverage"   
    ##  [9] "field_wbddh_country"             "field_license_wbddh"            
    ## [11] "workflow_status"                 "type"

Format your metadata into a named list with the required fields and their values. Note that the `node_type` sets the type of the parameter and this is not required to be part of the named list.

``` r
metadata = list("title" = "Test Poverty Map",
           "body" = "Dataset to test the addition of poverty map datasets into DDH.",
           "field_topic" = "Poverty",
           "field_wbddh_data_class" = "Public",
           "field_wbddh_data_type" = "Geospatial",
           "field_wbddh_languages_supported" = "English",
           "field_frequency" = "Periodicity not specified",
           "field_wbddh_economy_coverage" = "Blend",
           "field_wbddh_country" = c("Afghanistan","Albania","Algeria"),
           "field_license_wbddh" = "Custom License",
           "workflow_status" = "published")
json_dataset <- create_json_body(values = metadata,
                                 node_type = "dataset")
```

Add the dataset to the Data Catalog by passing the formatted JSON to `create_dataset()`.

``` r
resp_dataset <- create_dataset(body = json_dataset)
```

`create_dataset()` prints the node id of the node created for your new dataset. You can view the metadata using `get_metadata()`.

``` r
your_dataset <- get_metadata(resp_dataset$nid)
your_dataset
```

### Adding a resource to the dataset

Once the dataset node is created, you can add the data files, links and supporting documents as resources. Again, you can add a resource to the Data Catalog by creating a named list of the resource metadata, formatting it in JSON format using `create_json_body()`, and creating a resource node using `create_resource()`.

``` r
resource_metadata <-  c("title" = "Test Poverty Map Resource",
                        "field_wbddh_data_class" = "358",
                        "field_wbddh_resource_type" = "986",
                        "workflow_status" = "published")
json_resource <- create_json_body(values = resource_metadata,
                                  node_type = "resource")
resp_resource <- create_resource(body = json_resource)
```

If your resource is a local file, you can upload it to the Data Catalog using `attach_file_to_resource()`.

``` r
attach_file_to_resource(resource_nid = resp_resource$nid, file_path = "PATH TO YOUR FILE")
```

If your resource is a link to an external page, you can add the link as part of the resource metadata.

``` r
resource_metadata <-  c("title" = "Small Area Estimation of Poverty",
                        "field_wbddh_data_class" = "358",
                        "field_wbddh_resource_type" = "1192",
                        "field_link_api" = "http://www.nsb.gov.bt/publication/files/pub9zo1561nu.pdf",
                        "workflow_status" = "published")
json_resource <- create_json_body(values = resource_metadata,
                                  node_type = "resource")
resp_resource <- create_resource(body = json_resource)
```

After the resource is added to the Data Catalog, attach it to your dataset using `attach_resources_to_dataset()`. You can attach multiple resources to a dataset by passing a vector of resource nids.

``` r
attach_resources_to_dataset(dataset_nid = resp_dataset$nid, resource_nid = resp_resource$nid)
```

------------------------------------------------------------------------

Updating Content
----------------

To update content in the Data Catalog, you need to know the node ID of the dataset you wish you edit. To obtain the node id, you can search the catalog by the title of the dataset. For example, to get the node id of the "Test Poverty Map" dataset that we just created, you can perform a search using `search_catalog()`.

``` r
search_results <- search_catalog(fields = c("nid", "title"),
                                 filters = c("title" = "Test Poverty Map"))
poverty_map_nid <- search_results[[1]]$nid
```

### Updating a dataset

The process of updating a dataset is similar to the process of adding a new dataset. Create a named vector with the updated metadata fields and the correspodning new values. Format the metadata using `create_json_body()` and pass it to `update_dataset()` to update the dataset.

``` r
update_dataset_metadata <- c("field_wbddh_country" = "59",
                             "field_tags" = "1236",
                             "workflow_status" = "published")
update_dataset_json <- create_json_body(values = update_dataset_metadata, node_type = “dataset”)
resp_update_dataset <- update_dataset(nid = poverty_map_nid, body = update_dataset_json)
```

Note that you need to set the "workflow\_status" to "published" every time you update the node.

### Updating a resource

Use the same process as above to update the resource metadata. Get the resource node id, format the new metadata using `create_json_body()` and update the resource using `update_resource()`.

``` r
update_resource_metadata <-  c("field_format" = "666",
                               "workflow_status" = "published")
update_resource_json <- create_json_body(values = update_resource_metadata, node_type = “resource”)
resource_nid <- get_resource_nid(poverty_map_nid)
resp_update_resource <- update_resource(nid = resource_nid, body = resource_json)
```

Note that the functionality to search for resources is currently unavailable. Instead, search for the dataset that the resource is attached to and get the resource node ids using `get_resource_nid()`. You can find an example in the above code snippet.

------------------------------------------------------------------------

Ending Your Connection
----------------------

After finishing your tasks, you can log out of your account.

``` r
logout_ddh()
```