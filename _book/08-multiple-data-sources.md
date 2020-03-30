# Multiple data sets




Many times working with just one data set will not suffice. More often than not the data that we will be working with be will need to be supplemented by other data sets. These datasets have a shared relation which are what enables us to **join** them together. A join is a way of combining the columns between two sets of data while ensuring the rows are properly aligned. 

The relationship that joins these tables together are expressed in the data through what is called a **common identifier**. This a variable exists in both datasets—perhaps, with a different name—and can be used as a reference to associate rows from each table together. 

Recall to our definition of tidy data. The definition that we used characterized the data inside of a single table. There is actually another rule: "each observational unit forms a table." So, in our previous definition a row was a single observation. When we extend the definition as such this is still the case but we have to create distinctions between "observational units[s]." 

To explore this concept we will use data about Airbnb listings in Boston. These data come from [Inside Airbnb](http://insideairbnb.com). Inside Airbnb collects Airbnb's public listing and makes them available through a "non-commercial set of tools and data that allows you to explore how Airbnb is really being used in cities around the world" (http://insideairbnb.com/about.html). 

Inside Airbnb data are another example of harnessing naturally occurring data. The listings are not generated with the intent of _being_ data, but by the virtue of their existence, they become data. We are able to harness them to learn about the shifting neighborhood dynamic of cities. They can tell us something about  short term rentals in a locale and about where people may be visiting and when.

We will first look at two data sets: `listings`, and `hosts`.


```r
listings <- read_csv("data/airbnb/listings.csv")

glimpse(listings)
## Observations: 3,799
## Variables: 7
## $ neighborhood     <chr> "East Boston", "Roxbury", "Roxbury", "Downtown"…
## $ room_type        <chr> "Entire home/apt", "Entire home/apt", "Entire h…
## $ price            <dbl> 125, 145, 169, 99, 150, 179, 125, 50, 154, 115,…
## $ minimum_nights   <dbl> 28, 3, 3, 91, 91, 91, 91, 91, 29, 1, 2, 2, 2, 6…
## $ n_reviews        <dbl> 16, 106, 115, 24, 31, 80, 2, 0, 52, 21, 316, 10…
## $ availability_365 <dbl> 68, 322, 274, 247, 29, 0, 364, 365, 304, 285, 6…
## $ host_id          <dbl> 4804, 8229, 8229, 26988, 26988, 38997, 38997, 2…
```



```r
hosts <- read_csv("data/airbnb/hosts.csv")

glimpse(hosts)
## Observations: 1,335
## Variables: 9
## $ id                 <dbl> 4804, 8229, 26988, 38997, 23078, 71783, 85130…
## $ name               <chr> "Frank", "Terry", "Anne", "Michelle", "Eric",…
## $ since_year         <dbl> 2008, 2009, 2009, 2009, 2009, 2010, 2010, 201…
## $ since_month        <chr> "12", "02", "07", "09", "06", "01", "02", "02…
## $ since_day          <chr> "03", "19", "22", "16", "24", "19", "24", "26…
## $ host_response_rate <chr> "100%", "100%", "100%", "92%", "50%", "98%", …
## $ acceptance_rate    <chr> "50%", "100%", "84%", "17%", "N/A", "98%", "9…
## $ superhost          <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, …
## $ n_listings         <dbl> 5, 2, 9, 13, 3, 40, 7, 4, 1, 2, 1, 1, 5, 1, 1…
```

Notice that the each row of the table is an observation of a different phenomenon. Each observation in `listings` is rentable dwelling and each row in `hosts` is a different individual. One host may have multiple listings as illustrated by the `n_listings` column. This sort of relationship is called _one to many_ meaning that for each host there is one or more listings. This is rather evident in the number of observations in each table—3,799 and 1,335 respectively. 

To associate the host information with the listings information we need to join the two datasets together. Most often the common identifier will be a type of id (often referred to as keys).
If we look at the variables of our tibbles we notice that `listings` contains `host_id` and `hosts` an `id` column.‚


The first dataset contains some general information about each listing in the dataset such as the neighborhood, the room type, price,and  


- multiple data sets
- what is a join?
- the need for a common identifier
- join types:
  - left
  - inner
  - right
  - full (rare)
  - anti-join (for removing data)
  
