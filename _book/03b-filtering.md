# That's _too much_ data


```r
library(tidyverse)
acs_raw <- read_csv("data/ACS_1317_TRACT.csv")

commute <- select(acs_raw,
                  county,
                  hs_grad, bach, master,
                  starts_with("commute"),
                  starts_with("by"),
                  med_house_income)
```

Let us continue with the scenario developed in the last chapter. There is a non-profit who is seeking graduate student assistance to provide a curated dataset that provides insight into the commuting behavior of the Greater Boston Area. Using BARI's Massachussett's Census Indicators dataset, we were able to reduce the 52 initial columns down to 11. However these data are for the entire state not just the Greater Boston Area. This leaves us with two tasks: 1) definine the Greater Boston Area and 2) create a subset of our data that fit our criteria defined in 1. 


## `filter()`ing

Previously we looked at ways of selecting columns. Here, we will focus on creating subsets of our data. We will rely on the function `dplyr::filter()` for this. `filter()` differs from `slice()` in that filter will check to see if data fit a specified criteria whereas slice is only concerned with the position of a row. 

> Explore the help documentation of `filter()` by running the command `?filter()` in your console.

The first argument of `filter()` is of course the tibble which you would like to subset. Secondly, we again see `...`. In the case of `filter()`, we provide what are called logical expressions to `...`. `filter()` then only returns the observations when that logical expression, or condition, is true. 

Almost every time you purchase something online whether that is from Amazon or Etsy you are filtering your data using some logic. Whether that is checking the Prime tick box, specifying a price range on Etsy, or a restaurant rating on Yelp. These are all _conditions_ that you are providing to your search. 

We can create these types of filters on our own data and to do so, we will need to understand how logical expressions work. A logical expression is any expression that can be boiled down to true or false. 

For example, using our `commute` dataset, we can check to see which Census Tracts have more than 75% of commuters travelling by auto.


```r
auto_commuters <- filter(commute, by_auto > 0.75)

select(auto_commuters, by_auto)
```

```
## # A tibble: 1,012 x 1
##    by_auto
##      <dbl>
##  1   0.927
##  2   0.970
##  3   0.925
##  4   0.904
##  5   0.899
##  6   0.911
##  7   0.810
##  8   0.851
##  9   0.900
## 10   0.787
## # … with 1,002 more rows
```

This above line checks every single value of `by_auto` and asks "is this value above 0.75?" and when it is filter will include that row in the output. Another way to say this is that when `by_auto` is above 0.75 _the condition is met_.

In R, as with most other programming languages, there are a number of _logical operators_ that are used to check for conditions. We will learn these in the following section.

## Logical operators 

R has myriad ways to create logical expressions. Here we will focus on the six main _relational_ logical operators. These are called relational because we are checking to see how one value relates to another. In general we tend to ask questions like "are these the same?", "are they not the same?", and "is one value larger or smaller than another?". While you are getting the hang of it, I encourage you to try and verbalize logical expressions. 

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
## # A tibble: 54 x 3
##    county    by_walk by_auto
##    <chr>       <dbl>   <dbl>
##  1 HAMPSHIRE   0.652  0.0993
##  2 HAMPSHIRE   0.632  0.0985
##  3 HAMPSHIRE   0.580  0.189 
##  4 HAMPSHIRE   0.613  0.143 
##  5 HAMPSHIRE   0.625  0.0916
##  6 MIDDLESEX   0.427  0.213 
##  7 MIDDLESEX   0.545  0.142 
##  8 MIDDLESEX   0.372  0.287 
##  9 MIDDLESEX   0.299  0.240 
## 10 SUFFOLK     0.548  0.105 
## # … with 44 more rows
```

We can also use filter to see where the walking rates and the driving rates are the same. As shown above we use `==` to test if things are the same. 

> **An important distinction**: `<-` is different from `=` and `=` is different from `==`. If you are ever confused about which operator to use ask yourself what your goal is. If your goal is to assign an object use `<-`. If your goal is to assign an argument value use `=`. And if you are trying to compare two things use `==`. 


```r
walk_auto <- filter(commute, by_walk == by_auto)

select(walk_auto, county, by_walk, by_auto)
```

```
## # A tibble: 2 x 3
##   county  by_walk by_auto
##   <chr>     <dbl>   <dbl>
## 1 <NA>          0       0
## 2 SUFFOLK       0       0
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
## # A tibble: 224 x 3
##    by_walk by_auto med_house_income
##      <dbl>   <dbl>            <dbl>
##  1 0.0959    0.810            37093
##  2 0.102     0.800            31465
##  3 0.0478    0.813            14604
##  4 0.144     0.647            34940
##  5 0.0541    0.831            26615
##  6 0.0345    0.931            37935
##  7 0.0430    0.750            16400
##  8 0.0543    0.785            19548
##  9 0.00469   0.944            34821
## 10 0         0.955            34697
## # … with 214 more rows
```


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

------

## mutate

### scenario

- The non-profit has emailed you back and indicated that they want to report on the income quintiles and measures of educational attainment and requested that you do this for them. You're a rockstar and a kickass programmer so you oblige
- they also ask for:
  - tract
  - a combined measure of bach masters and doctoral
  

```r
commute <- mutate(commute, hh_inc_quin = ntile(med_house_income, 5),
         edu_attain = bach + master)

commute <- select(commute, -bach, -master)
```




## Writing Data



They define the greater boston area as Suffolk, Middlesex, and Norfolk counties. 

before we go ahead and start cleaning this data, we need to learn the tools to do so. Please bear with me! 
  
  
  - recall how to load the tidyverse
- we'll read in the `ACS_1317_TRACT.csv` file located in the `data` directory
  - putting this together the file path is `data/ACS_1317_TRACT.csv`.
  - store it in the variable `acs_raw`





------

old notes

To learn these tools we will work with a role-play / workthrough. 
a local non-profit is interested in learning about the demographic characteristics of the greater boston area. They are specifically interested to learn more about the relationship between the age, race, and economic status. They've come to you to provide them with the relevant data. you have acces to the annual BARI census data and you will curate the data for them. 


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


- we have now selected the columns we need to provide
-
