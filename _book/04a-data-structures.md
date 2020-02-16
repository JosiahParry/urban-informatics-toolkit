# Data Structures 




There is a topic I have been skirting around for some time now and I think it is time that we have to have a rather important conversation. It's one that is almost never fun but is quite necessary because without it, there may be many painful lessons learned in the future. We're going to spend this next chapter talking about data structures—but not all of them! We'll only cover the three most common and, by the end of this, it is my hope you will have a much stronger idea of _what_ you are working with and _why_ it behaves the way it does. 

We will cover vectors, data frames rather briefly, and lists. We'll talk about some of their defining characteristics and how we can interact with them. Often the theory behind these object types are ommitted, but I am of the mind that learning this early on will pay off in dividends. Take a deep breath before we dive in and remind yourself that it ain't nothin' but a thing.

## Atomic Vectors

I like to think of the atomic vector as the building block of any R object. You've actually been working with atomic vectors this entire time. But we haven't been very explicit about this yet. Up until this point we have been working mainly with tibbles. Each column of a tibble is _actually_  an atomic vector.

What makes a vector a atomic is that it can only be **a single data type** and that they are _one-dimensional_—opposed to tibbles which are two-dimensional (https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/). You may have noticed that every value of a column is of the same data type. This means that they are rather strict to work with and for good reason. Imagine you wanted to multiple a column by 10, what would happen if a few of the values in the column were actually written out as text? Let's try exploring this idea. 

The most common way to create a vector in R is to use the `c()` function. This stands for _combine_. We can `c`ombine as many elements as we want into a single vector using `c()`. Each element of the vector is it's own argument (separated by a comma).

