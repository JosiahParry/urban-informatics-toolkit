# filter


```r
library(tidyverse)
acs_raw <- read_csv("data/ACS_1317_TRACT.csv")

commute <- select(acs_raw,
                  name,
                  starts_with("commute"),
                  starts_with("by"),
                  med_house_income)
```

Let us continue with the scenario developed in the last chapter. There is a non-profit who is seeking graduate student assistance to provide a curated dataset that provides insight into the commuting behavior of the Greater Boston Area. Using BARI's Massachussett's Census Indicators dataset, we were able to reduce the 52 initial columns down to 11. However, these data are for the entire state not just the Greater Boston Area. This leaves us with two tasks: 1) definine the Greater Boston Area and 2) create a subset of our data that fit our criteria defined in 1. 

Previously we looked at ways of selecting columns. Here, we will focus on creating subsets of our data. We will rely on the function `dplyr::filter()` for this. `filter()` differs from `slice()` in that filter will check to see if data fit a certain criteria whereas slice is only concerned with the position of a row. 

`filter()` works similarly to `select()`. The first argument is of course the tibble which you would like to subset. Secondly, we again see `...`. In the case of `filter()`, we provide what are called logical expressions to `...`. `filter()` then only returns the observations when that logical expression, or condition, is true. 

I would go out on a limb here and say that almost every time you purchase something online whether that is via Amazon Prime or Etsy you are filtering your data using some logic. Whether that is checking the Prime tick box, specifying a price range on Etsy, or a restaurant rating on Yelp. These are all _conditions_ that you are providing to your search. 

We can create these types of filters on our own data and to do so, we will need to understand how logical expressions work. A logical expression is any expression that can be boiled down to true or false. 

For example, using our `commute` dataset, we can check to see which Census Tracts have more than 75% of commuters travelling by auto.


```r
filter(commute, by_auto > 0.75)
```

```
## # A tibble: 1,012 x 11
##    name  commute_less10 commute1030 commute3060 commute6090 commute_over90
##    <chr>          <dbl>       <dbl>       <dbl>       <dbl>          <dbl>
##  1 Cens…         0.0787       0.513       0.331      0.0556         0.0214
##  2 Cens…         0.251        0.464       0.181      0.0822         0.0219
##  3 Cens…         0.0537       0.662       0.177      0.0868         0.0203
##  4 Cens…         0.141        0.394       0.313      0.133          0.0194
##  5 Cens…         0.175        0.511       0.203      0.0704         0.0411
##  6 Cens…         0.109        0.440       0.330      0.0830         0.0378
##  7 Cens…         0.189        0.457       0.303      0.0346         0.0166
##  8 Cens…         0.187        0.560       0.133      0.0839         0.0358
##  9 Cens…         0.139        0.455       0.256      0.126          0.0246
## 10 Cens…         0.0912       0.649       0.218      0.0179         0.0235
## # … with 1,002 more rows, and 5 more variables: by_auto <dbl>,
## #   by_pub_trans <dbl>, by_bike <dbl>, by_walk <dbl>,
## #   med_house_income <dbl>
```

This above line checks every single value of `by_auto` and askes "is this value above 0.75?" and when it is filter will include that row in the output. Another way to say this is that when `by_auto` is above 0.75 _the condition is met_.

In R, as with most other programming languages, there are a number of _logical operators_ that are used to check for conditions. We will learn these in the following section.

## Logical operators 

R has myriad ways to create logical expressions. Here we will focus on the six main _relational_ logical operators. These are called relational because we are checking to see how a value related to another. In general we tend to ask questions like "are these the same?", "are they not the same?", and "is one value larger or smaller than another?". While you are getting the hang of it, I encourage you to try and verbalize logical expressions. 

* `<` : less than
* `>` : greater than
* `<=` : less than or equal to
* `>=` : greater than or equal to
* `==` : exactly equal (I like to think of it as _"are these the same thing?"_)
* `!=` : not equal ( _"are these things not the same"_)

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

