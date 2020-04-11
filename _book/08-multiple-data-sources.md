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
#> Rows: 3,799
#> Columns: 7
#> $ id               <dbl> 3781, 5506, 6695, 8789, 10730, 10813, 10986, 16384, …
#> $ neighborhood     <chr> "East Boston", "Roxbury", "Roxbury", "Downtown", "Do…
#> $ room_type        <chr> "Entire home/apt", "Entire home/apt", "Entire home/a…
#> $ price            <dbl> 125, 145, 169, 99, 150, 179, 125, 50, 154, 115, 148,…
#> $ minimum_nights   <dbl> 28, 3, 3, 91, 91, 91, 91, 91, 29, 1, 2, 2, 2, 6, 3, …
#> $ availability_365 <dbl> 68, 322, 274, 247, 29, 0, 364, 365, 304, 285, 62, 24…
#> $ host_id          <dbl> 4804, 8229, 8229, 26988, 26988, 38997, 38997, 23078,…
```



```r
hosts <- read_csv("data/airbnb/hosts.csv")

glimpse(hosts)
#> Rows: 1,335
#> Columns: 9
#> $ id              <dbl> 4804, 8229, 26988, 38997, 23078, 71783, 85130, 85770,…
#> $ name            <chr> "Frank", "Terry", "Anne", "Michelle", "Eric", "Lance"…
#> $ since_year      <dbl> 2008, 2009, 2009, 2009, 2009, 2010, 2010, 2010, 2010,…
#> $ since_month     <chr> "12", "02", "07", "09", "06", "01", "02", "02", "03",…
#> $ since_day       <chr> "03", "19", "22", "16", "24", "19", "24", "26", "23",…
#> $ response_rate   <chr> "100%", "100%", "100%", "92%", "50%", "98%", "66%", "…
#> $ acceptance_rate <chr> "50%", "100%", "84%", "17%", "N/A", "98%", "97%", "10…
#> $ superhost       <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1,…
#> $ n_listings      <dbl> 5, 2, 9, 13, 3, 40, 7, 4, 1, 2, 1, 1, 5, 1, 1, 1, 1, …
```

Notice that the each row of the table is an observation of a different phenomenon. Each observation in `listings` is rentable dwelling and each row in `hosts` is a different individual. One host may have multiple listings. This sort of relationship is called _one to many_ meaning that for each host there is one or more listings. This is rather evident in the number of observations in each table—3,799 and 1,335 respectively. 

To associate the host information with the listings information we need to join the two datasets together. Most often the common identifier will be a type of id (often referred to as keys). Identifiers are meant to be unique at the observational unit. If we look at the variables of our tibbles we notice that `listings` contains `host_id` and `hosts` an `id` column. Fortunately the first two rows of each dataset share identifiers.

Before we get to joining our datasets, we need to understand the different types of joins that are available to us. When doing joins we consider two tables: one on the left hand side and the other on the right hand side referred to in documentation as _x_ and _y_ respectively. There are a plethora of joins that are possible but I want to keep the focus to four types. These are the left, right, inner, and anti joins. 

The left and right join are identical, the only difference is which table we may consider the target of the join. In the case of the left join, it will 

> "return all rows from x, and all columns from x and y. Rows in x with no match in y will have NA [missing] values in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned."

Simply, in a left join we will never lose rows from x. If there happens to be no match from y there will be missing values. The reverse is true for the right join. A right join ensures that all rows from y will remain at the end. If there are duplicate matches between x and y each of those will be returned. 

For the sake of example, let's reduce our data down to the first five rows and only a few columns for each. Hosts data will be stored in the tibble `h` and listings in `l`.


```r
h <- slice(hosts, 1:5) %>% 
  select(id, name, n_listings)

l <- slice(listings, 1:5) %>% 
  select(host_id, price, neighborhood)

