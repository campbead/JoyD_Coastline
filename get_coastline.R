#load libraries
library(httr)
library(ows4R)
library(tidyverse)
library(sf)


# setup api key
api_key <- readr::read_file("api_key.txt")



# 
# # make request
# r <- GET("https://data.linz.govt.nz/services", 
#     query = list(
#         key = api_key, 
#         layer = "50204", 
#         x = "170.78958785400164", 
#         y = "-44.52805255369485",
#         max_results = "10",
#         radius = "10000",
#         geometry = "true",
#         with_field_names = "true"
#         )
#     
#     
#     
# )
# foo <- content(r, as="parsed", type= "application/json")
# 

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
    geom_sf(fill= "darkgreen", color="darkgreen") +
    coord_sf(datum = sf::st_crs("EPSG:2193"))

# create a point 

x <- 1200000
y <- 5000000

point <- st_point(c(x,y)) %>% st_sfc() %>% st_set_crs("EPSG:2193")

ggplot(nz_coast) +  
    geom_sf(fill= "darkgreen", color="darkgreen") +
    geom_sf(data = point) + 
    coord_sf(datum = sf::st_crs("EPSG:2193"))

## make a bunch of parallel lines
y_spacing <- 100000
x_start <- 1000000
x_end <- 2200000
y_start <- 4700000
y_end <- 6300000

y_para <- seq(from = y_start, to = y_end, by = y_spacing)

start_pts <- rep_len(x_start, length(y_para))
end_pts <- rep_len(x_end, length(y_para))

pt_type_start <- rep_len("start", length(y_para))
pt_type_end <- rep_len("end", length(y_para))

line_no <- seq(1,length(y_para)) %>%  rep(2)

my_df <- data.frame(
    line_number = line_no,     
#    type = append(pt_type_start, pt_type_end),
    x = append(start_pts,end_pts), 
    y = rep(y_para,2)
)

my_df_sp <- st_as_sf(my_df, coords = c("x", "y"), crs = "EPSG:2193") %>% group_by(line_number) %>% summarise(m = "foo") %>% st_cast("LINESTRING") %>% select(-m) 


ggplot(nz_coast) +  
    geom_sf(fill= "darkgreen", color="darkgreen") +
    geom_sf(data = my_df_sp) + 
    coord_sf(datum = sf::st_crs("EPSG:2193"))


# make changes to nz_coast
# https://github.com/r-spatial/sf/issues/748
nz_coast_poly <-st_cast(nz_coast, "GEOMETRYCOLLECTION") %>%  st_collection_extract("LINESTRING") %>% st_cast("POLYGON")

cut_line <- st_intersection(my_df_sp, nz_coast_poly)

ggplot(cut_line) +  
    geom_sf(fill= "darkgreen", aes(color = as.factor(name))) +
    coord_sf(datum = sf::st_crs("EPSG:2193"))