For example if we wanted to create a vector of [Boston's unemployment rate](https://data.bls.gov/timeseries/LAUMT257165000000003?amp%253bdata_tool=XGtable&output_view=data&include_graphs=true) rate for each month in 2019 that we have data for (until October as of this writing on 2019-12-18) we could write the below. We will save it in a a vector called `unemp`.


```r
unemp <- c(3.2, 2.8, 2.8, 2.4, 2.8, 2.9, 2.7, 2.6, 2.7, 2.3)
unemp
##  [1] 3.2 2.8 2.8 2.4 2.8 2.9 2.7 2.6 2.7 2.3
```

What is really great about vectors is that we can perform any number of operations on them—i.e. find the sum of all the values, the average, add a value to each element, etc. 

If we wanted to find the average unemployment rate for Boston  for Jan - Oct. 2019, we can supply the vector to the function `mean()`. 


```r
mean(unemp)
## [1] 2.72
```

However, you may be thinking "there are 12 months in a year not 10 and that should be represented" and if you are, I totally agree with you. Since the data for November and December are missing, we should denote that and update `unemp` accordingly. R uses `NA` to represent missing data. To represent this we can append two `NA`s to the vector we have. There are two ways we can do this. We can either combine `unemp` with two `NA`s, or rewrite the above vector. 


```r
# combining existing with 2 NAs
c(unemp, NA, NA)
##  [1] 3.2 2.8 2.8 2.4 2.8 2.9 2.7 2.6 2.7 2.3  NA  NA
```

This works, but since we will be saving this to `unemp` again it is not best practices to use the variable you are changing in that objects assignment.


```r
# for example
unemp <- c(unemp, NA, NA)
```

The above is rather unclear and might confuse someone that will have to read your code at a later time—that person may even be you. For this reason we will redefine it.


```r
unemp <- c(3.2, 2.8, 2.8, 2.4, 2.8, 2.9, 2.7, 2.6, 2.7, 2.3, NA, NA)
unemp
##  [1] 3.2 2.8 2.8 2.4 2.8 2.9 2.7 2.6 2.7 2.3  NA  NA
```

We know that there are 12 elements in this vector, but sometimes it is quite nice to sanity check oneself. We can always find out how long (or how many elements are in) a vector is by supplying the vector to the `length()` function. 


```r
# how many observations are in `unemp`?
length(unemp)
## [1] 12
```


There are a total of six types of vectors. Fortunately, only four of these really matter to us. These are `integer`, `double`, `character`, `logical`.


- integers represent whole numbers
- to explicitly specify an integer we append an `L` after the number such as `20L`
- doubles are any nunber that requires any precision. you can specify doubles in a number of formats. 
  - we will use only decimals
- we bucket both integer and double into the category of numeric
- character vectors, as you have previously learned, are created by the use of quotations, either `"` or `'`. 

- we've already created a vector of type double, `unemp` 
  - you can check the type of vector is it with `typeof()`


```r
typeof(unemp)
## [1] "double"
```

- we can also create an integer vector to represent the month numerically. 
- you have also already learned this


```r
month <- 1:12

typeof(month)
## [1] "integer"
```

- there are also a number of constant vectors that are built into R these being the letters of the alphabet (`letters` and `LETTERS` respectively), as well as `month.abb`, `month.name`, and `pi`.
- `month.name` is already available


```r
typeof(month.name)
## [1] "character"
```

- logical vectors are represented as the values `TRUE` and `FALSE`.


- recall that vectors are atomic, meaning that there can only be one vector type. we cannot mix and match.
- When a character is the presence of another type of vector, that value is coerced into a character
- coersion is the process of contextually changing an objects from one type to another 


```r
x <- c("a", 1)

typeof(x)
## [1] "character"
```

- Something similar happens when a logical value is in the presence of a numeric value 


```r
c(TRUE, 1, FALSE)
## [1] 1 1 0
```

- in the presence of a numeric value, `TRUE` becomes equal to `1L` and `FALSE` equal to `0L` 
- this behavior exists whenever a logical value is presented in the context where a numeric is expected



```r
sum(TRUE, FALSE, FALSE)
## [1] 1
```

- while coersion occurs from other processes like combining values in a vector, _casting_ is the process of intentionally changing an object's class
- there are a number of casting functions
- these take the shape of `as.class()` o `as_class()`
- each of the vector types covered have their own casting functions such as `as. 


```r
as.integer(TRUE)
## [1] 1
as.character(123)
## [1] "123"
as.double("2.331")
## [1] 2.331
as.logical(0)
## [1] FALSE
```

- it is important to know how to change a vector's type.
- as you progress, you will find scenarios in which you need to cast objects from one class to another and these functions are the trick!

- You now have a strong understanding of the underbellies of R vectors
- But one thing that is missing is an understanding of how we can select subsets from vectors
- to extract a value from vectors we append square brackets at the end of the vector `vec[]`
- we can supply an index value to the square brackets to receive the value at that position

- to select the month of january from the `unemp` vector, we provide the value of `1` to the brackets. 


```r
unemp[1]
## [1] 3.2
```

- to extract more than one value, we provide a vector of the row indexes we desire


```r
unemp[c(1, 3)]
## [1] 3.2 2.8
```

- Now, there is yet another way to extract values from these vectors
- we can provide a logical vector to our square bracket index
- for example, we can identify every value of `unemp` that is above the average 


```r
# find average 
avg_unemp <- mean(unemp, na.rm = TRUE)

# identify which values are above average
index <- unemp > avg_unemp

index
##  [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE    NA
## [12]    NA
```

- notice that the `NA`s stayed `NA`? they can be pesky. as hadley says in adv R "Missing values tend to be infectious: most computations involving a missing value will return another missing value." (https://adv-r.hadley.nz/vectors-chap.html)
- provide the index to unemp to get the subset


```r
unemp[index]
## [1] 3.2 2.8 2.8 2.8 2.9  NA  NA
```

- how annoying those `NA`s can be!
- we can add another condition to our `index` line to remove `NA`
- like there are `as.*()` functions for casting, there are also `is.*()` functions for testing 
- `is.*()` returns a logical vector of the same length as the provided vector 


```r
is.na(unemp)
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [12]  TRUE
```

- as we learned, we can negate logical vectors with an `!`
- combine the negation with an and condition to only identify unemployment values above average _and_ aren't missing


```r
index <- unemp > avg_unemp & !is.na(unemp)

unemp[index]
## [1] 3.2 2.8 2.8 2.8 2.9
```

- there is one last thing to keep in mind when subsetting from a logical vector and that is vectors of different length
- when you use a logical vector to subset and they are of differing length, the logical vector will be recycled for the remaining values of the vector being subset
- an example will be the best
- say we have an object called `x` which are the values from 0 to 10 and an `index` to subset with 
- if we subset it with `index` and `index` is a logical vector of length two with the values of `TRUE` and `FALSE`, every other observation will be returned. This is because come the third value in `x`, R has ran out of values in `index` to use so it goes back to the beginning


```r
x <- 0:10

index <- c(TRUE, FALSE)

x[index]
## [1]  0  2  4  6  8 10
```

And what happens when the only value is a single logical value?


```r
x[TRUE]
##  [1]  0  1  2  3  4  5  6  7  8  9 10
```


```r
x[FALSE]
## integer(0)
```

In this latter case see how the output says `integer(0)`. This is informing you that the vector contains 0 elements. 

## Data Frames

The entirety of the work in this book so far has been with `tibbles`. Tibbles are actually a special type of data frame. Data frames are R's native way for storing rectangular data. Rectangles are two-dimensional, so are data frames.

Data frames are secretly just a bunch of vectors squished together. The important thing is that all vectors are of the same length. This ensures that each observation (row) has one value from each vector. Because of the nature of a data frame, each column must adhere to the rules of vectors. 

Let's create a tibble using the `unemp` vector and the `tibble()` function. `tibble()` works in a somewhat similar manner as `mutate()` where the arguments we provide are name value pairs. In the case of tibble, the argument take the form of `col_name = vector`.

We create a tibble with the unemployment rate below. 


```r
library(dplyr)

tibble(
  unemp_rate = unemp
)
## # A tibble: 12 x 1
##    unemp_rate
##         <dbl>
##  1        3.2
##  2        2.8
##  3        2.8
##  4        2.4
##  5        2.8
##  6        2.9
##  7        2.7
##  8        2.6
##  9        2.7
## 10        2.3
## 11       NA  
## 12       NA
```

We can add the month name and create a new column to indicate if that month has a higher than average unemployment rate.


```r
unemp_tbl <- tibble(
  unemp_rate = unemp, 
  month = month.name
) %>% 
  mutate(above_avg = unemp_rate > avg_unemp)

unemp_tbl
## # A tibble: 12 x 3
##    unemp_rate month     above_avg
##         <dbl> <chr>     <lgl>    
##  1        3.2 January   TRUE     
##  2        2.8 February  TRUE     
##  3        2.8 March     TRUE     
##  4        2.4 April     FALSE    
##  5        2.8 May       TRUE     
##  6        2.9 June      TRUE     
##  7        2.7 July      FALSE    
##  8        2.6 August    FALSE    
##  9        2.7 September FALSE    
## 10        2.3 October   FALSE    
## 11       NA   November  NA       
## 12       NA   December  NA
```


To interact with the underlying vector of a data frame we can use the dollar sign `$` operator. This takes the form of `tbl$col_name`.

For example, extracting the `unemp_rate` column looks like:


```r
unemp_tbl$unemp_rate
##  [1] 3.2 2.8 2.8 2.4 2.8 2.9 2.7 2.6 2.7 2.3  NA  NA
```

Note that the difference between `select(tbl, col)` and `tbl$col`.


```r
select(unemp_tbl, unemp_rate)
## # A tibble: 12 x 1
##    unemp_rate
##         <dbl>
##  1        3.2
##  2        2.8
##  3        2.8
##  4        2.4
##  5        2.8
##  6        2.9
##  7        2.7
##  8        2.6
##  9        2.7
## 10        2.3
## 11       NA  
## 12       NA
```

The difference is that `$` returns the underlying vector whereas `select()` will always return another data frame. You now have the ability to both filter data and grab a subset of a vector. But we have yet to visit how to grab a single value from a data frame. 

You could try something like


```r
unemp_tbl %>% 
  select(1) %>% 
  slice(10)
## # A tibble: 1 x 1
##   unemp_rate
##        <dbl>
## 1        2.3
```

to grab the 10th value of the first column. But again, you still have a tibble and you are not able to use that directly like a standalone number.

We can again use brackets to subset the our R object. But data frames are two dimensional, so we need to specify the indexes in two dimensions. If you have made a hand drawn graph used a cartesian plane, which I assume you all have, this will is the same idea. With a cartesian plane we can identify any point with a combination of two values: x and y. x refers to the horizontal axis and y the vertical axis. When we put the cartesian plane in the same frame of reference as the rectangular data frame we envision our rows as the x and our columns as the y. 

To replicate the above example we would provide the indexes 10 and 1 respectively. 


```r
unemp_tbl[10,1]
## # A tibble: 1 x 1
##   unemp_rate
##        <dbl>
## 1        2.3
```

This is great, we've rewritten our tidyverse code in base R. But, just like the tidyverse code, we maintain the tibble data structure. This is because when we use a single bracket, it maintains the data structure of the object we are selecting from. If we wrap our brackets in another set of bracket, we are returned the an object of the same class as the underlying object.


```r
unemp_tbl[[10,1]]
## [1] 2.3
```

What that code is doing is narrowing the tibble down to a single column with a single row index and then extracting the underlying vector (the second bracket). To extract the underlying vector using the tidyverse, we can use the function `dplyr::pull()`.


```r
unemp_tbl %>% 
  select(1) %>% 
  slice(10) %>% 
  pull()
## [1] 2.3
```

Now this brings us to the second-most fundamental structure in R: the list. Yes, second-most fundamental. I've been keeping a secret from you. Data frames are actually just lists in disguise. To prove it, I will remove the class from `unemp_tbl` and return the class of that unclassed object.


```r
unclass(unemp_tbl) %>% 
  class()
## [1] "list"
```

  
## Lists


Lists are the most flexible object in R. 
- lists are the most flexible object in R
- data frames are actually just lists disguised as rectangles


```r
unclass(slice(acs_edu, 1:6))
```