h
#> # A tibble: 5 x 3
#>      id name     n_listings
#>   <dbl> <chr>         <dbl>
#> 1  4804 Frank             5
#> 2  8229 Terry             2
#> 3 26988 Anne              9
#> 4 38997 Michelle         13
#> 5 23078 Eric              3
l
#> # A tibble: 5 x 3
#>   host_id price neighborhood
#>     <dbl> <dbl> <chr>       
#> 1    4804   125 East Boston 
#> 2    8229   145 Roxbury     
#> 3    8229   169 Roxbury     
#> 4   26988    99 Downtown    
#> 5   26988   150 Downtown
```

In `h` we have one observation per host meaning that there are 5 distinct hosts in our dataset. In general when there is only one id per observation for a table, that is generally referred to as the **primary key** as it is used to identify observations in that table. In this case, `id` is the primary key for `h`. Whereas when we look to `l`, there are multiple observations for the `host_id`.


```r
count(l, host_id)
#> # A tibble: 3 x 2
#>   host_id     n
#>     <dbl> <int>
#> 1    4804     1
#> 2    8229     2
#> 3   26988     2
```

  When the ID is used to identify observations in another table, that is referred to as the **foreign key**. Here, `host_id` is used to connect `l` to the `h` table and as such is a foreign key. 
  
  Say we want to know all of the host information associated with each listing we will need to join `h` to `l`. In this situations we want to keep all records of listings and only keep the host information when it is relevant. A left join with `l` as the left hand table and `h` as the right hand table will provide us with exactly what we need. 
  
To actually perform the join, we will use the function `left_join()` from dplyr. There are three arguments that we need to fulfill: `x`, `y`, and `by`. That is, what table will be on our left and which will be on the right? And, which column(s) will act as the common identifier. 

Fulfilling the `x` and `y` arguments is straightforward, we simply supply the relevant tibbles. Marking the common identifier is a little bit tricky. `by` expects a character vector with the name of the common identifier. However, in most cases, the column names will differ by table. To connect them we need to create what is called a named vector.

In general we create a vector with `c()` and each element is separated by a comma. If we were to create a vector with the names of our identifier (from left to right) it would look like


```r
c("host_id", "id")
#> [1] "host_id" "id"
```

This is a vector of length 2. We need to create a vector of length 1 where the only element is named. We can name vector elements like `c("element_name" = "element")`. For `left_join()` the name of the element is the identifier in the left hand table and the element is the name of identifier in the right hand table. Putting this all together it looks like


```r
c("host_id" = "id")
#> host_id 
#>    "id"
```

Now we have all of the pieces that we need and can perform the join.


```r
left_join(l, h, by = c("host_id" = "id"))
#> # A tibble: 5 x 5
#>   host_id price neighborhood name  n_listings
#>     <dbl> <dbl> <chr>        <chr>      <dbl>
#> 1    4804   125 East Boston  Frank          5
#> 2    8229   145 Roxbury      Terry          2
#> 3    8229   169 Roxbury      Terry          2
#> 4   26988    99 Downtown     Anne           9
#> 5   26988   150 Downtown     Anne           9
```

There are no missing values in this join because each `host_id` had a counter-part in the host table. Now, say we perform right join but keep our tables exactly where they are. What do you expect this to look like?


```r
right_join(l, h, by = c("host_id" = "id"))
#> # A tibble: 7 x 5
#>   host_id price neighborhood name     n_listings
#>     <dbl> <dbl> <chr>        <chr>         <dbl>
#> 1    4804   125 East Boston  Frank             5
#> 2    8229   145 Roxbury      Terry             2
#> 3    8229   169 Roxbury      Terry             2
#> 4   26988    99 Downtown     Anne              9
#> 5   26988   150 Downtown     Anne              9
#> 6   38997    NA <NA>         Michelle         13
#> 7   23078    NA <NA>         Eric              3
```

There are two key differences here. The first is that, since the right hand table has unmatched `id`s, we should anticipate missing values in the columns from `l`—`price` and `neighborhood`. Moreover, since there are multiple matches in the left hand table, we are returned more than observation per match. 

This naturally brings us to the inner join. The inner join will _only_ return row where there are matching observations in _both_ tables. 


```r
inner_join(l, h, by = c("host_id" = "id"))
#> # A tibble: 5 x 5
#>   host_id price neighborhood name  n_listings
#>     <dbl> <dbl> <chr>        <chr>      <dbl>
#> 1    4804   125 East Boston  Frank          5
#> 2    8229   145 Roxbury      Terry          2
#> 3    8229   169 Roxbury      Terry          2
#> 4   26988    99 Downtown     Anne           9
#> 5   26988   150 Downtown     Anne           9
```

Oftentimes, as with this time, the inner join behaves much like a left or right join where one of the tables has each observation matched. In general I recommend performing left or right joins so we can better keep track of missingness. 

The last join to cover is the anti join. The anti join is rather unique and is used to find where there are _not_ matches between two tables. When using an anti join we are returned all observations from x where there are _not_ matches in y. From our previous right join, we know that there are not matches for two of the host ids in `h`. To find these using a join we can put `h` in the x position and `l` in the y position. Note that since we are switching the order of our tibbles we need to rearrange the vector we supplied to `by`.


```r
anti_join(h, l, by = c("id" = "host_id"))
#> # A tibble: 2 x 3
#>      id name     n_listings
#>   <dbl> <chr>         <dbl>
#> 1 38997 Michelle         13
#> 2 23078 Eric              3
```
If we reverse this, we should receive an empty tibble.


```r
anti_join(l, h, by = c("host_id" = "id"))
#> # A tibble: 0 x 3
#> # … with 3 variables: host_id <dbl>, price <dbl>, neighborhood <chr>
```

Anti joins are often a good way to sanity check your data when looking for completeness or missingness. Be sure to keep this one in your back pocket! 


## Exercise

For this exercise your goal is to identify the average price and availability of Airbnb rentals by host. Then plot


- Read in the reviews dataset 
- Count the total number of reviews by listing, create column `n_reviews`
- join to listings
- join that to host, name it `airbnb_full`. 



```r
reviews <- read_csv("data/airbnb/reviews.csv")
#> Parsed with column specification:
#> cols(
#>   listing_id = col_double(),
#>   date = col_date(format = "")
#> )

