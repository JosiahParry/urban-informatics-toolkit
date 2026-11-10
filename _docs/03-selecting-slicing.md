# General data manipulation






We spent the last chapter performing our first exploratory visual analysis. From our visualizations we were able to inductively conclude that as both median household income and the proportion of the population with a bachelors degree increases, so does the share of the population that is white. 

While we were able to make wonderful visualizations, we did skip a number of steps in the exploratory analysis process! Arguably the most important is that we skipped the curation of our dataset. The ACS dataset was already cleaned and curated for you. This almost always will not be the case. As such, we're going to spend this chapter learning about ways of selecting subsets of our data.

Now that you have the ability to read in data, it is important that you get comfortable handling it. Some people call the process of rearranging, cleaning, and reshaping data massaging, plumbing, engineering, or myriad other names. Here, we will refer to this as data manipulation. This is a preferable catch-all term that does not illicit images of toilets or Phoebe Buffay (she was a masseuse!). 

You may have heard of the 80/20 rule, or at least one of the many 80/20 rules. The 80/20 rule I'm referring to is the idea that data scientists will spend 80% or more of their time cleaning and manipulating their data. The other 20% is the analysis part—creating statistics and models. I mention this because working with data is _mostly_ data manipulation and only _some_ statistics. Be prepared to get your hands dirty with data.

This is all to say that you will find yourself with messy-unsanitized-gross-not-fun-to-look-at data most of the time. Because of this, it is really important that we have the skills to clean our data. Right now we're going to go over the foundational skills we will learn how to select columns and rows, filter data, and create new columns, and arrange our data. To do this, we will be using the [`dplyr`](https://dplyr.tidyverse.org) package from the tidyverse. 

The data we used in in the last chapter was only a select few variables from the annual census data release that the team at the Boston Area Research Initiative (BARI) provides. These census indicators are used to provide a picture into the changing landscape of Boston and Massachusetts more generally. In this chapter we will work through a rather real life scenario that you may very well encounter using the BARI data. 

## Scenario

