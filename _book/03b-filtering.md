# That's _too much_ data



Let us continue with the scenario developed in the last chapter. There is a non-profit who is seeking graduate student assistance to provide a curated dataset that provides insight into the commuting behavior of the Greater Boston Area. Using BARI's Massachusetts' Census Indicators dataset, we were able to reduce the 52 initial columns down to 11. However these data are for the entire state not just the Greater Boston Area. This leaves us with two tasks: 1) define the Greater Boston Area and 2) create a subset of our data that fit our criteria defined in 1. 


```r
library(tidyverse)
library(uitk)

commute
```

```
## # A tibble: 648 x 14
##    county hs_grad  bach master commute_less10 commute1030 commute3060
##    <chr>    <dbl> <dbl>  <dbl>          <dbl>       <dbl>       <dbl>
##  1 MIDDL…   0.389 0.188 0.100          0.0916       0.357       0.375
##  2 MIDDL…   0.167 0.400 0.130          0.0948       0.445       0.344
##  3 MIDDL…   0.184 0.317 0.139          0.0720       0.404       0.382
##  4 MIDDL…   0.258 0.322 0.144          0.0983       0.390       0.379
##  5 MIDDL…   0.301 0.177 0.0742         0.0670       0.379       0.365
##  6 MIDDL…   0.159 0.310 0.207          0.0573       0.453       0.352
##  7 MIDDL…   0.268 0.247 0.149          0.0791       0.475       0.368
##  8 MIDDL…   0.261 0.300 0.126          0.137        0.450       0.337
##  9 MIDDL…   0.315 0.198 0.140          0.0752       0.478       0.329
## 10 MIDDL…   0.151 0.348 0.151          0.0830       0.474       0.322
## # … with 638 more rows, and 7 more variables: commute6090 <dbl>,
## #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
## #   by_walk <dbl>, med_house_income <dbl>
```

## `filter()`ing

Previously we looked at ways of selecting columns. Here, we will focus on creating subsets of our data. We will rely on the function `dplyr::filter()` for this. `filter()` differs from `slice()` in that filter will check to see if data fit a specified criteria whereas slice is only concerned with the position of a row. 

Explore the help documentation of `filter()` by running the command `?filter()` in your console.

The first argument of `filter()` is, of course, the tibble which you would like to subset. Secondly, we again see `...`. In the case of `filter()`, we provide what are called **logical expressions** to `...`. A logical expression is one that returns `TRUE` or `FALSE` values typically through a comparison of some sort. `filter()` then only returns the observations when that logical expression, or condition, is true. 

Almost every time you are shopping or browsing online, whether that is from Amazon or Etsy, you are filtering your search results using some logic. Whether that is checking the Prime tick box, specifying a price range on Etsy, or a restaurant rating on Yelp. These are all **conditions** that you are providing to your search. 

We can create these types of filters on our own data and to do so, we will need to understand how to craft logical expressions ourselves.

For example, using our `commute` dataset, we can check to see which Census Tracts have more than 75% of commuters traveling by automobile.

* Filter `commute` for values of `by_auto` that are greater than `0.75`. 
  - Assign the result to the object `auto_commuters`. 
* Select and print the `by_auto` column from `auto_commuters`.


```r
auto_commuters <- filter(commute, by_auto > 0.75)

select(auto_commuters, by_auto)
```

```
## # A tibble: 291 x 1
##    by_auto
##      <dbl>
##  1   0.857
##  2   0.862
##  3   0.888
##  4   0.884
##  5   0.967
##  6   0.905
##  7   0.935
##  8   0.915
##  9   0.913
## 10   0.906
## # … with 281 more rows
```

This above line checks every single value of `by_auto` and asks "is this value above 0.75?" and when it is filter will include that row in the output. Another way to say this is that when `by_auto` is above 0.75 _the condition is met_.

In R, as with other programming languages, there are a number of **logical operators** that are used to check for conditions. 

## Logical operators 

R has myriad ways to create logical expressions. Here we will focus on the six main _relational_ logical operators. These are called relational because we are checking to see how one value relates to another. In general we tend to ask questions like "are these the same?", "are they not the same?", and "is one value larger or smaller than another?". While you are getting the hang of it, I encourage you to try and verbalize logical expressions. 

