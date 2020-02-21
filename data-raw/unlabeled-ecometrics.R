library(tidyverse)

ecometrics <- read_csv("data/911/911-ecometrics-2014-19.csv") %>% 
  # remove periods from column names
  janitor::clean_names() %>% 
  # reshape
  pivot_longer(contains("Frequency"), 
               names_sep =  "_", 
               names_to = c("remove", "year"),
               values_to = "frequency") %>% 
  # getting rid of the word "frequency" and making it a column
  select(-remove) %>% 
  # un-dummy code
  mutate(ecometric_type = case_when(
    soc_dis == 1 ~ "Social Disorder",
    private_conflict == 1 ~ "Private Conflict",
    violence == 1 ~ "Violence",
    guns == 1 ~ "Guns"
  ))

# identify any unlabeled crimes
# ecometrics %>% 
#   filter(is.na(ecometric_type)) %>%
#   distinct(type, tycod, typ_eng, sub_tycod, sub_eng, year) %>% 
#   write_csv("data-raw/unlabeled-ecometrics.csv")

# I manually labeled these using google sheets

library(googlesheets4)

#sheets_auth()

labeled <- sheets_read("https://docs.google.com/spreadsheets/d/1PBtcwUer1yV3dryivOhi1ZCfTHDlgJcFmA7lwU580Vs/edit#gid=1586156381") %>% 
  filter(!is.na(ecometric)) %>% 
  mutate(ecometric_type = case_when(
    ecometric == "v" ~ "Violence",
    ecometric == "sd" ~ "Social Disorder",
    ecometric == "g" ~ "Guns",
    ecometric == "pc" ~ "Private Conflict"
  )) %>% select(-...7, -...8, -ecometric)


left_join(ecometrics, labeled, 
          by = c("type", "tycod", "typ_eng", "sub_tycod", "sub_eng")) %>% 
  mutate(ecometric_type = coalesce(ecometric_type.x, ecometric_type.y)) %>% 
  select(-ends_with(".y"), -ends_with(".x")) %>% 
  filter(!is.na(ecometric_type)) %>% 
  count(ecometric_type, year)
