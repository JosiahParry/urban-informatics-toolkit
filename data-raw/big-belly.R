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


write_csv(big_belly, "data/big-belly-2014.csv")
