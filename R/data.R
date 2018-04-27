#' Lookup Table of JSON Formats for Datasets
#'
#' A dataset with JSON formatting information for datasets when
#'  creating or updating. The variables are:
#'
#' \itemize{
#'  \item machine_names. Data Catalog field names
#'  \item json_template. JSON Format
#' }
#'
#' @docType data
#' @keywords datasets
#' @name dataset_json_format_lookup
#' @usage data(dataset_json_format_lookup)
#' @format A data frame with 73 rows and 2 variables
NULL

#' Lookup Table of JSON Formats for Resources
#'
#' A dataset with JSON formatting information for resources when
#'  creating or updating. The variables are:
#'
#' \itemize{
#'  \item machine_names. Data Catalog field names
#'  \item json_template. JSON Format
#' }
#'
#' @docType data
#' @keywords datasets
#' @name resource_json_format_lookup
#' @usage data(resource_json_format_lookup)
#' @format A data frame with 7 rows and 2 variables
NULL

#' Lookup Table for User Interface Form Fields and JSON Field Names
#'
#' A dataset with User Interface form names and corresponding field names
#'
#' \itemize{
#'  \item machine_names. Data Catalog field names
#'  \item ui_names. form name
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ui_names_lookup
#' @usage data(ui_names_lookup)
#' @format A data frame with 115 rows and 2 variables
NULL

#' Test Values for Dataset Update
#'
#' A list with nested content for a test dataset's update
#'
#' @docType data
#' @keywords datasets
#' @name test_dataset_update_json
#' @usage data(test_dataset_update_json)
#' @format A list with 30 items
NULL


#' Test Values for Resource Update
#'
#' A list with nested content for a test resource's update
#'
#' @docType data
#' @keywords datasets
#' @name test_resource_update_json
#' @usage data(test_resource_update_json)
#' @format A list with 6 items
NULL

#' Format to Attach a Resource
#'
#' A list with format needed to attach a resource to a dataset
#'
#' @docType data
#' @keywords datasets
#' @name attach_resources_template
#' @usage data(attach_resources_template)
#' @format A list with 1 item
NULL
