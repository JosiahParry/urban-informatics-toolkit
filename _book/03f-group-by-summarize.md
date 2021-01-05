# Summarizing the tidy way





Now that we have a basic understanding of how to manipulate our dataset, summarising the dataset into a few useful metrics is important. When we have massive datasets with many subgroups, summary statistics will be very important for distilling all of that information into something consumable. Aggregation will also be very important for visualization purposes. 

We have already reviewed what constitutes a summary statistic and how to create them working with vectors. But we have not done so within the context of the tidyverse. We have figured out how to select, filter, mutate and all within a chain of functions. But we have not followed this to its natural next step, the `group_by()` and `summarise()` functions. 

dplyr incluides a wonderful helper function called `count()`. It does just what it says it does. It counts the number of observations in a tibble. Let's recreate the `commute` tibble and see it for ourselves. 


```r
library(tidyverse)

commute <- read_csv("data/gba_commute.csv") 

count(commute)
#> # A tibble: 1 x 1
#>       n
#>   <int>
#> 1   648
```

We can also count by groups in a data set. For example, we can count how many observations there are per county.


```r
count(commute, county)
#> # A tibble: 3 x 2
#>   county        n
#>   <chr>     <int>
#> 1 MIDDLESEX   318
#> 2 NORFOLK     130
#> 3 SUFFOLK     200
```


`count()` is actually a wrapper around the function `summarise()` which is a much more flexible function. `summarise()` is the aggregate analog to `mutate()`. The difference between `mutate()` and `summarise()` is that the result of an expression in `mutate()` must have the same number of values as there are rows—unless of course you are specifying a scalar value like `TRUE`—whereas `summarise()` requires the result to be one an element of length one.

> Notes: 
- A wrapper is function that executes another function.
- A scalar is a vector of length one.

We can recreate the first above `count()` call with `summarise()` and the handy `n()` function we learned a while ago. Here we follow the same pattern of assigning column names to expressions as we do with. 


```r
summarise(commute, n = n())
#> # A tibble: 1 x 1
#>       n
#>   <int>
#> 1   648
```

Like `mutate()` there is no restriction on the number of new columns we can create. Previously we calculated the min, max, mean, and standard deviation of the `commute3060` variable. This is done rather neatly with `summarise()`.


```r
commute %>% 
  summarise(
    min_commute = min(commute3060, na.rm = TRUE),
    max_commute = max(commute3060, na.rm = TRUE),
    avg_commute = mean(commute3060, na.rm = TRUE),
    sd_commute  = sd(commute3060, na.rm = TRUE)
    )
#> # A tibble: 1 x 4
#>   min_commute max_commute avg_commute sd_commute
#>         <dbl>       <dbl>       <dbl>      <dbl>
#> 1           0       0.633       0.390     0.0862
```

Frankly this alone is somewhat unimpressive. The power of `summarise()` comes from incorporating `group_by()` into the function chain. `group_by()` allows us to explicitly identify groups within a tibble as defined by a given variable. The resulting tibble from a `group_by()` call is seemingly unchanged. 


```r
commute %>% 
  group_by(county)
#> # A tibble: 648 x 14
#> # Groups:   county [3]
#>    county hs_grad  bach master commute_less10 commute1030 commute3060
#>    <chr>    <dbl> <dbl>  <dbl>          <dbl>       <dbl>       <dbl>
#>  1 MIDDL…   0.389 0.188 0.100          0.0916       0.357       0.375
#>  2 MIDDL…   0.167 0.400 0.130          0.0948       0.445       0.344
#>  3 MIDDL…   0.184 0.317 0.139          0.0720       0.404       0.382
#>  4 MIDDL…   0.258 0.322 0.144          0.0983       0.390       0.379
#>  5 MIDDL…   0.301 0.177 0.0742         0.0670       0.379       0.365
#>  6 MIDDL…   0.159 0.310 0.207          0.0573       0.453       0.352
#>  7 MIDDL…   0.268 0.247 0.149          0.0791       0.475       0.368
#>  8 MIDDL…   0.261 0.300 0.126          0.137        0.450       0.337
#>  9 MIDDL…   0.315 0.198 0.140          0.0752       0.478       0.329
#> 10 MIDDL…   0.151 0.348 0.151          0.0830       0.474       0.322
#> # … with 638 more rows, and 7 more variables: commute6090 <dbl>,
#> #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
#> #   by_walk <dbl>, med_house_income <dbl>
```

However, if we look at comments above the tibble, we see something new: `# Groups: county [3]`. This tells us a couple of things. First that the groups were created using the `county` column, that there are fifteen groups, and that the data frame is now grouped implying that any future `mutate()` or `summarise()` calls will be performed on the specified groups. If we then look at the class of that grouped tibble we see that there is a new class introduced which is `grouped_df`.


```r
commute %>% 
  group_by(county) %>% 
  class()
#> [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

> Note: a tibble has the classes `tbl` and `tbl_df` on top of the Base R class `data.frame`.

When a tibble has this object class, dplyr knows that operations should be grouped. For example if you were to calculate the mean, this would be the mean for the specified groups rather than the mean for the entire dataset. 
One function that is extremely useful is the `n()` function to identify how many observations there are per group inside of a mutate call.

> I am including the `commute3060` column to illustrate that the new `n` column will be the same for each group value. 


```r
commute %>% 
  group_by(county) %>% 
  mutate(n = n()) %>% 
  select(county, commute3060, n) 
#> # A tibble: 648 x 3
#> # Groups:   county [3]
#>    county    commute3060     n
#>    <chr>           <dbl> <int>
#>  1 MIDDLESEX       0.375   318
#>  2 MIDDLESEX       0.344   318
#>  3 MIDDLESEX       0.382   318
#>  4 MIDDLESEX       0.379   318
#>  5 MIDDLESEX       0.365   318
#>  6 MIDDLESEX       0.352   318
#>  7 MIDDLESEX       0.368   318
#>  8 MIDDLESEX       0.337   318
#>  9 MIDDLESEX       0.329   318
#> 10 MIDDLESEX       0.322   318
#> # … with 638 more rows
```


Here each group only has one unique value for `n`. As discussed previously, when we want to calculate aggregate measures, there ought to only value per-group. This ability to perform grouped calculation within `mutate()`can be extremely powerful, but does not create a proper aggregated dataset. For this, we can again use `summarise()`

Let's recreate the grouped count from before.


```r
commute %>% 
  group_by(county) %>% 
  summarise(n = n())
#> `summarise()` ungrouping output (override with `.groups` argument)
#> # A tibble: 3 x 2
#>   county        n
#>   <chr>     <int>
#> 1 MIDDLESEX   318
#> 2 NORFOLK     130
#> 3 SUFFOLK     200
```

We can also include the summary statistic calculations from before. 


```r
commute %>% 
  group_by(county) %>% 
  summarise(
    n = n(),
    min_commute = min(commute3060, na.rm = TRUE),
    max_commute = max(commute3060, na.rm = TRUE),
    avg_commute = mean(commute3060, na.rm = TRUE),
    sd_commute  = sd(commute3060, na.rm = TRUE)
    )
#> `summarise()` ungrouping output (override with `.groups` argument)
#> # A tibble: 3 x 6
#>   county        n min_commute max_commute avg_commute sd_commute
#>   <chr>     <int>       <dbl>       <dbl>       <dbl>      <dbl>
#> 1 MIDDLESEX   318       0.104       0.612       0.383     0.0825
#> 2 NORFOLK     130       0.186       0.613       0.392     0.0761
#> 3 SUFFOLK     200       0           0.633       0.400     0.0972
```