select(walking, name, by_walk, by_auto)
```

```
## # A tibble: 54 x 3
##    name                                                  by_walk by_auto
##    <chr>                                                   <dbl>   <dbl>
##  1 Census Tract 8212, Hampshire County, Massachusetts      0.652  0.0993
##  2 Census Tract 8208.02, Hampshire County, Massachusetts   0.632  0.0985
##  3 Census Tract 8204, Hampshire County, Massachusetts      0.580  0.189 
##  4 Census Tract 8220, Hampshire County, Massachusetts      0.613  0.143 
##  5 Census Tract 8206, Hampshire County, Massachusetts      0.625  0.0916
##  6 Census Tract 3537, Middlesex County, Massachusetts      0.427  0.213 
##  7 Census Tract 3539, Middlesex County, Massachusetts      0.545  0.142 
##  8 Census Tract 3540, Middlesex County, Massachusetts      0.372  0.287 
##  9 Census Tract 3541, Middlesex County, Massachusetts      0.299  0.240 
## 10 Census Tract 202, Suffolk County, Massachusetts         0.548  0.105 
## # … with 44 more rows
```

We can also use filter to see where the walking rates and the driving rates are the same. As shown above we use `==` to test if things are the same. This is an important distinction to make. `<-` is different from `=` and `=` is different from `==`. If you are ever confused about which operator to use ask yourself what your goal is. If your goal is to assign an object use `<-`. If your goal is to assign an argument value use `=`. And if you are trying to compare two things use `==`. 


```r
walk_auto <- filter(commute, by_walk == by_auto)

select(walk_auto, name, by_walk, by_auto)
```

```
## # A tibble: 2 x 3
##   name                                                by_walk by_auto
##   <chr>                                                 <dbl>   <dbl>
## 1 Census Tract 9901.01, Suffolk County, Massachusetts       0       0
## 2 Census Tract 9815.02, Suffolk County, Massachusetts       0       0
```

So far we have only been checking one condition and in most cases this actually wont suffice. You may want to check multiple conditions at one time. When we use filter we can add a logical expression as another argument. In doing so, filter will check to see if both conditions are met and when they are, that row is returned. This is called an "and" statement. Meaning condition one **and** condition two need to be `TRUE`.

Building upon the `walking` example, we can further narrow down the observations by adding a second condition which returns only the observations that have median household income below $40,000.


```r
low_inc_walk <- filter(commute, 
       by_walk > by_auto,
       med_house_income < 40000)

select(low_inc_walk, by_walk, by_auto, med_house_income)
```

```
## # A tibble: 11 x 3
##    by_walk by_auto med_house_income
##      <dbl>   <dbl>            <dbl>
##  1   0.580   0.189             2499
##  2   0.581   0.214            21773
##  3   0.647   0.108            36250
##  4   0.407   0.170            34677
##  5   0.381   0.159            30500
##  6   0.465   0.192            28618
##  7   0.340   0.243            16094
##  8   0.536   0.112            19267
##  9   0.436   0.161            22930
## 10   0.451   0.170            36500
## 11   0.677   0.107            31218
```


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

Illustrative `|` statements:

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


------

Alright, so now I want to talk about the `!` (called the _**bang**_ operator) and its nuance. See how we put `!` in front of our `=`? The bang operator essentially checks the opposite of a thing. So in this case it checked the opposite of equals. If we put `!` in front of a logical expression, it will reverse the outcome. 


```r
1 == 1
```

```
## [1] TRUE
```

```r
!(1 == 1)
```

```
## [1] FALSE
```







### scenario

- we have now selected the columns we need to provide

## mutate

### scenario

- The non-profit has emailed you back and indicated that they want to report on the income quintiles and requested that you do this for them. You're a rockstar and a kickass programmer so you're like, hell yah. 
- they also ask for:
  - tract
  - a combined measure of bach masters and doctoral
  

```r
acs_raw %>% 
  mutate(hh_inc_quin = ntile(med_house_income, 5))