* `<` : less than
* `>` : greater than
* `<=` : less than or equal to
* `>=` : greater than or equal to
* `==` : exactly equal (I like to think of it as _"are these the same thing?"_)
* `!=` : not equal ( _"are these things not the same"_)
* `!`: Negation. This returns the opposite value.

Let's bring it back to early algebra and work with the variable x and y. Let's say `x = 3` and `y = 5`. 

Is `x` less than `y`?


```r
# set variables.
x <- 3
y <- 5

x < y
```

```
## [1] TRUE
```

Yes it is. Here R returns a logical value which are represented as `TRUE` and `FALSE`. 

Is `x` greater than `y`?


```r
# greater than?
x > y
```

```
## [1] FALSE
```

And for the sake of illustration:


```r
# less than or equal
x <= y
```

```
## [1] TRUE
```

```r
# greater or equal
x >= y
```

```
## [1] FALSE
```

```r
# exactly equal?
x == y
```

```
## [1] FALSE
```

```r
# not equal
x != y
```

```
## [1] TRUE
```

The power of logical operators isn't necessarily in the ability to compare one value against another, but the ability to compare many values to one value or even many values to multiple other values. This is what `filter()` helps us do.

Using `filter()` we can compare one column to another. When we do this, the values of those columns at each row are compared. For example, we can identify all of the Census Tracts where people walk more than they drive. 

> Note: I am saving the results to an object called `walk` to then select only a few columns.


```r
walking <- filter(commute, by_walk > by_auto)

select(walking, county, by_walk, by_auto)
```

```
## # A tibble: 48 x 3
##    county    by_walk by_auto
##    <chr>       <dbl>   <dbl>
##  1 MIDDLESEX   0.427   0.213
##  2 MIDDLESEX   0.545   0.142
##  3 MIDDLESEX   0.372   0.287
##  4 MIDDLESEX   0.299   0.240
##  5 SUFFOLK     0.548   0.105
##  6 SUFFOLK     0.526   0.146
##  7 SUFFOLK     0.569   0.148
##  8 SUFFOLK     0.514   0.251
##  9 SUFFOLK     0.393   0.290
## 10 SUFFOLK     0.293   0.184
## # … with 38 more rows
```

We can also use filter to see where the walking rates and the driving rates are the same. As shown above we use `==` to test if things are the same. 

> **An important distinction**: `<-` is different from `=` and `=` is different from `==`. If you are ever confused about which operator to use ask yourself what your goal is. If your goal is to assign an object use `<-`. If your goal is to assign an argument value use `=`. And if you are trying to compare two things use `==`. 


```r
walk_auto <- filter(commute, by_walk == by_auto)

select(walk_auto, county, by_walk, by_auto)
```

```
## # A tibble: 1 x 3
##   county  by_walk by_auto
##   <chr>     <dbl>   <dbl>
## 1 SUFFOLK       0       0
```

So far we have only been checking one condition and in most cases this actually will not suffice. You may want to check multiple conditions at one time. When we use filter we can add a logical expression as another argument. In doing so, filter will check to see if both conditions are met and, when they are, that row is returned. This is called an "and" statement. Meaning condition one **and** condition two need to be `TRUE`.

Building upon the `walking` example, we can further narrow down the observations by adding a second condition which returns only the observations that have median household incomes below $40,000.


```r
low_inc_walk <- filter(commute, 
                       by_walk > by_auto,
                       med_house_income < 40000)

select(low_inc_walk, by_walk, by_auto, med_house_income)
```

```
## # A tibble: 10 x 3
##    by_walk by_auto med_house_income
##      <dbl>   <dbl>            <dbl>
##  1   0.581   0.214            21773
##  2   0.647   0.108            36250
##  3   0.407   0.170            34677
##  4   0.381   0.159            30500
##  5   0.465   0.192            28618
##  6   0.340   0.243            16094
##  7   0.536   0.112            19267
##  8   0.436   0.161            22930
##  9   0.451   0.170            36500
## 10   0.677   0.107            31218
```

### `&` statements: 

Now I want to introduce two more logical operators, **and** (`&`), which was implicitly used in the above filter statement, and **or** (`|`). `&` compares two conditions and will return `TRUE` only if they are both `TRUE`. `|` will return `TRUE` when one of the conditions is `TRUE`. 

Now for an illustrative example of `&` statements :


