#load libraries
library(httr)

# setup api key
api_key <- readr::read_file("api_key.txt")


# make request
r <- GET("https://data.linz.govt.nz/services/query/v1/raster.json", 
    query = list(key = api_key, layer = "51768", x = "170.78958785400164", y = "-44.52805255369485")
)

# see response text
content(r,"text")

foo <- content(r, as="parsed", type= "application/json")