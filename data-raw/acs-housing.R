library(tidyverse)

acs_messy <- read_csv("data/ACS_1317_TRACT.csv")

acs_housing <- acs_messy %>% 
  separate(name, sep = ", ", into = c("tract", "county", "state")) %>% 
  mutate(tract = str_remove(tract, "Census Tract ")) %>% 
  na.omit() %>% 
  select(county, med_yr_moved_inraw, med_house_income, fam_house_per, age_u18, fam_house_per, bach)

write_csv(acs_housing, "data/acs-housing.csv")
