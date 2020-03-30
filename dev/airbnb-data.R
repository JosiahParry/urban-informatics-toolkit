library(tidyverse)


listings <- read_csv("data-raw/2020-03-16-airbnb/listings.csv")
reviews <- read_csv("data-raw/2020-03-16-airbnb/reviews.csv")
listings_raw <- read_csv("data-raw/2020-03-16-airbnb/listings-raw.csv")

airbnb <- select(listings,
                 neighborhood = neighbourhood,
                 room_type, price, minimum_nights, 
                 n_reviews = number_of_reviews,
                 #n_host_listings = calculated_host_listings_count,
                 availability_365,
                 host_id)


airbnb_hosts <- select(listings_raw, starts_with("host")) %>% 
  select(-c(host_location, host_response_time, 
            contains("url"), host_neighbourhood,
            host_has_profile_pic, host_identity_verified,
            host_total_listings_count, host_about, 
            host_verifications)) %>%
  rename(superhost = host_is_superhost,
         n_listings = host_listings_count,
         acceptance_rate = host_acceptance_rate,
         name = host_name, 
         id = host_id) %>% 
  separate(host_since,
           into = c("since_year", "since_month", "since_day"),
           sep = "-") %>% 
  distinct(id, .keep_all = TRUE) %>% 
  mutate(superhost = as.integer(superhost)) 

airbnb_locations <- select(listings,
       id, longitude, latitude)


# make into list
l <- list(listings = airbnb, 
     hosts = airbnb_hosts,
     locations = airbnb_locations,
     reviews = filter(reviews,  lubridate::year(date) >= 2019)) 
   
# write data 
map2(l, 1:length(l),  ~write_csv(.x, glue::glue("data/airbnb/{names(l)[.y]}.csv")))


# can use airbnb to introduce geospatial work


# can introduce lubridate a little bit by taking reviews data and counting by the year and totalling the number of reviews per year. Can also look at the number of reviews per month