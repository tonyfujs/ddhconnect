# Create resources
test <- create_resource(credentials, path = '../ddh_api_demo/input/create_resource_TEST.JSON')
resource_json <- jsonlite::fromJSON(test$uri)
resource_json$path

# Delete resource

cookie <- credentials$cookie
token <- credentials$token

my_url <- paste0('https://ddhqa.worldbank.org/api/dataset/views/getuserdetails?uid=', uid)
out <- httr::DELETE(url = test$uri,
                  httr::add_headers(.headers = c('Content-Type' = 'application/json',
                                                 'Cookie' =  cookie,
                                                 'X-CSRF-Token' = token)))

httr::warn_for_status(out)

out <- httr::content(out)
names(out) <- c('node_id', 'uri')


test_harvest <- create_dataset(credentials, path = '../ddh_api_demo/input/create_dataset_HARVEST_TEST.JSON')
