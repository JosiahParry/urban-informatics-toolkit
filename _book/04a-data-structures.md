# Data Structures 




There is a topic I have been skirting around for some time now and I think it is time that we have to have a rather important conversation. It's one that is almost never fun but is quite necessary because without it, there may be many painful lessons learned in the future. We're going to spend this next chapter talking about data structures—but not all of them! We'll only cover the three most common and, by the end of this, it is my hope you will have a much stronger idea of _what_ you are working with and _why_ it behaves the way it does. 

We will cover vectors, data frames rather briefly, and lists. We'll talk about some of their defining characteristics and how we can interact with them. Often the theory behind these object types are ommitted, but I am of the mind that learning this early on will pay off in dividends. Take a deep breath before we dive in and remind yourself that it ain't nothin' but a thing.

## Vectors

I like to think of the vector as the building block of any R object. You've actually been working with vectors this entire time. But we haven't been very explicit about this yet. Up until this point we have been working mainly with tibbles. Each column of a tibble is _actually_ just a vector.

What makes a vector a vector is that it can only be **a single data type** and that they are _one-dimensional_—opposed to tibbles which are two-dimensional. You may have noticed that every value of a column is of the same data type. This means that they are rather strict to work with and for good reason. Imagine you wanted to multiple a column by 10, what would happen if a few of the values in the column were actually written out as text? Let's try exploring this idea. 

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

### Types of vectors

There are a total of six types of vectors. Fortunately, only four of these really matter to us. These are `integer`, `double`, `logical` and `character`.


## Data Frames

- accessing the underlying vectors of a data frame
  - `$` , `[`, `[[`, `pull()`
  
## Lists

- lists are the most flexible object in R
- data frames are actually just lists disguised as rectangles


```r
unclass(slice(acs_edu, 1:6))
```



