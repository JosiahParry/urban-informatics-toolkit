library(sf)
library(tidyverse)
# clean it
permits <- read_csv("data-raw/permits-raw.csv") %>% 
  janitor::clean_names() %>% 
  mutate_if(is.character, .funs = ~str_trim(str_squish(.), "both"))

# write it
write_csv(permits, "data/building-permits.csv")

# make it an sf object
permits_sf <- permits %>% 
  filter(!is.na(long), !is.na(lat)) %>% 
  st_as_sf(coords = c("long", "lat"))

# write as an shp
filter(permits_sf, lubridate::year(issued_date) == 2019) %>% 
  st_write("data/permits-2019.shp")

# write it as as geojson file
filter(permits_sf, lubridate::year(issued_date) == 2019) %>% 
  st_write("data/permits-2019.geojson")

# permits19 <- filter(permits_sf, lubridate::year(issued_date) == 2019) 
# 
# ggplot(permits19, aes(color = occupancytype)) +
#   geom_sf() +
#   facet_wrap(~occupancytype)