airbnb_full <- group_by(reviews, listing_id) %>% 
  summarise(n_reviews = n()) %>% 
  left_join(listings, by = c("listing_id" = "id")) %>% 
  left_join(hosts, by = c("host_id" = "id"))

glimpse(airbnb_full)
#> Rows: 2,668
#> Columns: 16
#> $ listing_id       <dbl> 3781, 5506, 6695, 8789, 10730, 10813, 18711, 22195, …
#> $ n_reviews        <int> 2, 26, 30, 2, 4, 35, 9, 11, 23, 21, 3, 20, 10, 15, 1…
#> $ neighborhood     <chr> "East Boston", "Roxbury", "Roxbury", "Downtown", "Do…
#> $ room_type        <chr> "Entire home/apt", "Entire home/apt", "Entire home/a…
#> $ price            <dbl> 125, 145, 169, 99, 150, 179, 154, 115, 148, 275, 95,…
#> $ minimum_nights   <dbl> 28, 3, 3, 91, 91, 91, 29, 1, 2, 2, 6, 3, 2, 2, 2, 5,…
#> $ availability_365 <dbl> 68, 322, 274, 247, 29, 0, 304, 285, 62, 247, 197, 80…
#> $ host_id          <dbl> 4804, 8229, 8229, 26988, 26988, 38997, 71783, 85130,…
#> $ name             <chr> "Frank", "Terry", "Terry", "Anne", "Anne", "Michelle…
#> $ since_year       <dbl> 2008, 2009, 2009, 2009, 2009, 2009, 2010, 2010, 2010…
#> $ since_month      <chr> "12", "02", "02", "07", "07", "09", "01", "02", "02"…
#> $ since_day        <chr> "03", "19", "19", "22", "22", "16", "19", "24", "26"…
#> $ response_rate    <chr> "100%", "100%", "100%", "100%", "100%", "92%", "98%"…
#> $ acceptance_rate  <chr> "50%", "100%", "100%", "84%", "84%", "17%", "98%", "…
#> $ superhost        <dbl> 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0…
#> $ n_listings       <dbl> 5, 2, 2, 9, 9, 13, 40, 7, 4, 1, 1, 1, 5, 5, 1, 1, 2,…
```


```r
host_summary <- left_join(listings, hosts, by = c("host_id" = "id")) %>% 
  group_by(superhost) %>% 
  summarise(avg_avail = mean(availability_365),
            avg_price = mean(price),
            avg_min_nights = mean(minimum_nights))
```