```r
# We have TRUE and TRUE, this should be false because they aren't both TRUE
TRUE & FALSE 
```

```
## [1] FALSE
```

```r
# both a TRUE, we expect TRUE
TRUE & TRUE
```

```
## [1] TRUE
```

```r
# The first statement is TRUE, but the second is not TRUE, expect FALSE
(1 == 1) & (1 < 1)
```

```
## [1] FALSE
```

```r
# The first statement is TRUE and the second is TRUE, expect TRUE
(1 == 1) & (1 <= 1)
```

```
## [1] TRUE
```

### `|` statements:

Or statements are used to evaluate whether or not something meets **at least** one of the two conditions. This means that the only time that an _or_ statement evaluates to `FALSE` is when both expressions result in `FALSE`.


```r
# True is present, so we expect TRUE
TRUE | TRUE
```

```
## [1] TRUE
```

```r
# True is present, so we expect TRUE
TRUE | FALSE
```

```
## [1] TRUE
```

```r
# 
FALSE | FALSE
```

```
## [1] FALSE
```

We can alter the previous `filter()` statement to show us places that walk more than they drive **or** have a low median household income.


```r
low_inc_or_walk <- filter(commute,
                          by_walk > by_auto | med_house_income < 40000)

select(low_inc_or_walk, by_walk, by_auto, med_house_income)
```

```
## # A tibble: 98 x 3
##    by_walk by_auto med_house_income
##      <dbl>   <dbl>            <dbl>
##  1 0.0729    0.824            38514
##  2 0.427     0.213            65000
##  3 0.545     0.142            44202
##  4 0.372     0.287            70972
##  5 0.299     0.240           116140
##  6 0.00933   0.688            39183
##  7 0.548     0.105            78616
##  8 0.526     0.146           116538
##  9 0.115     0.423            26125
## 10 0.0347    0.516            30283
## # … with 88 more rows
```

### Negation

Many times it will be easier to create a logical statement and say you want the _opposite_ of those results. In this case we will use the bang operator or the exclamation mark, `!`. To negate a logical value or logical statement put the bang **in front** of the statement or value.

For example we can make `FALSE` true by negating it.


```r
!FALSE
```

```
## [1] TRUE
```

We can take a previous example 


```r
# The first statement is TRUE and the second is TRUE, expect TRUE
(1 == 1) & (1 <= 1)
```

```
## [1] TRUE
```

```r
# negate it
!(1 == 1) & (1 <= 1)
```

```
## [1] FALSE
```

Keep this in your pocket for later. 

## Defining the Greater Boston Area

You now have developed the requisite skills to subset the commuting data to just the Greater Boston Area. But we still haven't completely decided what constitutes it. We will take the naïve approach and say that Suffolk, Norfolk, and Middlesex counties are the Greater Boston Area. We can now filter our data to just these counties!


```r
gba_commute <- filter(commute, county == "SUFFOLK" | county == "NORFOLK" | county == "MIDDLESEX")
```

The above code is actually rather redundant as we have written `county ==` three different times. When we using the same equality comparison we can actually use the sepcial `%in%` operator. This lets us look for a value **in** a vector of values (we'll learn more about vectors very shortly). 

For example:


```r
1 %in% c(1, 2, 3)
```

```
## [1] TRUE
```

This looks to see if the value on the left hand side is any of the three values in the vector—the thing that looks like `c(val1, val2, ...)`. Using this we can rewrite `gba_commute` as: 


```r
gba_commute <- filter(commute, county %in% c("SUFFOLK", "NORFOLK", "MIDDLESEX"))
```


### Writing Data

You have created the proper subset of data that is needed. However, there is one more hurdle of jump—sending the data. To do this we need to get the tibble out of R and into a data format that can be used—probably a csv. `readr` provides funcitonality to do this as well.

While we used `read_csv()` earlier, to write a csv we will use `write_csv()`. The functionality is beautifully simple. The first argument here will be the tibble that you're going to write, `gba_commute` in this case. And the second is the path to where you will write the data.

In general I recommend that your project has two folders. One titled `data-raw` where you will keep the scripts and raw data that you used to process the data. Then I suggest having a `data` folder as well. This is where you will keep your tidy, or finalized, data files. 


```r
write_csv(gba_commute, "data/gba_commute.csv")
```

Now you have a csv file that can be shared! 