```

```
## # A tibble: 1,478 x 60
##    ct_id_10 name  total_pop pop_den sex_ratio age_u18 age1834 age3564
##       <dbl> <chr>     <dbl>   <dbl>     <dbl>   <dbl>   <dbl>   <dbl>
##  1  2.50e10 Cens…      4585    333.     1.13    0.234   0.202   0.398
##  2  2.50e10 Cens…      2165   1070.     1.32    0.181   0.151   0.461
##  3  2.50e10 Cens…      6917   2113.     1.13    0.171   0.214   0.437
##  4  2.50e10 Cens…      7278   1346.     1.12    0.203   0.227   0.436
##  5  2.50e10 Cens…      5059   2894.     1.30    0.177   0.203   0.430
##  6  2.50e10 Cens…      6632    472.     1.11    0.163   0.237   0.439
##  7  2.50e10 Cens…      3259   8022.     1.25    0.191   0.326   0.380
##  8  2.50e10 Cens…      2097   5191.     0.908   0.202   0.183   0.466
##  9  2.50e10 Cens…      3098    239.     0.990   0.188   0.150   0.462
## 10  2.50e10 Cens…      3982  17065.     1.19    0.244   0.286   0.342
## # … with 1,468 more rows, and 52 more variables: age_o65 <dbl>,
## #   for_born <dbl>, white <dbl>, black <dbl>, asian <dbl>, hispanic <dbl>,
## #   two_or_more <dbl>, eth_het <dbl>, med_house_income <dbl>,
## #   pub_assist <dbl>, gini <dbl>, fam_pov_per <dbl>, unemp_rate <dbl>,
## #   total_house_h <dbl>, fam_house_per <dbl>, fem_head_per <dbl>,
## #   same_sex_coup_per <dbl>, grand_head_per <dbl>, less_than_hs <dbl>,
## #   hs_grad <dbl>, some_coll <dbl>, bach <dbl>, master <dbl>, prof <dbl>,
## #   doc <dbl>, commute_less10 <dbl>, commute1030 <dbl>, commute3060 <dbl>,
## #   commute6090 <dbl>, commute_over90 <dbl>, by_auto <dbl>,
## #   by_pub_trans <dbl>, by_bike <dbl>, by_walk <dbl>,
## #   total_house_units <dbl>, vacant_unit_per <dbl>, renters_per <dbl>,
## #   home_own_per <dbl>, med_gross_rent <dbl>, med_home_val <dbl>,
## #   med_yr_built_raw <dbl>, med_yr_built <chr>, med_yr_moved_inraw <dbl>,
## #   med_yr_rent_moved_in <dbl>, area_acres <dbl>, town_id <dbl>,
## #   town <chr>, fips_stco <dbl>, county <chr>, area_acr_1 <dbl>,
## #   m_atown <chr>, hh_inc_quin <int>
```

_i need to introduce measures of central tendency and summar stats in between this_

- groups
- summarizing


using the `name` column I can consider introducing string methods
  - this would probably be better done with text reviews or something
  
  


## writing data lol



They define the greater boston area as Suffolk, Middlesex, and Norfolk counties. 

before we go ahead and start cleaning this data, we need to learn the tools to do so. Please bear with me! 
  
  
  - recall how to load the tidyverse
- we'll read in the `ACS_1317_TRACT.csv` file located in the `data` directory
  - putting this together the file path is `data/ACS_1317_TRACT.csv`.
  - store it in the variable `acs_raw`


To learn these tools we will work with a role-play / workthrough. 
a local non-profit is interested in learning about the demographic characteristics of the greater boston area. They are specifically interested to learn more about the relationship between the age, race, and economic status. They've come to you to provide them with the relevant data. you have acces to the annual BARI census data and you will curate the data for them. 
