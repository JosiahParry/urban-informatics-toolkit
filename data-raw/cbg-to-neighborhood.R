library(sf)
library(tidyverse)
library(tidycensus)

neighborhoods <- read_sf("data-raw/boston_neighborhoods.geojson")


ma_income <- get_acs(geography = "cbg", variables = "B19013_001", 
                           geometry = TRUE, state = "MA")


ma_inc <- st_transform(ma_income, st_crs(neighborhoods))


x <- st_join(ma_inc, neighborhoods)

x %>% 
  filter(!is.na(Name)) %>% 
  ggplot() +
  geom_sf(aes(color = Name))

x %>% 
  select(GEOID, NAME, Name) %>% 
  write_sf("data-raw/cbg-neighborhood.geojson")

