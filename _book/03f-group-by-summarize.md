# summarizing the tidy way



Now that we have a basic understanding of how to manipulate our dataset, summarising the dataset into a few useful metrics is important. When we have massive datasets with many subgroups, summary statistics will be very important for distilling all of that information into something consumable. Aggregation will also be very important for visualization purposes. 

We have already reviewed what constitutes a summary statistic and how to create them working with vectors. But we have not done so within the context of the tidyverse. We have figured out how to select, filter, mutate and all within a chain of functions. But we have not followed this to its natural next step, the `group_by()` and `summarise()` functions. 

## Counting

dplyr incluides a wonderful helper function called `count()`. It does just what it says it does. It counts the number of observations in a tibble. Let's recreate the `commute` tibble and see it for ourselves. 


```r
library(tidyverse)

commute <- read_csv("data/ACS_1317_TRACT.csv") %>% 
  select(
    county,
    starts_with("commute"),
    starts_with("by"),
    med_house_income
  ) 

count(commute)
## # A tibble: 1 x 1
##       n
##   <int>
## 1  1478
```

We can also count by groups in a data set. For example, we can count how many observations there are per county.


```r
count(commute, county)
## # A tibble: 15 x 2
##    county         n
##    <chr>      <int>
##  1 BARNSTABLE    54
##  2 BERKSHIRE     39
##  3 BRISTOL      122
##  4 DUKES          4
##  5 ESSEX        160
##  6 FRANKLIN      18
##  7 HAMPDEN      103
##  8 HAMPSHIRE     36
##  9 MIDDLESEX    318
## 10 NANTUCKET      5
## 11 NORFOLK      130
## 12 PLYMOUTH      99
## 13 SUFFOLK      200
## 14 WORCESTER    172
## 15 <NA>          18
```


`count()` is actually a wrapper around the function `summarise()` which is a much more flexible function. `summarise()` is the aggregate analog to `mutate()`. The difference between `mutate()` and `summarise()` is that the result of an expression in `mutate()` must have the same number of values as there are rows—unless of course you are specifying a scalar value like `TRUE`—whereas `summarise()` requires the result to be one an element of length one.

> Note: A scalar is a vector of length one.

We can recreate the first above `count()` call with `summarise()` and the handy `n()` function we learned a while ago. Here we follow the same pattern of assigning column names to expressions as we do with. 


```r
summarise(commute, n = n())
## # A tibble: 1 x 1
##       n
##   <int>
## 1  1478
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
## # A tibble: 1 x 4
##   min_commute max_commute avg_commute sd_commute
##         <dbl>       <dbl>       <dbl>      <dbl>
## 1           0       0.633       0.317      0.110
```

Frankly this alone is somewhat unimpressive. The power of `summarise()` comes from incorporating `group_by()` into the function chain. `group_by()` allows us to explicitly identify groups within a tibble as defined by a given variable. The resulting tibble from a `group_by()` call is seemingly unchanged. 


```r
commute %>% 
  group_by(county)
## # A tibble: 1,478 x 11
## # Groups:   county [15]
##    county commute_less10 commute1030 commute3060 commute6090 commute_over90
##    <chr>           <dbl>       <dbl>       <dbl>       <dbl>          <dbl>
##  1 WORCE…         0.0787       0.513       0.331      0.0556         0.0214
##  2 WORCE…         0.251        0.464       0.181      0.0822         0.0219
##  3 WORCE…         0.0537       0.662       0.177      0.0868         0.0203
##  4 WORCE…         0.141        0.394       0.313      0.133          0.0194
##  5 WORCE…         0.175        0.511       0.203      0.0704         0.0411
##  6 WORCE…         0.109        0.440       0.330      0.0830         0.0378
##  7 WORCE…         0.189        0.457       0.303      0.0346         0.0166
##  8 WORCE…         0.187        0.560       0.133      0.0839         0.0358
##  9 WORCE…         0.139        0.455       0.256      0.126          0.0246
## 10 WORCE…         0.0912       0.649       0.218      0.0179         0.0235
## # … with 1,468 more rows, and 5 more variables: by_auto <dbl>,
## #   by_pub_trans <dbl>, by_bike <dbl>, by_walk <dbl>, med_house_income <dbl>
```

