# Summary statistics 





The last chapter we focused on the underlying data structures that we interact with in R. Most importantly we covered the atomic vector data structure and learned that the columns of a tibble are vectors. When we have been using `mutate()` to create new columns, we have actually been creating other vectors. When we have filtered data, we have checked the values of the underlying vectors to see if they have matched our specified conditions. Moving forward, we will begin to think about ways of summarizing our data. To do so we will be working with vectors more often. Being able to understand the role a vector plays in data frame operations will make this learning process even easier. 

Let us start by asking the question _"what is a statistic?"_ Very simply a statistic is a single number that is used to characterize a sample of data. Most often we see statistics used to describe central tendancy and spread—measures like the mean and standard deviation. However, the ways in which we can characterize a sample of data are not restricted to traditional frequentists statistics. We want to be more creative in the ways that we look at our data. In addition to evaluating central tendancy and spread we may find ourselves looking at the average word counts of tweets, or distances from the Boston Common, and so much more.  

When we begin to summarize data, we are taking all observations or maybe a subset of observations and calculating one value to represent that sample. This is very important framing to have. Whenever we want to create an aggregate measure of our data there must be only one observation per-subset. Meaning, if you have a data frame with 150 rows and 3 groups within that, there ought to be only three resultant observations—though there may be many more variables.  

Let us revisit the `commute`, and specifically the rate of commuters who travel between 30 and 60 minutes. 


```r
library(tidyverse)
library(uitk)

commute
#> # A tibble: 648 x 14
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


It is of course of interest to identify the average rate of 30-60 minute commuting, as well as the standard deviation, and median. What does this look like and how is it done? Prior to measuring central tendency and spread, we begin by visualizing our data. The purpose of visualizing your data before hand is to give you an intuition of how it may behave and its shape.


```r
ggplot(commute, aes(commute3060)) +
  geom_histogram(bins = 20)
#> Warning: Removed 6 rows containing non-finite values (stat_bin).
```

<img src="03e-summary-stats_files/figure-html/unnamed-chunk-4-1.png" width="100%" />

In the above histogram we can intuit a number of things. The distribution looks fairly normally distributed meaning that both the mean and median are likely to be close to eachother and are equally sound measures of center, most likely somewhere around 0.3. Secondly, due to the distribution's rather round shape (or "fat tails"), it can be expected to have a rather large standard deviation. Once the intuition has been developed, one should calculate the relevant statistics to quantify these characteristics. 


Let's calculate the mean, median, standard deviation, and range of this single variable. When calculating statistics like the mean and standard deviation, we are calculating univariate statistics and as such, working with only one column (variable) at a time—this tends to be the case almost always.

We will first extract the `commute3060` column as a vector using `dplyr::pull()`.


```r
 commute_rate <- pull(commute, commute3060)
```

> Exercise: Read the help documentation for the functions `mean()`, `median()`, and `sd()` to get a sense of how these functions work. Calculate the mean, median, and standard deviation of `commute_rate`.


```r
mean(commute_rate)
#> [1] NA

median(commute_rate)
#> [1] NA

sd(commute_rate)
#> [1] NA
```

The results of these functions bring good and bad news. The good news is that their output is a single value. The bad news is that the output is `NA`. To reiterate a previous point, `NA` will infect your analyses. The only way to get around this is to perform these calculations without them. 

Note that each of the functions used above have an argument called `na.rm`. `na.rm` tells R to remove the NAs prior to calculation. We can recalculate these statistics with the `na.rm` argument set to `TRUE`. 


```r
mean(commute_rate, na.rm = TRUE)
#> [1] 0.3896481

median(commute_rate, na.rm = TRUE)
#> [1] 0.3921988

sd(commute_rate, na.rm = TRUE)
#> [1] 0.08624757
```

Let us look at one last example: identifying the range. The `range()` function returns the minimum and the maximum values.


```r
(commute_range <- range(commute_rate, na.rm = TRUE))
#> [1] 0.0000000 0.6327961
```

> Note: by wrapping an assignment in parentheses, the resultant object will be printed to the console. 

`range()` returned two values. This can be verified with the `length()` function.


```r
length(commute_range)
#> [1] 2
```

A length two vector does not adhere to providing just out value. We will see why this is a problem illustrated in the next chapter. To recreate this, use the `min()` and `max()` functions. 


```r
min(commute_rate, na.rm = TRUE)
#> [1] 0
max(commute_rate, na.rm = TRUE)
#> [1] 0.6327961
```

Each of these statistics—mean, median, standard deviation, etc—are a way to characterize a larger sample of data. The lesson to take away here is that we will always need a single value when summarising data. Often we will be taking a column (vector) and calculating a single metric from that.

In the following chapter we will learn how to calculate summary statistics using the tidyverse. 
