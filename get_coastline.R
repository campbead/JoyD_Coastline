#load libraries
library(httr)
library(ows4R)
library(tidyverse)
library(sf)


# setup api key
api_key <- readr::read_file("api_key.txt")




# make request
r <- GET("https://data.linz.govt.nz/services", 
    query = list(
        key = api_key, 
        layer = "50204", 
        x = "170.78958785400164", 
        y = "-44.52805255369485",
        max_results = "10",
        radius = "10000",
        geometry = "true",
        with_field_names = "true"
        )
    
    
    
)
foo <- content(r, as="parsed", type= "application/json")


base_url <- "https://data.linz.govt.nz/services;/wfs/layer-51560"

parsed <- parse_url(base_url)
parsed$params <- paste0("key=", api_key,parsed$params)
url <- build_url(parsed)

regions_client <- WFSClient$new(url, 
    serviceVersion = "2.0.0")



url_query <- parse_url(url)

url_query$query <- list(service = "wfs",
    request = "GetFeature",
    typename = "layer-51560",
    srsName = "EPSG:4326"
)

request <- build_url(url_query)
nz_coast <- read_sf(request) %>% st_set_crs("EPSG:4326") %>% st_transform(crs = "EPSG:2193")

ggplot(nz_coast) +
    geom_sf()
