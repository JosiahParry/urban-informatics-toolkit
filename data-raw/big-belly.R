library(sf)
library(jsonlite)
library(lubridate)
library(tidyverse)

raw_json <- read_json("data-raw/big-belly-alerts.json", simplifyVector = TRUE)

#' convert from json to spatial features
big_belly <- raw_json$records %>% 
  as_tibble() %>% 
  setNames(raw_json$fields[,3]) %>% 
  mutate(Location = str_remove_all(Location, "\\(|\\)"),
         timestamp = mdy_hms(timestamp)) %>% 
  separate(Location, into = c("lat", "long"), sep = ", ") %>% 
  mutate_at(vars("lat", "long"), as.numeric) 

# make a spatial object
big_belly_sf <- big_belly %>% 
  st_as_sf(coords = c("long", "lat"))

# read in neighborhood boundaries
neighborhoods <- st_read("data-raw/boston_neighborhoods.geojson")


# change the crs
st_crs(big_belly_sf) <- st_crs(neighborhoods)

# transform to crs to be sure
big_belly_sf <- st_transform(big_belly_sf, st_crs(big_belly_sf))


# join big_belly to neighborhoods to get neighborhood info
aoi_sf <- st_join(big_belly_sf, neighborhoods, 
                  join = st_within)


# get big belly for all of downtown
bind_cols(neighborhood = aoi_sf$Name, big_belly) %>% 
  mutate(day_of_week = wday(timestamp)) %>% 
  group_by(neighborhood, description) %>% 
  summarise(n = n(),
            lat = mean(lat),
            long = mean(long)) %>% 
  filter(neighborhood == "Downtown") %>% 
  select(-neighborhood) %>% 
  write_csv("data/downtown-big-belly.csv")

#' 
#' big_belly_sf <- raw_json$records %>% 
#'   as_tibble() %>% 
#'   setNames(raw_json$fields[,3]) %>% 
#'   mutate(Location = str_remove_all(Location, "\\(|\\)"),
#'          timestamp = mdy_hms(timestamp)) %>% 
#'   separate(Location, into = c("lat", "long"), sep = ", ") %>% 
#'   mutate_at(vars("lat", "long"), as.numeric) %>% 
#'   mutate(day = floor_date(timestamp, unit = "day"),
#'          month = month(timestamp),
#'          day = wday(timestamp)) %>% 
#'   st_as_sf(coords = c("long", "lat"))
#' 
#' 
#' #' Read in neighborhoods
#' neighborhoods <- st_read("Boston_Neighborhoods.geojson")