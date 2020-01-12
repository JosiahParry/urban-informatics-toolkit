acs %>% 
  #filter(black > .50) %>% 
  ggplot(aes(bach, med_house_income)) +
  geom_point(alpha = .25) +
  theme_bari() + 
  labs(title = "Educational Attainment & Income",
       x = "Bachelors",
       y = "Median Household Income") +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::dollar)


acs %>% 
  ggplot(aes(bach, white)) +
  geom_point(alpha = .25) +
  labs(title = "Educational Attainment and Whiteness",
       subtitle = "Boston Census Tracts",
       x = "Educational Attainment",
       y = "% White",
       caption = "https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/XZXAUP") +
  xlim(0, .6) +
  ylim(0, 1) + 
  theme_bari()
  

acs %>% 
  #filter(black > .50) %>% 
  ggplot(aes(bach, med_house_income, color = white)) +
  geom_point(alpha = .5) +
  theme_bari() + 
  labs(title = "Education and Income",
       x = "Bachelors",
       y = "Median Household Income") +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::dollar) +
  scale_color_gradient(high = "#da6f6f") 

high_cor_vars <- c("pub_assist", "fam_pov_per", "unemp_rate", "fem_head_per", "master", "bach", "med_home_val", "renters_per")


select(acs, high_cor_vars) %>% 
  correlate() %>% View()
select_if(acs, is.numeric) %>% 
  select(-ct_id_10, -fips_stco, -town_id, -area_acres, -med_yr_moved_inraw, 
         -med_yr_built_raw, -grand_head_per, -pop_den) %>% 
  correlate() %>% 
  shave(F) %>% View()
