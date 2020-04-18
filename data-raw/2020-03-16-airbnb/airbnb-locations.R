listings <- readr::read_csv("data/airbnb/listings.csv")
locations <- readr::read_csv("data/airbnb/locations.csv")

airbnb_locations <- dplyr::left_join(listings, locations, by = "id") %>% 
  dplyr::select(-c(host_id, availability_365, minimum_nights))

readr::write_csv(airbnb_locations, "data/airbnb/airbnb.csv")