A local non-profit is interested in the commuting behavior of Greater Boston residents. Your adviser suggested that you assist the non-profit in their work. You've just had coffee with the project manager to learn more about what their specific research question is. It seems that the extension of the Green Line is of great interest to them. She spoke at length about the history of the Big Dig and its impact on commuters working in the city. This poured over into a conversation about the spatial and social stratification of a city. She looks at her watch and realizes she's about to miss the commuter train home. You shake their hand, thank them for their time (and the free coffee because you're a grad student), and affirm that you will email them in a week or so with some data for them to work with.

You're back at your apartment, french press next your laptop—though not too close—notes open, and ready to begin. You pore over your notes and realize while you now have a rather good understanding of _what_ the Green Line Extensions is and the impact that the Big Dig had, you really have no idea what about commuting behavior in Greater Boston they are interested in. You realize you did not even confirm what constitutes the Greater Boston area. You push down the coffee grinds and pour your first cup of coffee. This will take at least two cups of coffee. 

The above scenario sounds like something out of a stress dream. This is scenario that I have found myself in many times and I am sure that you will find yourself in at one point as well. The more comfortable you get with data analysis and asking good questions, the more guided and directed you can make these seemingly vague objectives. 


## Getting physical with the data 

The data we used in both chapters one and two were curated from the [annual census indicator release](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/XZXAUP) from BARI[^indicators]. This is the dataset from which `acs_edu` was created. We will use these data to provide relevant data relating to commuting in the Greater Boston Area. The first thing you'll notice is that these data are large and somewhat unforgiving to work with. What a better way to get started than with big data?

We will be using the tidyverse to read in and manipulate our data (as we did last chapter). Recall that we will load the tidyverse using `library(tidyverse)`. 

> Refresher: the tidyverse is a collection of packages used for data analysis. When you load the tidyverse it loads `readr`, `ggplot2`, and `dplyr` for us, among other packages. For now, though, these are the only relevant packages. 



Load the tidyverse and uitk.


```r
library(tidyverse)
library(uitk)
```

Wonderful! Once we have the data accessible from R, it is important to get familiar with what the data are. This means we need to know _which_ variables are available to us and get a feel for what the values in those variables represent. 

Try printing out the `acs_raw` object in your console. 


```r
acs_raw
```


Oof, yikes. It's a bit messy! Not to mention that R did not even print out all of the columns. That's because it ran out of room. When we're working with wide data (many columns), it's generally best to view only a preview of the data. The function `dplyr::glimpse()` can help us do just that. `glimpse()` provide a summary overview of a data frame. The output will first tell us how many rows and columns there are. Then, in order as appears in the object, prints the column name followed by its type—e.g. `<dbl>` , or `<chr>` for double and character—and the first few values of that column.

Provide `acs_raw` as the only argument to `glimpse()`.


```r
glimpse(acs_raw)
```

Much better, right? It is frankly still a lot of text, but the way it is presented is rather useful. Each variable is written followed by its data type, i.e. `<dbl>`, and then a preview of values in that column. If the `<dbl>` does not make sense yet, do not worry. We will go over data types in depth later. Data types are not the most fun and I think it is important we have fun! 

`acs_raw` is the dataset from which `acs_edu` was created. As you can see, there are many, many, _many_ different variables that the ACS data provide us with. These are only the tip of the iceberg. 

Now have a think. 

Looking at the preview of these data, which columns do you think will be most useful to the non-profit for understanding commuter behavior? "All of them" is not always the best answer. By providing too much data one may be moved to inaction because they now must determine what variables are the most useful and how to use them. 

If you spotted the columns commute_less10, commute1030, commute3060, commute6090, and commute_over90, your eyes and intuition have served you well! These variables tell us about what proportion of the sampled population in a given census tract have commute times that fall within the indicated duration range, i.e. 30-60.

### `select()`ing

So now we have an intuition of the most important variables, but the next problem soon arises: how do we isolate just these variables? Whenever you find yourself needing to select or deselect columns from a tibble `dplyr::select()` will be the main function that you will go to. `select()` selects variables from a tibble and returns another tibble. 

Before we work through how to use `select()`, refer to the help documentation and see if you can get somewhat of an intuition by running `?select()` into the console. Once you press enter, the documentation page should pop up in RStudio. 

There are a few reasons why I am directing you towards the function documentation.

1. To get you comfortable with navigating the RStudio IDE.
2. Expose you to the R vocabulary.
3. Soon you'll be too advanced for this book and will have to figure out the way functions work on your own! 

Perhaps the help documentation was a little overwhelming and absolutely confusing. That's okay. It's just an exposure! With each exposure things will make more sense. Let's tackle these arguments one by one. 

> `.data`: A tbl. All main verbs are S3 generics and provide methods for tbl_df(), dtplyr::tbl_dt() and dbplyr::tbl_dbi().

What I want you to take away from this argument definition is "A tbl". Whenever you read `tbl` think to your self "oh, that is just a `tibble`." If you recall, when we read rectangular data with `readr::read_csv()` or any other `readr::read_*()` function we will end up with a tibble. To verify that this is the case, we can double check our objects using the function `is.tbl()`. This function takes an object and returns a logical value (`TRUE` or `FALSE`) if the statement is true. Let's double check that `acs_raw` is in fact a `tbl`.


```r
is.tbl(acs_raw)
#> [1] TRUE
```

> Aside: Each object type usually has a function that let's you test if objects are that type that follow the structure `is.obj_type()` or the occasional `is_obj_type()`. We will go over object types more later. 

We can read the above as if we are asking R the question "is this object a `tbl`?" The resultant output of `is.tbl(acs_raw)` is `TRUE`. Now we can be doubly confident that this object can be used with `select()`. 

The second argument to `select()` is a little bit more difficult to grasp, so don't feel discouraged if this isn't clicking right away. There is _a lot_ written in this argument definition and I feel that not all of it is necessary to understand from the get go. 

> `...`: 	One or more unquoted expressions separated by commas. You can treat variable names like they are positions, so you can use expressions like x:y to select ranges of variables.

`...`, referred to as "dots" means that we can pass any number of arguments to the function. Translating "one or more unquoted expressions separated by commas" into regular person speak reiterates that there can be multiple other arguments passed into `select()`. "Unquoted expressions" means that if we want to select a column we do not put that column name in quotes. 

"You can treat variable names like they are positions" translates to "if you want the first column you can write the number `1` etc." and because of this, if you want the first through tenth variable you can pass `1:10` as an argument to `...`.

The most important thing about `...` is that we **do not** assign `...` as an argument, for example . `... = column_a` is **not** the correct notation. We provide `column_a` alone. 

As always, this makes more sense once we see it in practice. We will now go over the many ways in which we can select columns using `select()`. Once we have gotten the hang of selecting columns we will return back to assisting our non-profit.

We will go over: 

- selecting by name
- selecting by position
- select helpers


### `select()`ing exercises 

`select()` enables us to choose columns from a tibble based on their names. But remember that these will be unquoted column names. 

Try it:

- select the column `name` from `acs_raw`


```r
select(acs_raw, name)
#> # A tibble: 1,478 x 1
#>    name                                                 
#>    <chr>                                                
#>  1 Census Tract 7281, Worcester County, Massachusetts   
#>  2 Census Tract 7292, Worcester County, Massachusetts   
#>  3 Census Tract 7307, Worcester County, Massachusetts   
#>  4 Census Tract 7442, Worcester County, Massachusetts   
#>  5 Census Tract 7097.01, Worcester County, Massachusetts
#>  6 Census Tract 7351, Worcester County, Massachusetts   
#>  7 Census Tract 7543, Worcester County, Massachusetts   
#>  8 Census Tract 7308.02, Worcester County, Massachusetts
#>  9 Census Tract 7171, Worcester County, Massachusetts   
#> 10 Census Tract 7326, Worcester County, Massachusetts   
#> # … with 1,468 more rows
```

The column `name` was passed to `...`. Recall that dots allows us to pass "one ore more unquoted expressions separated by commas." To test this statement out, select `town` in addition to `name` from `acs_raw`

Try it:

- select `name` and `town` from `acs_raw`


```r
select(acs_raw, name, town)
#> # A tibble: 1,478 x 2
#>    name                                                  town         
#>    <chr>                                                 <chr>        
#>  1 Census Tract 7281, Worcester County, Massachusetts    HOLDEN       
#>  2 Census Tract 7292, Worcester County, Massachusetts    WEST BOYLSTON
#>  3 Census Tract 7307, Worcester County, Massachusetts    WORCESTER    
#>  4 Census Tract 7442, Worcester County, Massachusetts    MILFORD      
#>  5 Census Tract 7097.01, Worcester County, Massachusetts LEOMINSTER   
#>  6 Census Tract 7351, Worcester County, Massachusetts    LEICESTER    
#>  7 Census Tract 7543, Worcester County, Massachusetts    WEBSTER      
#>  8 Census Tract 7308.02, Worcester County, Massachusetts WORCESTER    
#>  9 Census Tract 7171, Worcester County, Massachusetts    BERLIN       
#> 10 Census Tract 7326, Worcester County, Massachusetts    WORCESTER    
#> # … with 1,468 more rows
```

Great, you're getting the hang of it. 

Now, in addition to to selecting columns solely based on their names, we can also select a range of columns using the format `col_from:col_to`. In writing this `select()` will register that you want every column from and including `col_from` up until and including `col_to`. 

Let's refresh ourselves with what our data look like:


```r
glimpse(acs_raw)
```


Try it:

- select the columns `age_u18` through `age_o65`.


```r
select(acs_raw, age_u18:age_o65)
#> # A tibble: 1,478 x 4
#>    age_u18 age1834 age3564 age_o65
#>      <dbl>   <dbl>   <dbl>   <dbl>
#>  1   0.234   0.202   0.398   0.166
#>  2   0.181   0.151   0.461   0.207
#>  3   0.171   0.214   0.437   0.178
#>  4   0.203   0.227   0.436   0.133
#>  5   0.177   0.203   0.430   0.190
#>  6   0.163   0.237   0.439   0.162
#>  7   0.191   0.326   0.380   0.102
#>  8   0.202   0.183   0.466   0.148
#>  9   0.188   0.150   0.462   0.200
#> 10   0.244   0.286   0.342   0.128
#> # … with 1,468 more rows
```

Now to really throw you off! You can even reverse the order of these ranges. 

Try it:

- select columns from `age_o65` to `age_u18`.


```r
select(acs_raw, age_o65:age_u18)
#> # A tibble: 1,478 x 4
#>    age_o65 age3564 age1834 age_u18
#>      <dbl>   <dbl>   <dbl>   <dbl>
#>  1   0.166   0.398   0.202   0.234
#>  2   0.207   0.461   0.151   0.181
#>  3   0.178   0.437   0.214   0.171
#>  4   0.133   0.436   0.227   0.203
#>  5   0.190   0.430   0.203   0.177
#>  6   0.162   0.439   0.237   0.163
#>  7   0.102   0.380   0.326   0.191
#>  8   0.148   0.466   0.183   0.202
#>  9   0.200   0.462   0.150   0.188
#> 10   0.128   0.342   0.286   0.244
#> # … with 1,468 more rows
```


### Selecting by position

<!-- Alright, so now we have gotten the hang of selecting columns based on their names. But equally important is the ability to select columns based on their position. Consider the situation in which you regularly receive georeferenced data from a research partner and the structure of the dataset is rather consistent _except_ that they frequently change the name of the coordinate columns. Sometimes the columns are `x` and `y`. Sometimes they are capitalized `X` and `Y`, `lon` and `lat`, or even `long` and `lat`. It eats you up inside! But you know that while the names may change, their positions never do—they're always the last two columns. You decide to program a solution rather than having a conversation with your research partner—though, I recommend you both level set on reproducibility standards. -->

 > "...You can treat variable names like they are positions..."
 
 The above was taken from the argument definition of dots `...`. Like providing the name of the column, we can also provide their positions (also referred to as an index). In our previous example, we selected the `name` column. We can select this column by it's position too. `name` is the second column in our tibble. We select it by position like so:


```r
select(acs_raw, 2)
#> # A tibble: 1,478 x 1
#>    name                                                 
#>    <chr>                                                
#>  1 Census Tract 7281, Worcester County, Massachusetts   
#>  2 Census Tract 7292, Worcester County, Massachusetts   
#>  3 Census Tract 7307, Worcester County, Massachusetts   
#>  4 Census Tract 7442, Worcester County, Massachusetts   
#>  5 Census Tract 7097.01, Worcester County, Massachusetts
#>  6 Census Tract 7351, Worcester County, Massachusetts   
#>  7 Census Tract 7543, Worcester County, Massachusetts   
#>  8 Census Tract 7308.02, Worcester County, Massachusetts
#>  9 Census Tract 7171, Worcester County, Massachusetts   
#> 10 Census Tract 7326, Worcester County, Massachusetts   
#> # … with 1,468 more rows
```

Try it:

- select `age_u18` and `age_o65` by their position


```r
select(acs_raw, 6, 9)
#> # A tibble: 1,478 x 2
#>    age_u18 age_o65
#>      <dbl>   <dbl>
#>  1   0.234   0.166
#>  2   0.181   0.207
#>  3   0.171   0.178
#>  4   0.203   0.133
#>  5   0.177   0.190
#>  6   0.163   0.162
#>  7   0.191   0.102
#>  8   0.202   0.148
#>  9   0.188   0.200
#> 10   0.244   0.128
#> # … with 1,468 more rows
```

You may see where I am going with this. Just like column names, we can select a range of columns using the same method `index_from:index_to`.

Try it:

- select the columns from `age_u18` to `age_o65` using `:` and the column position
- select the columns in reverse order by their indexes 


```r
select(acs_raw, 6:9)
#> # A tibble: 1,478 x 4
#>    age_u18 age1834 age3564 age_o65
#>      <dbl>   <dbl>   <dbl>   <dbl>
#>  1   0.234   0.202   0.398   0.166
#>  2   0.181   0.151   0.461   0.207
#>  3   0.171   0.214   0.437   0.178
#>  4   0.203   0.227   0.436   0.133
#>  5   0.177   0.203   0.430   0.190
#>  6   0.163   0.237   0.439   0.162
#>  7   0.191   0.326   0.380   0.102
#>  8   0.202   0.183   0.466   0.148
#>  9   0.188   0.150   0.462   0.200
#> 10   0.244   0.286   0.342   0.128
#> # … with 1,468 more rows
```


```r
select(acs_raw, 9:6)
#> # A tibble: 1,478 x 4
#>    age_o65 age3564 age1834 age_u18
#>      <dbl>   <dbl>   <dbl>   <dbl>
#>  1   0.166   0.398   0.202   0.234
#>  2   0.207   0.461   0.151   0.181
#>  3   0.178   0.437   0.214   0.171
#>  4   0.133   0.436   0.227   0.203
#>  5   0.190   0.430   0.203   0.177
#>  6   0.162   0.439   0.237   0.163
#>  7   0.102   0.380   0.326   0.191
#>  8   0.148   0.466   0.183   0.202
#>  9   0.200   0.462   0.150   0.188
#> 10   0.128   0.342   0.286   0.244
#> # … with 1,468 more rows
```

> Base R Side Bar: To help build your intuition, I want to point out some base R functionality. Using the colon `:` with integers (whole numbers) is actually not a `select()` specific functionality. This is something that is rather handy and built directly into R. Using the colon operator, we can create ranges of numbers in the same exact way as we did above. If we want create the range of numbers from 1 to 10, we write `1:10`. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10.

In our scenario, we want to select the last two columns. We may not know their names _or_ their position. Luckily, there's a function for that.

<!-- ![](https://i.imgflip.com/3p2zow.jpg) --> 

`last_col()` is a handy function that enables us to select the last column. There is also an option to get an offset from the last column. An offset would allow us to grab the second to last column by setting the offset to 1. By setting the offset, `last_col()` will from the `offset + 1` from the last column. So if the offset is set to 1, we would be grabbing the second to last column.

Let's give it a shot:


```r
select(acs_raw, last_col())
#> # A tibble: 1,478 x 1
#>    m_atown      
#>    <chr>        
#>  1 HOLDEN       
#>  2 WEST BOYLSTON
#>  3 WORCESTER    
#>  4 MILFORD      
#>  5 LEOMINSTER   
#>  6 LEICESTER    
#>  7 WEBSTER      
#>  8 WORCESTER    
#>  9 BERLIN       
#> 10 WORCESTER    
#> # … with 1,468 more rows
select(acs_raw, last_col(offset = 1))
#> # A tibble: 1,478 x 1
#>    area_acr_1
#>         <dbl>
#>  1     23242.
#>  2      8868.
#>  3     24610.
#>  4      9616.
#>  5     18993.
#>  6     15763.
#>  7      9347.
#>  8     24610.
#>  9      8431.
#> 10     24610.
#> # … with 1,468 more rows
select(acs_raw, last_col(offset = 1):last_col())
#> # A tibble: 1,478 x 2
#>    area_acr_1 m_atown      
#>         <dbl> <chr>        
#>  1     23242. HOLDEN       
#>  2      8868. WEST BOYLSTON
#>  3     24610. WORCESTER    
#>  4      9616. MILFORD      
#>  5     18993. LEOMINSTER   
#>  6     15763. LEICESTER    
#>  7      9347. WEBSTER      
#>  8     24610. WORCESTER    
#>  9      8431. BERLIN       
#> 10     24610. WORCESTER    
#> # … with 1,468 more rows
```


`last_col()` comes from another packages called `tidyselect` which is imported with `dplyr`. This package contains a number of helper functions. There are 9 total helpers and you've already learned one of them. We will briefly review four more of these. I'm sure you are able to deduce how the functions work solely based on their names. The functions are:

- `starts_with()`: a string to search that columns start with
- `ends_with()`: a string to search that columns end with
- `contains()`: a string to search for in the column names at any position
- `everything()`: selects the remaining columns

Each of these function take a character string and searches the column headers for them. 

Try it out:

- find all columns that start with `"med"`


```r
select(acs_raw, starts_with("med"))
#> # A tibble: 1,478 x 7
#>    med_house_income med_gross_rent med_home_val med_yr_built_raw med_yr_built
#>               <dbl>          <dbl>        <dbl>            <dbl> <chr>       
#>  1           105735           1640       349000             1988 1980 to 1989
#>  2            69625            894       230200             1955 1950 to 1959
#>  3            70679           1454       207200             1959 1950 to 1959
#>  4            74528            954       268400             1973 1970 to 1979
#>  5            52885           1018       223200             1964 1960 to 1969
#>  6            64100            867       232700             1966 1960 to 1969
#>  7            37093            910       170900             1939 Prior to 19…
#>  8            87750           1088       270100             1939 Prior to 19…
#>  9            97417           1037       379600             1981 1980 to 1989
#> 10            43384           1017       156500             1939 Prior to 19…
#> # … with 1,468 more rows, and 2 more variables: med_yr_moved_inraw <dbl>,
#> #   med_yr_rent_moved_in <dbl>
```

- select columns that end with `"per"`


```r
select(acs_raw, ends_with("per"))
#> # A tibble: 1,478 x 8
#>    fam_pov_per fam_house_per fem_head_per same_sex_coup_p… grand_head_per
#>          <dbl>         <dbl>        <dbl>            <dbl>          <dbl>
#>  1      0.0475         0.797       0.0899            0            0      
#>  2      0.0652         0.698       0.120             0            0.00583
#>  3      0.0584         0.659       0.114             0            0      
#>  4      0.0249         0.657       0.121             0            0      
#>  5      0.198          0.531       0.158             0            0.00946
#>  6      0.0428         0.665       0.0603            0            0.0353 
#>  7      0.0762         0.632       0.227             0            0.00643
#>  8      0.101          0.636       0.0582            0.297        0.0260 
#>  9      0.0149         0.758       0.0721            0            0.00434
#> 10      0.0954         0.460       0.225             0            0.0279 
#> # … with 1,468 more rows, and 3 more variables: vacant_unit_per <dbl>,
#> #   renters_per <dbl>, home_own_per <dbl>
```

- find any column that contains the string `"yr"`


```r
select(acs_raw, contains("yr"))
#> # A tibble: 1,478 x 4
#>    med_yr_built_raw med_yr_built  med_yr_moved_inraw med_yr_rent_moved_in
#>               <dbl> <chr>                      <dbl>                <dbl>
#>  1             1988 1980 to 1989                2004                 2012
#>  2             1955 1950 to 1959                2003                 2010
#>  3             1959 1950 to 1959                2007                 2012
#>  4             1973 1970 to 1979                2006                 2011
#>  5             1964 1960 to 1969                2006                 2011
#>  6             1966 1960 to 1969                2000                 2009
#>  7             1939 Prior to 1940               2011                 2012
#>  8             1939 Prior to 1940               2006                 2012
#>  9             1981 1980 to 1989                2004                 2012
#> 10             1939 Prior to 1940               2011                   NA
#> # … with 1,468 more rows
```

- select columns that start with `med` then select everything else


```r
select(acs_raw, contains("yr"), everything())
#> # A tibble: 1,478 x 59
#>    med_yr_built_raw med_yr_built med_yr_moved_in… med_yr_rent_mov… ct_id_10
#>               <dbl> <chr>                   <dbl>            <dbl>    <dbl>
#>  1             1988 1980 to 1989             2004             2012  2.50e10
#>  2             1955 1950 to 1959             2003             2010  2.50e10
#>  3             1959 1950 to 1959             2007             2012  2.50e10
#>  4             1973 1970 to 1979             2006             2011  2.50e10
#>  5             1964 1960 to 1969             2006             2011  2.50e10
#>  6             1966 1960 to 1969             2000             2009  2.50e10
#>  7             1939 Prior to 19…             2011             2012  2.50e10
#>  8             1939 Prior to 19…             2006             2012  2.50e10
#>  9             1981 1980 to 1989             2004             2012  2.50e10
#> 10             1939 Prior to 19…             2011               NA  2.50e10
#> # … with 1,468 more rows, and 54 more variables: name <chr>, total_pop <dbl>,
#> #   pop_den <dbl>, sex_ratio <dbl>, age_u18 <dbl>, age1834 <dbl>,
#> #   age3564 <dbl>, age_o65 <dbl>, for_born <dbl>, white <dbl>, black <dbl>,
#> #   asian <dbl>, hispanic <dbl>, two_or_more <dbl>, eth_het <dbl>,
#> #   med_house_income <dbl>, pub_assist <dbl>, gini <dbl>, fam_pov_per <dbl>,
#> #   unemp_rate <dbl>, total_house_h <dbl>, fam_house_per <dbl>,
#> #   fem_head_per <dbl>, same_sex_coup_per <dbl>, grand_head_per <dbl>,
#> #   less_than_hs <dbl>, hs_grad <dbl>, some_coll <dbl>, bach <dbl>,
#> #   master <dbl>, prof <dbl>, doc <dbl>, commute_less10 <dbl>,
#> #   commute1030 <dbl>, commute3060 <dbl>, commute6090 <dbl>,
#> #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
#> #   by_walk <dbl>, total_house_units <dbl>, vacant_unit_per <dbl>,
#> #   renters_per <dbl>, home_own_per <dbl>, med_gross_rent <dbl>,
#> #   med_home_val <dbl>, area_acres <dbl>, town_id <dbl>, town <chr>,
#> #   fips_stco <dbl>, county <chr>, area_acr_1 <dbl>, m_atown <chr>
```

## Selecting Rows

Though a somewhat infrequent event, it will be handy to know how to select rows. There are two ways in which we can select our rows. The first is by specifying exactly which rows by their position. The other way is to filter down our data based on a condition—i.e. median household income within a range. The functions to do this are `slice()` and `filter()` respectively. The remainder of this chapter will introduce you to `slice()`. We will learn how to filter in the next chapter.

Like `select()` we can also select rows. But rows do not have names, so we must select the rows based on their position. Given your familiarity with selecting by column position this should be a cake walk for you. 

Similar to `last_col()` we have the function `n()`. `n()` is a rather handy little function which tells us how many observations there are in a tibble. This allows to specify the last row of a tibble. 


```r
slice(acs_raw, n())
#> # A tibble: 1 x 59
#>   ct_id_10 name  total_pop pop_den sex_ratio age_u18 age1834 age3564 age_o65
#>      <dbl> <chr>     <dbl>   <dbl>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1  2.50e10 Cens…      5821   2760.     0.885   0.181   0.204   0.435   0.180
#> # … with 50 more variables: for_born <dbl>, white <dbl>, black <dbl>,
#> #   asian <dbl>, hispanic <dbl>, two_or_more <dbl>, eth_het <dbl>,
#> #   med_house_income <dbl>, pub_assist <dbl>, gini <dbl>, fam_pov_per <dbl>,
#> #   unemp_rate <dbl>, total_house_h <dbl>, fam_house_per <dbl>,
#> #   fem_head_per <dbl>, same_sex_coup_per <dbl>, grand_head_per <dbl>,
#> #   less_than_hs <dbl>, hs_grad <dbl>, some_coll <dbl>, bach <dbl>,
#> #   master <dbl>, prof <dbl>, doc <dbl>, commute_less10 <dbl>,
#> #   commute1030 <dbl>, commute3060 <dbl>, commute6090 <dbl>,
#> #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
#> #   by_walk <dbl>, total_house_units <dbl>, vacant_unit_per <dbl>,
#> #   renters_per <dbl>, home_own_per <dbl>, med_gross_rent <dbl>,
#> #   med_home_val <dbl>, med_yr_built_raw <dbl>, med_yr_built <chr>,
#> #   med_yr_moved_inraw <dbl>, med_yr_rent_moved_in <dbl>, area_acres <dbl>,
#> #   town_id <dbl>, town <chr>, fips_stco <dbl>, county <chr>, area_acr_1 <dbl>,
#> #   m_atown <chr>
```

Unlike `last_col()`, `n()` provides us with a number. Instead of specifying an offset we can instead subtract directly from the output of `n()`. To grab the last three rows we can write `(n() - 3):n()`. We put `n()-3` inside of parantheses so R knows to process `n() - 3` first.


```r
slice(acs_raw, (n() - 3):n())
#> # A tibble: 4 x 59
#>   ct_id_10 name  total_pop pop_den sex_ratio age_u18 age1834 age3564 age_o65
#>      <dbl> <chr>     <dbl>   <dbl>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1  2.50e10 Cens…      2519   3083.     0.806   0.202   0.268   0.397   0.132
#> 2  2.50e10 Cens…      3500   5392.     1.05    0.205   0.277   0.395   0.122
#> 3  2.50e10 Cens…      5816   2677.     1.20    0.191   0.233   0.458   0.118
#> 4  2.50e10 Cens…      5821   2760.     0.885   0.181   0.204   0.435   0.180
#> # … with 50 more variables: for_born <dbl>, white <dbl>, black <dbl>,
#> #   asian <dbl>, hispanic <dbl>, two_or_more <dbl>, eth_het <dbl>,
#> #   med_house_income <dbl>, pub_assist <dbl>, gini <dbl>, fam_pov_per <dbl>,
#> #   unemp_rate <dbl>, total_house_h <dbl>, fam_house_per <dbl>,
#> #   fem_head_per <dbl>, same_sex_coup_per <dbl>, grand_head_per <dbl>,
#> #   less_than_hs <dbl>, hs_grad <dbl>, some_coll <dbl>, bach <dbl>,
#> #   master <dbl>, prof <dbl>, doc <dbl>, commute_less10 <dbl>,
#> #   commute1030 <dbl>, commute3060 <dbl>, commute6090 <dbl>,
#> #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
#> #   by_walk <dbl>, total_house_units <dbl>, vacant_unit_per <dbl>,
#> #   renters_per <dbl>, home_own_per <dbl>, med_gross_rent <dbl>,
#> #   med_home_val <dbl>, med_yr_built_raw <dbl>, med_yr_built <chr>,
#> #   med_yr_moved_inraw <dbl>, med_yr_rent_moved_in <dbl>, area_acres <dbl>,
#> #   town_id <dbl>, town <chr>, fips_stco <dbl>, county <chr>, area_acr_1 <dbl>,
#> #   m_atown <chr>
```


Try it:

- select the first row, rows 100-105, and the last row


```r
slice(acs_raw, 1, 100:105, n())
#> # A tibble: 8 x 59
#>   ct_id_10 name  total_pop pop_den sex_ratio age_u18 age1834 age3564 age_o65
#>      <dbl> <chr>     <dbl>   <dbl>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1  2.50e10 Cens…      4585    333.     1.13    0.234  0.202    0.398  0.166 
#> 2  2.50e10 Cens…      5223   2402.     1.21    0.183  0.171    0.450  0.197 
#> 3  2.50e10 Cens…      5586    592.     1.09    0.278  0.116    0.413  0.193 
#> 4  2.50e10 Cens…      4474   1119.     0.962   0.282  0.0847   0.427  0.206 
#> 5  2.50e10 Cens…      6713    674.     0.928   0.223  0.216    0.423  0.139 
#> 6  2.50e10 Cens…      6676   3541.     0.999   0.249  0.266    0.395  0.0902
#> 7  2.50e10 Cens…      8141    820.     1.25    0.258  0.169    0.410  0.164 
#> 8  2.50e10 Cens…      5821   2760.     0.885   0.181  0.204    0.435  0.180 
#> # … with 50 more variables: for_born <dbl>, white <dbl>, black <dbl>,
#> #   asian <dbl>, hispanic <dbl>, two_or_more <dbl>, eth_het <dbl>,
#> #   med_house_income <dbl>, pub_assist <dbl>, gini <dbl>, fam_pov_per <dbl>,
#> #   unemp_rate <dbl>, total_house_h <dbl>, fam_house_per <dbl>,
#> #   fem_head_per <dbl>, same_sex_coup_per <dbl>, grand_head_per <dbl>,
#> #   less_than_hs <dbl>, hs_grad <dbl>, some_coll <dbl>, bach <dbl>,
#> #   master <dbl>, prof <dbl>, doc <dbl>, commute_less10 <dbl>,
#> #   commute1030 <dbl>, commute3060 <dbl>, commute6090 <dbl>,
#> #   commute_over90 <dbl>, by_auto <dbl>, by_pub_trans <dbl>, by_bike <dbl>,
#> #   by_walk <dbl>, total_house_units <dbl>, vacant_unit_per <dbl>,
#> #   renters_per <dbl>, home_own_per <dbl>, med_gross_rent <dbl>,
#> #   med_home_val <dbl>, med_yr_built_raw <dbl>, med_yr_built <chr>,
#> #   med_yr_moved_inraw <dbl>, med_yr_rent_moved_in <dbl>, area_acres <dbl>,
#> #   town_id <dbl>, town <chr>, fips_stco <dbl>, county <chr>, area_acr_1 <dbl>,
#> #   m_atown <chr>
```


## Revisiting commmuting 

We've just spent a fair amount of time learning how to work with our data. It's now time to return to the problem at hand. We still haven't addressed what data will be of use to our partner at the non-profit. While urban informatics is largely technical, it is still mostly intellectual. We have to think through problems and be methodical with our data selection and curation. We have to think about what our data tells us and why it is important. 

During these exercises, I hope you were looking at the data and thinking about what may be helpful to the non-profit. Again, the goal is to provide them with what is useful, but not more than they need. 


### Exercise

It is now incumbent upon you to curate the data BARI Census Indicator dataset for the non-profit. Refamiliarize yourself with the data. Select a subset of columns that you believe will provide the best insight into commuting behavior in the Greater Boston Area while also providing demographic insight into the the area. 

When making decisions like this, I like to think of a quote from The Master of Disguise:

> "Answer these questions for yourself: who? Why? Where? How?"

Save the resultant tibble to an object named `commute` or something else informative. 

Below is one approach to this question. For this, I have selected all columns pertaining to commute time (columns that start with `commute`), the method by which people commute (begin with `by`), medisan household income, and the name of the census tract. The name of the census tract will be helpful for identifying "where". 


```r
commute <- select(acs_raw,
                  county,
                  hs_grad, bach, master,
                  starts_with("commute"),
                  starts_with("by"),
                  med_house_income)
```



[^indicators]

