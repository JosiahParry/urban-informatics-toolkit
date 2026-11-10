# Creating new measures 





It's been a week now and the non-profit has finally emailed you back. They were ecstatic with what you provided but it begat even more questions for them. They indicated that while the median household income data was very intruiging, that would be difficult for them to report on. As such, they would like you to report on the income quintiles as well. Moreover, they also would like to see the rate of Bachelor's and Master's degrees combined into one general educational attainment variable. 

This poses some challenges for you. You know _what_ is being asked, just not necessarily _how_ to achieve that from R. To accomplish this we're going to have to learn how to use the `dplyr::mutate()` function. For the sake of example, let's select only the columns that we're going to need and make a tibble called `df` just to work with. 


```r
library(tidyverse)
library(uitk)

df <- select(commute, med_house_income, bach, master)

df
#> # A tibble: 648 x 3
#>    med_house_income  bach master
#>               <dbl> <dbl>  <dbl>
#>  1            75085 0.188 0.100 
#>  2           132727 0.400 0.130 
#>  3           110694 0.317 0.139 
#>  4           109125 0.322 0.144 
#>  5            76746 0.177 0.0742
#>  6           138700 0.310 0.207 
#>  7           104673 0.247 0.149 
#>  8            73191 0.300 0.126 
#>  9           121488 0.198 0.140 
#> 10            99358 0.348 0.151 
#> # … with 638 more rows
```


`mutate()` is a function that let's us create or modify variables. The arguments for `mutate()` are the same as those for `select()`—`.data` and `...`. In the case of `mutate()` dots works a little bit differently. After indicating our data, we create columns by specifying a name-value pair. More simply the names of our arguments will be the name of the columns that we are creating. The value is any expression. For example we could use `mutate(df, one = 1)` to create a column called `one` with the value of 1. When using mutate, however, the result from the expression needs to be either only  _one_ value, or as many values as there are rows. 

If we take our `df`, we can add the columns `bach` and `master` together to create a new column called `edu_attain`. 


```r
mutate(df, edu_attain = bach + master)
#> # A tibble: 648 x 4
#>    med_house_income  bach master edu_attain
#>               <dbl> <dbl>  <dbl>      <dbl>
#>  1            75085 0.188 0.100       0.288
#>  2           132727 0.400 0.130       0.531
#>  3           110694 0.317 0.139       0.456
#>  4           109125 0.322 0.144       0.466
#>  5            76746 0.177 0.0742      0.251
#>  6           138700 0.310 0.207       0.516
#>  7           104673 0.247 0.149       0.396
#>  8            73191 0.300 0.126       0.426
#>  9           121488 0.198 0.140       0.338
#> 10            99358 0.348 0.151       0.499
#> # … with 638 more rows
```

We could even think about ways that we can check if some observations are above some specified income threshold.


```r
mutate(df, above_70k_inc = med_house_income > 80000) 
#> # A tibble: 648 x 4
#>    med_house_income  bach master above_70k_inc
#>               <dbl> <dbl>  <dbl> <lgl>        
#>  1            75085 0.188 0.100  FALSE        
#>  2           132727 0.400 0.130  TRUE         
#>  3           110694 0.317 0.139  TRUE         
#>  4           109125 0.322 0.144  TRUE         
#>  5            76746 0.177 0.0742 FALSE        
#>  6           138700 0.310 0.207  TRUE         
#>  7           104673 0.247 0.149  TRUE         
#>  8            73191 0.300 0.126  FALSE        
#>  9           121488 0.198 0.140  TRUE         
#> 10            99358 0.348 0.151  TRUE         
#> # … with 638 more rows
```

This function is immensly useful and can be combined with almost any expression to create new data for us. Furthermore there are a number of handy functions built into dplyr that help us create new columns. Some of these are `case_when()`, `min_rank()`, and `ntile()` among others. You can always explore these with `?function_name()`. For our purposes, we will look at the use of `ntile()`. 

`ntile()` is a function that will calculate percentiles for us. Given a column of data, `x`, and a number of buckets, `n`, we can create a new column of ranks. In our case, we are interested in calculating the quintile of `med_house_income`. This means we can provide `med_house_income` and `n = 5` as arguments to `ntile()` to group our observations by quintile. 


```r
mutate(df, inc_quintile = ntile(med_house_income, 5))
#> # A tibble: 648 x 4
#>    med_house_income  bach master inc_quintile
#>               <dbl> <dbl>  <dbl>        <int>
#>  1            75085 0.188 0.100             2
#>  2           132727 0.400 0.130             5
#>  3           110694 0.317 0.139             4
#>  4           109125 0.322 0.144             4
#>  5            76746 0.177 0.0742            2
#>  6           138700 0.310 0.207             5
#>  7           104673 0.247 0.149             4
#>  8            73191 0.300 0.126             2
#>  9           121488 0.198 0.140             5
#> 10            99358 0.348 0.151             4
#> # … with 638 more rows
```

Now we can put everything together into one mutate call to create the new variables that were requested! 


```r
updated_commute <- commute %>% 
  mutate(edu_attain = bach + master, 
         inc_quintile = ntile(med_house_income, 5))
```

As you have made these changes you can now write the data again to csv and share it. As this process becomes more and more iterative, it's good to put _some_ structure to the data so you have an idea of the history. One general practice that is good to get into is dating your files. So in this case I would label the file `yyyy-mm-dd-commute.csv`.
