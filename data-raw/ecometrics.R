library(tidyverse)


raw_eco <- read_csv("data-raw/911/911-ecometrics-2014-19.csv") %>% 
  janitor::clean_names()


ecometrics <- raw_eco %>% 
  mutate(measure = case_when(
    guns == 1 ~ "guns",
    violence == 1 ~ "violence",
    private_conflict == 1 ~ "private conflict",
    soc_dis == 1 ~ "social disorder"
  )) %>% 
  pivot_longer(cols = c(contains("frequency")),
               names_to = "year", 
               values_to = "n"
  ) %>% 
  mutate(year = as.integer(str_remove(year, "frequency_"))) %>% 
  filter(!is.na(measure)) %>% 
  #select(sub_eng, measure, year, n) %>% 
  arrange(year, measure) %>% 
  #mutate(type = coalesceyp_eng)) %>% 
  select(type = typ_eng, measure, year, n) %>% 
  group_by(type, measure, year) %>% 
  summarise(n = sum(n))


write_csv(ecometrics, "data/ecometrics.csv")


