Contributing Content
================
Tony Fujs
2018-05-02

DDHCONNECT: Contributing Content
================================

With proper authorization, you can add and update datasets and resources to the Data Catalog through `ddhconnect`.

------------------------------------------------------------------------

Terminology
-----------

The World Bank Data Catalog is built using the DKAN platform. In line with DKAN terminology, the term "dataset" is used to refer to a node that has all the metadata for the data and the term "resource" is used refer to a node that has the data file, link to the data file or any supporting document. In the Data Catalog, every "dataset" is expected to have one or more "resources" attached to it.

------------------------------------------------------------------------

Setting Up Your Connection
--------------------------

First, begin by setting up your account with the following `dkanr_setup` function to authenticate the user. Login information for access to the API's extended services can be obtained by contacting the World Bank's IT Services, provided you are authorized for these credentials.

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

To add content to the Data Catalog, you need to add the metadata as a dataset node and the corresponding data files, links and supporting documentation as resources. Suppose we want to add a dataset with the following information to the Data Catalog and then attach a zip file containing the data as the resource.

``` r
metadata = c("title" = "Test Poverty Map",
           "body" = "Dataset to test the addition of poverty map datasets into DDH.",
           "field_topic" = "Poverty",
           "field_wbddh_data_class" = "Public",
           "field_wbddh_data_type" = "Geospatial",
           "field_wbddh_languages_supported" = "English",
           "field_frequency" = "Periodicity not specified",
           "field_wbddh_economy_coverage" = "Blend",
           "field_wbddh_country" = "Afghanistan;Albania;Algeria",
           "field_license_wbddh" = "Custom License",
           "workflow_status" = "published")
```

Some fields such as `field_topic` and `field_wbddh_data_class` take a controlled list of values as input. These values need to be mapped to their internal ids before they can be added to the Data Catalog. You can get a list of the fields that take a controlled list of values and the mapping from the controlled list of values to the corresponding ids using `get_lovs()`.

``` r
tid_mapping <- get_lovs()
head(tid_mapping)
```

    ##   vocabulary_name machine_name list_value_name  tid
    ## 1 resource_format field_format             APF  964
    ## 2 resource_format field_format            data 1364
    ## 3 resource_format field_format             CSV   14
    ## 4 resource_format field_format         CSV ZIP  659
    ## 5 resource_format field_format             DBF 1207
    ## 6 resource_format field_format           EXCEL 1194

For example, to get the tids corresponding to the topics of the dataset, you can look for `"field_topic"`:

``` r
tid_mapping[tid_mapping$machine_name == "field_topic", c("machine_name", "list_value_name", "tid")]
```

    ##     machine_name                            list_value_name tid
    ## 103  field_topic              Agriculture and Food Security 362
    ## 104  field_topic                             Climate Change 363
    ## 105  field_topic                            Economic Growth 364
    ## 106  field_topic                                  Education 365
    ## 107  field_topic                     Energy and Extractives 366
    ## 108  field_topic          Environment and Natural Resources 367
    ## 109  field_topic               Financial Sector Development 368
    ## 110  field_topic           Fragility, Conflict and Violence 369
    ## 111  field_topic                                     Gender 370
    ## 112  field_topic           Health, Nutrition and Population 371
    ## 113  field_topic Information and Communication Technologies 372
    ## 114  field_topic                                       Jobs 373
    ## 115  field_topic      Macroeconomic and Structural Policies 374
    ## 116  field_topic       Macroeconomic Vulnerability and Debt 375
    ## 117  field_topic                                    Poverty 376
    ## 118  field_topic                 Private Sector Development 377
    ## 119  field_topic                   Public Sector Management 378
    ## 120  field_topic                Public-Private Partnerships 379
    ## 121  field_topic                         Social Development 380
    ## 122  field_topic                Social Protection and Labor 381
    ## 123  field_topic                                      Trade 382
    ## 124  field_topic                                  Transport 383
    ## 125  field_topic                          Urban Development 384
    ## 126  field_topic                                      Water 385
    ## 127  field_topic                        Topic not specified 936

### Adding a new dataset

To add a new dataset to the site, begin by formatting your metadata into a named vector with the field names and corresponding values. You can pass this named vector to `create_json_body()`, which formats the metadata in the required JSON format. You can refer to the the data-raw folder to see which fields are required for the different data types.

``` r
metadata = c("title" = "Test Poverty Map",
           "body" = "Dataset to test the addition of poverty map datasets into DDH.",
           "field_topic" = "376",
           "field_wbddh_data_class" = "358",
           "field_wbddh_data_type" = "295",
           "field_wbddh_languages_supported" = "337",
           "field_frequency" = "18",
           "field_wbddh_economy_coverage" = "1013",
           "field_wbddh_country" = "35;36;37",
           "field_license_wbddh" = "1341",
           "workflow_status" = "published")
json_dataset <- create_json_body(values = metadata,
                                 node_type = "dataset")
```

Using the formatted JSON, you can add the dataset to the Data Catalog using `create_dataset()`.

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

After the resource is added to the Data Catalog, it can be attached to your dataset using `attach_resources_to_dataset()`. Multiple resources can be attached to a dataset by passing a vector of resource nids.

``` r
attach_resources_to_dataset(dataset_nid = resp_dataset$nid, resource_nid = resp_resource$nid)
```

------------------------------------------------------------------------

Updating Content
----------------

To update content in the Data Catalog, you need to know the node ID of the dataset you wish you edit. To obtain the node id, you can search the catalog based on the title of the object. For example, to get the node id of the "Test Poverty Map" dataset that we just created, we could do a search using `search_catalog()`.

``` r
search_results <- search_catalog(fields = c("nid", "title"),
                                 filters = c("title" = "Test Poverty Map"))
poverty_map_nid <- search_results[[1]]$nid
```

### Updating a dataset

The process for updating a dataset is similar to the process of adding a new dataset. Create a named vector with the metadata fields to be updated and the new values. Format the metadata using `create_json_body()` and pass it to `update_dataset()` to update the dataset.

``` r
update_dataset_metadata <- c("field_wbddh_country" = "59",
                             "field_tags" = "1236",
                             "workflow_status" = "published")
update_dataset_json <- create_json_body(values = update_dataset_metadata, node_type = “dataset”)
resp_update_dataset <- update_dataset(nid = poverty_map_nid, body = update_dataset_json)
```

Note that you need to set the "workflow\_status" to "published" everytime you update the node.

### Updating a resource

You can use the same method to update the resource metadata. Get the resource node id, format the metadata using `create_json_body()` and update the resource using `update_resource()`.

``` r
update_resource_metadata <-  c("field_format" = "666",
                               "workflow_status" = "published")
update_resource_json <- create_json_body(values = update_resource_metadata, node_type = “resource”)
resource_nid <- get_resource_nid(poverty_map_nid)
resp_update_resource <- update_resource(nid = resource_nid, body = resource_json)
```

Note that the functionality to search for resources is not available currently. So you can search for the dataset that the resource is attached to and get the node ids of the attached resources using `get_resource_nid()`.

------------------------------------------------------------------------

Ending Your Connection
----------------------

After finishing your tasks, you can log out of your account.

``` r
logout_ddh()
```