However, if we look at comments above the tibble, we see something new: `# Groups: county [15]`. This tells us a couple of things. First that the groups were created using the `county` column, that there are fifteen groups, and that the data frame is now grouped implying that any future `mutate()` or `summarise()` calls will be performed on the specified groups. If we then look at the class of that grouped tibble we see that there is a new class introduced which is `grouped_df`.


```r
commute %>% 
  group_by(county) %>% 
  class()
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

> Note: a tibble has the classes `tbl` and `tbl_df` in addition

When a tibble has this object class, dplyr knows that operations should be grouped. For example if you were to calculate the mean, this would be the mean for the specified groups rather than the mean for the entire dataset. 

We can use the `n()` function to identify how many observations there are per group inside of a mutate call.

> I am including the `commute3060` column to illustrate that the new `n` column will be the same for each group value. 


```r
commute %>% 
  group_by(county) %>% 
  mutate(n = n()) %>% 
  select(county, commute3060, n) 
## # A tibble: 1,478 x 3
## # Groups:   county [15]
##    county    commute3060     n
##    <chr>           <dbl> <int>
##  1 WORCESTER       0.331   172
##  2 WORCESTER       0.181   172
##  3 WORCESTER       0.177   172
##  4 WORCESTER       0.313   172
##  5 WORCESTER       0.203   172
##  6 WORCESTER       0.330   172
##  7 WORCESTER       0.303   172
##  8 WORCESTER       0.133   172
##  9 WORCESTER       0.256   172
## 10 WORCESTER       0.218   172
## # … with 1,468 more rows
```


Here each group only has one unique value for `n`. As discussed previously, when we want to calculate aggregate measures, there ought to only value per-group. This ability to perform grouped calculation within `mutate()`can be extremely powerful, but does not create a proper aggregated dataset. For this, we can again use `summarise()`

Let's recreate the grouped count from before.


```r
commute %>% 
  group_by(county) %>% 
  summarise(n = n())
## # A tibble: 15 x 2
##    county         n
##    <chr>      <int>
##  1 BARNSTABLE    54
##  2 BERKSHIRE     39
##  3 BRISTOL      122
##  4 DUKES          4
##  5 ESSEX        160
##  6 FRANKLIN      18
##  7 HAMPDEN      103
##  8 HAMPSHIRE     36
##  9 MIDDLESEX    318
## 10 NANTUCKET      5
## 11 NORFOLK      130
## 12 PLYMOUTH      99
## 13 SUFFOLK      200
## 14 WORCESTER    172
## 15 <NA>          18
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
## # A tibble: 15 x 6
##    county         n min_commute max_commute avg_commute sd_commute
##    <chr>      <int>       <dbl>       <dbl>       <dbl>      <dbl>
##  1 BARNSTABLE    54     0.0402        0.305      0.171      0.0611
##  2 BERKSHIRE     39     0.0701        0.510      0.190      0.102 
##  3 BRISTOL      122     0.0599        0.442      0.249      0.0796
##  4 DUKES          4     0.0459        0.110      0.0744     0.0277
##  5 ESSEX        160     0.151         0.458      0.287      0.0664
##  6 FRANKLIN      18     0.186         0.454      0.283      0.0814
##  7 HAMPDEN      103     0.0495        0.480      0.226      0.0932
##  8 HAMPSHIRE     36     0.0318        0.569      0.264      0.138 
##  9 MIDDLESEX    318     0.104         0.612      0.383      0.0825
## 10 NANTUCKET      5     0.00587       0.120      0.0390     0.0470
## 11 NORFOLK      130     0.186         0.613      0.392      0.0761
## 12 PLYMOUTH      99     0.125         0.533      0.303      0.0596
## 13 SUFFOLK      200     0             0.633      0.400      0.0972
## 14 WORCESTER    172     0.0550        0.536      0.288      0.0810
## 15 <NA>          18     0.109         0.507      0.238      0.112
```

