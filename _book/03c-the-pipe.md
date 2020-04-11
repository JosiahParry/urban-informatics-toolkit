# The pipe ` %>% ` 



Until now we have been using one function at a time. This can feel like it is rather limiting at times. The approach that we have been taking has been to perform some action, save the resultant object, and then perform another action. This leads to either overwriting the same existing object multiple times with an assignment ` <- ` or creating multiple other objects. The former solution does not have a great story for reproducibility. At any point within a script may refr to many different objects with the same name. The second solution can clutter your working environment and lead to an excess usage of memory.

Well then, "what do we do instead?" you may be asking. And my answer is "use the forward pipe operator, of course." The forward pipe operator looks like ` %>% `. This is a special function which allows the user to "pipe an object forward into a function or . . . expression" (Milton and Wickham, 2019). This is where the true power of the tidyverse comes from from. 

**What it does**: The pipe operator takes the object or the output an expression on it's left hand side `lhs` and provides that as the first argument in the function of the right hand side. Additionally, it exposes the `lhs` as a temporary variable `.`. It is documented as `lhs %>% rhs`.

The creator of [#TidyTuesday](https://github.com/rfordatascience/tidytuesday) and RStudio employee Thomas Mock has created a very illustrative example of how the pipe can simplify complex R function calls. 

The first example illustrates the creation of intermediate variables. 

```
did_something <- do_something(data)

did_another_thing <- do_another_thing(did_something)

final_thing <- do_last_thing(did_another_thing)
```

The second demonstrates nesting function calls inside of other function calls. 

```
final_thing <- do_last_thing(
  do_another_thing(
    do_something(
      data
    )
  )
)
```

Nested function calls are often difficult to debug and the user may get caught up in the mintuae of properly places parentheses.

> Note: Debugging is the process of taking misbehaving code and fixing it.

Using the pipe this chain of functions can be rewritten in the order that it happens.

```
final_thing <- data %>% 
  do_something() %>% 
  do_another_thing() %>% 
  do_last_thing()
```

By using the pipe we are able to align our thinking and code writing. Additionally, each function call is separated on its own line which makes debugging a less daunting task.

## Applying the pipe.

Remember how I pointed out that the first argument for almost every function is the data? This is where that comes in handy. This allows us to use the pipe to chain together functions and "makes it more intuitive to both read and write" (magrittr vignette).

The tidyverse was designed with this in mind. This is why `select()`, `filter()`, and `mutate()` among many others are data first functions. Moreover, the output of each function is always a data frame which allows the user to provide that output as input into the next function.

As always, the most helpful way to wrap your head around this is to see it in action. Let's take one of the lines of code we used above and adapt it to use a pipe. We will select the name column of our data again. Previously we may have written

```
my_tbl <- select(data_frame, ...)
smaller_tbl <- filter(my_tbl, ...)
new_col_tbl <- mutate(smaller_tbl, ...)
``` 

But now we are able to write more complex function chains such as 

```
data %>% 
  filter() %>% 
  mutate() %>% 
  select()
```

In the chapter on filtering data we began by reading in the data, selecting columns, and then filtered data. Here we will recreate the `low_inc_or_walk` object which identified Census Tracts that have a higher rate of commuters who walk than drive or have a median household income below $40,000. 


```r
library(tidyverse)

low_inc_or_walk <- read_csv("data/ACS_1317_TRACT.csv") %>% 
  select(
    county,
    starts_with("commute"),
    starts_with("by"),
    med_house_income
  ) %>% 
  filter(
    by_walk > by_auto,
    med_house_income < 40000
  )

glimpse(low_inc_or_walk)
#> Rows: 11
#> Columns: 11
#> $ county           <chr> "HAMPSHIRE", "SUFFOLK", "SUFFOLK", "SUFFOLK", "SUFFO…
#> $ commute_less10   <dbl> 0.40234261, 0.34490741, 0.41918528, 0.09421755, 0.06…
#> $ commute1030      <dbl> 0.5077599, 0.3726852, 0.4042926, 0.5200162, 0.552884…
#> $ commute3060      <dbl> 0.07027818, 0.22777778, 0.14673675, 0.35624747, 0.27…
#> $ commute6090      <dbl> 0.01288433, 0.04953704, 0.02058695, 0.02951880, 0.07…
#> $ commute_over90   <dbl> 0.006734993, 0.005092593, 0.009198423, 0.000000000, …
#> $ by_auto          <dbl> 0.1889132, 0.2140026, 0.1082621, 0.1704500, 0.159292…
#> $ by_pub_trans     <dbl> 0.04570873, 0.11933069, 0.15384615, 0.29191557, 0.30…
#> $ by_bike          <dbl> 0.014344761, 0.019815059, 0.008547009, 0.071286340, …
#> $ by_walk          <dbl> 0.5801118, 0.5808014, 0.6471306, 0.4066109, 0.380531…
#> $ med_house_income <dbl> 2499, 21773, 36250, 34677, 30500, 28618, 16094, 1926…
```

The reason this pipe works is because the output of each function call is yet another tibble and the pipe operator is passing that resultant tibble as the first argument to the next function. 

Not only does the pipe aid in the manipulation of data, it also has a lot of utility in crafting ggplots. By piping your tibble into a ggplot call, this allows you to quickly iterate on the input data from either filtering down your data to creating new variables for visualization purposes. 

The following sections will use the pipe operator in favor of the above listed alternatives. 

## Revisiting our scenario

Now that we have the pipe operator at our fingertips, we ought to think about how we can incorporate it into our previous work. In our earlier scenario we 


```r
acs_raw <- read_csv("data/ACS_1317_TRACT.csv")

commute <- select(acs_raw,
       county,
       hs_grad, bach, master,
       starts_with("commute"),
       starts_with("by"),
       med_house_income) %>% 
  filter(county %in% c("SUFFOLK", "NORFOLK", "MIDDLESEX"))
```





