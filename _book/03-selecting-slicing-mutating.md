# General data manipulation





Now that you have the ability to read in data, it is important that you get comfortable handling it. Some people call the process of rearranging, cleaning, and reshaping data massaging, plumbing, engineering, and myriad other names. Here, we will refer to this as data manipulation. This is a preferrable catch-all term that does not ilicit images of toilets or Phoebe Buffay (she was a masseuse!). 

You may have heard of the 80/20 rule, or at least one of the many 80/20 rules. The 80/20 rule I'm referring to, is the idea that data scientists will spend 80% or more of their time cleaning and manipulating their data. The other 20% is the analysis part—creating statistics and models. I mention this because working with data is _mostly_ data manipulation and only _some_ statistics. Be prepared to get your hands dirty with data—euphamisms like this is probably why the phrase _data plumbing_ ever came about. 

In this chapter we will learn how to preview data, select columns, arrange rows, and filter rows. This is where we get hands on with our data. This is just about as physical as we will be able to get unless you want to open up the raw csv and edit the data there!

#### CHECK THIS LATER

> Note: I do not recommend editing any csvs directly. That statement was in jest. We will cover the concept of reproducibility.


This is all to say that you will find yourself with messy, unsanitized, gross, not fun to look at data most of the time. Because of this, it is really important that we have the skills to clean our data. Right now we're going to go over the foundational skills we will learn how to select columns and rows, filter data, and create new columns, and arrange our data. To do this, we will be using the [`dplyr`](https://dplyr.tidyverse.org) package from the tidyverse. 

The data we read in in the last chapter was only a select few variables from the annual census data release that the team at the Boston Area Research Initiative (BARI) provides. These census indicators are used to provide a picture into the changing landscape of Boston and Massachussettes more gnerally. In this chapter we will work through a rather real life scenario that you may very well encounter using the BARI data. 

## Scenario:

A local non-profit is interested in the commuting behavior of Greater Boston residents. Your advisor suggested that you assist the non-profit in their work. You've just had coffee with the project manager to learn more about what their specific research question is. It seems that the extension of the Green Line is of great interest to them. They spoke at length about the history of the Big Dig and its impact on commuters working in the city. They look at their watch and realize they're about to miss the commuter train home. You shake their hand, thank them for their time (and the free coffee because you're a grad student), and affirm that you will email them in a week or so with some data for them to work with.

https://www.mass.gov/green-line-extension-project-glx
https://en.wikipedia.org/wiki/Big_Dig


You're back at your apartment, french press next your laptop, though not too close, notes open, and ready to begin. You review your notes and realize, while you now have a rather good understanding of _what_ the Green Line Extensions is and the impact that the Big Dig had, you really have no idea what about commuting behavior in Greater Boston they are interested in. You realize you did not even confirm what constitutes the Greater Boston area. You push down the coffee grinds and pour your first cup of coffee. This will take at least two cups of coffee. 

The above scenario sounds like something out of a stress dream. This is scenario that I have found myself in many times and I am sure that you will find yourself in at one point as well. The more comfortable you get with data analysis and asking good questions, the more guided and directed you can make these seemingly vague objectives. 

> At the end of this chapter, we will expound upon ways to prevent this in the future.

## Getting physical with the data 

The data we used in both chapters one and two were curated from the [annual census indicator release](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/XZXAUP) from BARI. This is the dataset from which `acs_edu` was created. We will use these data to provide relevant data relating to commuting in the Greater Boston Area.

To do so, we will be using the tidyverse to read in and manipulate our data (as we did last chapter). Recall that we will load the tidyverse using `library(tidyverse)`. 

> Refresher: the tidyverse is a collection of packages used for data analysis. When you load the tidyverse it loads `readr`, `ggplot2`, and `dplyr` for us, among other packages. For now, though, these are the only relevant packages. 


**Try it:**

* Load the tidyverse
* Read in the file `ACS_1317_TRACT.csv` located in the `data` directory, store it in an object called `acs_raw`


```r
library(tidyverse)
acs_raw <- read_csv("data/ACS_1317_TRACT.csv")
```

Wonderful! You've got the hang of reading data in which is truly no small feat. Once we have the data accessible from R, it is important to get familiar with what the data are. This means we need to know _which_ variables are available to us and get a feel for what the values in those variables represent. 

Try printing out the `acs_raw` object in your console. 


```r
acs_raw
```


Oof, yikes. It's a bit messy! Not to mention that R did not even print out all of the columns. That's because it ran out of room. When we're working with wide data (many columns), it's generally best to view only a preview of the data. The function `dplyr::glimpse()` can help us do just that. Provide `acs_raw` as the only argument to `glimpse()`.



```r
glimpse(acs_raw)
## Observations: 1,478
## Variables: 59
## $ ct_id_10             <dbl> 25027728100, 25027729200, 25027730700, 2502…
## $ name                 <chr> "Census Tract 7281, Worcester County, Massa…
## $ total_pop            <dbl> 4585, 2165, 6917, 7278, 5059, 6632, 3259, 2…
## $ pop_den              <dbl> 332.5741, 1069.6977, 2112.9526, 1345.5905, …
## $ sex_ratio            <dbl> 1.1315667, 1.3179872, 1.1329016, 1.1156977,…
## $ age_u18              <dbl> 0.2340240, 0.1810624, 0.1705942, 0.2033526,…
## $ age1834              <dbl> 0.2023991, 0.1510393, 0.2143993, 0.2272602,…
## $ age3564              <dbl> 0.3980371, 0.4609700, 0.4371838, 0.4359714,…
## $ age_o65              <dbl> 0.1655398, 0.2069284, 0.1778228, 0.1334158,…
## $ for_born             <dbl> 0.04383860, 0.08729792, 0.20586960, 0.15526…
## $ white                <dbl> 0.8972737, 0.8849885, 0.7328322, 0.8235779,…
## $ black                <dbl> 0.012213740, 0.017090069, 0.079514240, 0.03…
## $ asian                <dbl> 0.006324973, 0.021709007, 0.019950846, 0.03…
## $ hispanic             <dbl> 0.070229008, 0.047575058, 0.136330779, 0.07…
## $ two_or_more          <dbl> 0.012431843, 0.027713626, 0.017348562, 0.01…
## $ eth_het              <dbl> -17032656, -3685242, -26905553, -36365806, …
## $ med_house_income     <dbl> 105735, 69625, 70679, 74528, 52885, 64100, …
## $ pub_assist           <dbl> 0.020782396, 0.004667445, 0.021067926, 0.03…
## $ gini                 <dbl> 0.4084, 0.3886, 0.4693, 0.4052, 0.5327, 0.4…
## $ fam_pov_per          <dbl> 0.04754601, 0.06521739, 0.05843440, 0.02486…
## $ unemp_rate           <dbl> 0.03361345, 0.03127572, 0.06124498, 0.03983…
## $ total_house_h        <dbl> 1636, 857, 2753, 2878, 2326, 2635, 1245, 80…
## $ fam_house_per        <dbl> 0.7970660, 0.6977830, 0.6589175, 0.6567060,…
## $ fem_head_per         <dbl> 0.08985330, 0.12018670, 0.11442063, 0.12126…
## $ same_sex_coup_per    <dbl> 0.00000000, 0.00000000, 0.00000000, 0.00000…
## $ grand_head_per       <dbl> 0.000000000, 0.005834306, 0.000000000, 0.00…
## $ less_than_hs         <dbl> 0.02515518, 0.05773956, 0.09364548, 0.08426…
## $ hs_grad              <dbl> 0.19568768, 0.25307125, 0.17332284, 0.25298…
## $ some_coll            <dbl> 0.2211696, 0.3157248, 0.2726736, 0.3534052,…
## $ bach                 <dbl> 0.32473048, 0.26167076, 0.26677159, 0.23124…
## $ master               <dbl> 0.15942502, 0.09705160, 0.12059807, 0.06714…
## $ prof                 <dbl> 0.0405096374, 0.0098280098, 0.0397403108, 0…
## $ doc                  <dbl> 0.033322444, 0.004914005, 0.033248082, 0.00…
## $ commute_less10       <dbl> 0.07874016, 0.25109361, 0.05369894, 0.14119…
## $ commute1030          <dbl> 0.5131234, 0.4636920, 0.6620965, 0.3941685,…
## $ commute3060          <dbl> 0.33114611, 0.18110236, 0.17709226, 0.31263…
## $ commute6090          <dbl> 0.055555556, 0.082239720, 0.086832334, 0.13…
## $ commute_over90       <dbl> 0.021434821, 0.021872266, 0.020279920, 0.01…
## $ by_auto              <dbl> 0.9267791, 0.9704861, 0.9248285, 0.9037018,…
## $ by_pub_trans         <dbl> 0.000000000, 0.004340278, 0.020301783, 0.01…
## $ by_bike              <dbl> 0.002879473, 0.000000000, 0.000000000, 0.00…
## $ by_walk              <dbl> 0.002468120, 0.012152778, 0.004938272, 0.02…
## $ total_house_units    <dbl> 1701, 886, 2928, 3181, 2511, 2713, 1581, 85…
## $ vacant_unit_per      <dbl> 0.03821282, 0.03273138, 0.05976776, 0.09525…
## $ renters_per          <dbl> 0.1088020, 0.2100350, 0.2804214, 0.3425990,…
## $ home_own_per         <dbl> 0.8911980, 0.7899650, 0.7195786, 0.6574010,…
## $ med_gross_rent       <dbl> 1640, 894, 1454, 954, 1018, 867, 910, 1088,…
## $ med_home_val         <dbl> 349000, 230200, 207200, 268400, 223200, 232…
## $ med_yr_built_raw     <dbl> 1988, 1955, 1959, 1973, 1964, 1966, 1939, 1…
## $ med_yr_built         <chr> "1980 to 1989", "1950 to 1959", "1950 to 19…
## $ med_yr_moved_inraw   <dbl> 2004, 2003, 2007, 2006, 2006, 2000, 2011, 2…
## $ med_yr_rent_moved_in <dbl> 2012, 2010, 2012, 2011, 2011, 2009, 2012, 2…
## $ area_acres           <dbl> 9407.9167, 1294.2828, 2123.4927, 3581.9026,…
## $ town_id              <dbl> 134, 321, 348, 185, 153, 151, 316, 348, 28,…
## $ town                 <chr> "HOLDEN", "WEST BOYLSTON", "WORCESTER", "MI…
## $ fips_stco            <dbl> 25027, 25027, 25027, 25027, 25027, 25027, 2…
## $ county               <chr> "WORCESTER", "WORCESTER", "WORCESTER", "WOR…
## $ area_acr_1           <dbl> 23241.514, 8867.508, 24609.965, 9615.644, 1…
## $ m_atown              <chr> "HOLDEN", "WEST BOYLSTON", "WORCESTER", "MI…
```

Much better, right? It is frankly still a lot of text, but the way it is presented is rather useful. Each variable is written followed by its data type, i.e. `<dbl>`, and then a preview of values in that column. If the `<dbl>` does not make sense yet, do not worry. We will go over data types in depth later. Data types are not the most fun and I think it is important we have fun! 

`acs_raw` is the dataset from which `acs_edu` was created. As you can see, there are many, many, _many_ different variables that the ACS data provide us with. These are only the tip of the iceberg. 

**Pause**

Now have a think. 

Looking at the preview of these data, which columns do you think will be most useful to the non-profit for understanding commuter behavior?

> Note: "all of them" is not always the best answer. By providing too much data one may moved to inaction because they now determine what variables are the most useful and how to use them. HAVE SOURCES ON PARADOX OF CHOICE AND INFORMATION OVERLOAD.

If you spotted the columns commute_less10, commute1030, commute3060, commute6090, and commute_over90, your eyes and intuition have served you well! These variables tell us about what proportion of the sampled population in a given census tract have commute times that fall within the indicated duration range, i.e. 30-60.

> PERSONAL NOTE: USE COMMUTE VARIABLES FOR PIVOTING AND THEN SEPARATING INTO NEW VARS

### `select()`ing

So now we have an intuition of the most important variables, but the next problem soon arises: how do we isolate just these variables? Whenever you find yourself needing to select or deselect columns from a tibble `dplyr::select()` will be the main function that you will go to. 

**What does it do?**: `select()` selects variables from a tibble and always returns another tibble. 

Before we work through how to use `select()`, refer to the help documentation and see if you can get somewhat of an intuition by typing `?select()` into the console. Once you press enter the documentation page should pop up in RStudio. 

There are a few reasons why I am directing you towards the function documentation.

1. To get you comfortable with navigating the RStudio IDE
2. Expose you to the R vocabulary
3. Soon you'll be too advanced for this book and will have to figure out the way functions work on your own! 

Perhaps the help documentation was a little overwhelming and absolutely confusing. That's okay. It's just an exposure! With each exposure things will make more sense. Let's tackle these arguments one by one. 

> `.data`: A tbl. All main verbs are S3 generics and provide methods for tbl_df(), dtplyr::tbl_dt() and dbplyr::tbl_dbi().

What I want you to take away from this argument definition is `a tbl`. Whenever you read `tbl` think to your self "oh, that is just a `tibble`." If you recall, when we read rectangular data with `readr::read_csv()` or any other `readr::read_*()` function we will end up with a tibble. To verify that this is the case, we can double check our objects using the function `is.tbl()`. This function takes an object and returns a logical value (`TRUE` or `FALSE`) if the statement is true. Let's double check that `acs_raw` is in fact a tbl.


```r
is.tbl(acs_raw)
## [1] TRUE
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
## # A tibble: 1,478 x 1
##    name                                                 
##    <chr>                                                
##  1 Census Tract 7281, Worcester County, Massachusetts   
##  2 Census Tract 7292, Worcester County, Massachusetts   
##  3 Census Tract 7307, Worcester County, Massachusetts   
##  4 Census Tract 7442, Worcester County, Massachusetts   
##  5 Census Tract 7097.01, Worcester County, Massachusetts
##  6 Census Tract 7351, Worcester County, Massachusetts   
##  7 Census Tract 7543, Worcester County, Massachusetts   
##  8 Census Tract 7308.02, Worcester County, Massachusetts
##  9 Census Tract 7171, Worcester County, Massachusetts   
## 10 Census Tract 7326, Worcester County, Massachusetts   
## # … with 1,468 more rows
```

The column `name` was passed to `...`. Recall that dots allows us to pass "one ore more unquoted expressions separated by commas." To test this statement out, select `town` in addition to `name` from `acs_raw`

Try it:

- select `name` and `town` from `acs_raw`


```r
select(acs_raw, name, town)
## # A tibble: 1,478 x 2
##    name                                                  town         
##    <chr>                                                 <chr>        
##  1 Census Tract 7281, Worcester County, Massachusetts    HOLDEN       
##  2 Census Tract 7292, Worcester County, Massachusetts    WEST BOYLSTON
##  3 Census Tract 7307, Worcester County, Massachusetts    WORCESTER    
##  4 Census Tract 7442, Worcester County, Massachusetts    MILFORD      
##  5 Census Tract 7097.01, Worcester County, Massachusetts LEOMINSTER   
##  6 Census Tract 7351, Worcester County, Massachusetts    LEICESTER    
##  7 Census Tract 7543, Worcester County, Massachusetts    WEBSTER      
##  8 Census Tract 7308.02, Worcester County, Massachusetts WORCESTER    
##  9 Census Tract 7171, Worcester County, Massachusetts    BERLIN       
## 10 Census Tract 7326, Worcester County, Massachusetts    WORCESTER    
## # … with 1,468 more rows
```

Great, you're getting the hang of it. 

Now, in addition to to selecting columns solely based on their names, we can also select a range of columns using the format `col_from:col_to`. In writing this `select()` will register that you want every column from and including `col_from` up until and including `col_to`. 

Let's refresh ourselves with what our data look like:


```r
glimpse(acs_raw)
## Observations: 1,478
## Variables: 59
## $ ct_id_10             <dbl> 25027728100, 25027729200, 25027730700, 2502…
## $ name                 <chr> "Census Tract 7281, Worcester County, Massa…
## $ total_pop            <dbl> 4585, 2165, 6917, 7278, 5059, 6632, 3259, 2…
## $ pop_den              <dbl> 332.5741, 1069.6977, 2112.9526, 1345.5905, …
## $ sex_ratio            <dbl> 1.1315667, 1.3179872, 1.1329016, 1.1156977,…
## $ age_u18              <dbl> 0.2340240, 0.1810624, 0.1705942, 0.2033526,…
## $ age1834              <dbl> 0.2023991, 0.1510393, 0.2143993, 0.2272602,…
## $ age3564              <dbl> 0.3980371, 0.4609700, 0.4371838, 0.4359714,…
## $ age_o65              <dbl> 0.1655398, 0.2069284, 0.1778228, 0.1334158,…
## $ for_born             <dbl> 0.04383860, 0.08729792, 0.20586960, 0.15526…
## $ white                <dbl> 0.8972737, 0.8849885, 0.7328322, 0.8235779,…
## $ black                <dbl> 0.012213740, 0.017090069, 0.079514240, 0.03…
## $ asian                <dbl> 0.006324973, 0.021709007, 0.019950846, 0.03…
## $ hispanic             <dbl> 0.070229008, 0.047575058, 0.136330779, 0.07…
## $ two_or_more          <dbl> 0.012431843, 0.027713626, 0.017348562, 0.01…
## $ eth_het              <dbl> -17032656, -3685242, -26905553, -36365806, …
## $ med_house_income     <dbl> 105735, 69625, 70679, 74528, 52885, 64100, …
## $ pub_assist           <dbl> 0.020782396, 0.004667445, 0.021067926, 0.03…
## $ gini                 <dbl> 0.4084, 0.3886, 0.4693, 0.4052, 0.5327, 0.4…
## $ fam_pov_per          <dbl> 0.04754601, 0.06521739, 0.05843440, 0.02486…
## $ unemp_rate           <dbl> 0.03361345, 0.03127572, 0.06124498, 0.03983…
## $ total_house_h        <dbl> 1636, 857, 2753, 2878, 2326, 2635, 1245, 80…
## $ fam_house_per        <dbl> 0.7970660, 0.6977830, 0.6589175, 0.6567060,…
## $ fem_head_per         <dbl> 0.08985330, 0.12018670, 0.11442063, 0.12126…
## $ same_sex_coup_per    <dbl> 0.00000000, 0.00000000, 0.00000000, 0.00000…
## $ grand_head_per       <dbl> 0.000000000, 0.005834306, 0.000000000, 0.00…
## $ less_than_hs         <dbl> 0.02515518, 0.05773956, 0.09364548, 0.08426…
## $ hs_grad              <dbl> 0.19568768, 0.25307125, 0.17332284, 0.25298…
## $ some_coll            <dbl> 0.2211696, 0.3157248, 0.2726736, 0.3534052,…
## $ bach                 <dbl> 0.32473048, 0.26167076, 0.26677159, 0.23124…
## $ master               <dbl> 0.15942502, 0.09705160, 0.12059807, 0.06714…
## $ prof                 <dbl> 0.0405096374, 0.0098280098, 0.0397403108, 0…
## $ doc                  <dbl> 0.033322444, 0.004914005, 0.033248082, 0.00…
## $ commute_less10       <dbl> 0.07874016, 0.25109361, 0.05369894, 0.14119…
## $ commute1030          <dbl> 0.5131234, 0.4636920, 0.6620965, 0.3941685,…
## $ commute3060          <dbl> 0.33114611, 0.18110236, 0.17709226, 0.31263…
## $ commute6090          <dbl> 0.055555556, 0.082239720, 0.086832334, 0.13…
## $ commute_over90       <dbl> 0.021434821, 0.021872266, 0.020279920, 0.01…
## $ by_auto              <dbl> 0.9267791, 0.9704861, 0.9248285, 0.9037018,…
## $ by_pub_trans         <dbl> 0.000000000, 0.004340278, 0.020301783, 0.01…
## $ by_bike              <dbl> 0.002879473, 0.000000000, 0.000000000, 0.00…
## $ by_walk              <dbl> 0.002468120, 0.012152778, 0.004938272, 0.02…
## $ total_house_units    <dbl> 1701, 886, 2928, 3181, 2511, 2713, 1581, 85…
## $ vacant_unit_per      <dbl> 0.03821282, 0.03273138, 0.05976776, 0.09525…
## $ renters_per          <dbl> 0.1088020, 0.2100350, 0.2804214, 0.3425990,…
## $ home_own_per         <dbl> 0.8911980, 0.7899650, 0.7195786, 0.6574010,…
## $ med_gross_rent       <dbl> 1640, 894, 1454, 954, 1018, 867, 910, 1088,…
## $ med_home_val         <dbl> 349000, 230200, 207200, 268400, 223200, 232…
## $ med_yr_built_raw     <dbl> 1988, 1955, 1959, 1973, 1964, 1966, 1939, 1…
## $ med_yr_built         <chr> "1980 to 1989", "1950 to 1959", "1950 to 19…
## $ med_yr_moved_inraw   <dbl> 2004, 2003, 2007, 2006, 2006, 2000, 2011, 2…
## $ med_yr_rent_moved_in <dbl> 2012, 2010, 2012, 2011, 2011, 2009, 2012, 2…
## $ area_acres           <dbl> 9407.9167, 1294.2828, 2123.4927, 3581.9026,…
## $ town_id              <dbl> 134, 321, 348, 185, 153, 151, 316, 348, 28,…
## $ town                 <chr> "HOLDEN", "WEST BOYLSTON", "WORCESTER", "MI…
## $ fips_stco            <dbl> 25027, 25027, 25027, 25027, 25027, 25027, 2…
## $ county               <chr> "WORCESTER", "WORCESTER", "WORCESTER", "WOR…
## $ area_acr_1           <dbl> 23241.514, 8867.508, 24609.965, 9615.644, 1…
## $ m_atown              <chr> "HOLDEN", "WEST BOYLSTON", "WORCESTER", "MI…
```


Try it:

- select the columns `age_u18` through `age_o65`.


```r
select(acs_raw, age_u18:age_o65)
## # A tibble: 1,478 x 4
##    age_u18 age1834 age3564 age_o65
##      <dbl>   <dbl>   <dbl>   <dbl>
##  1   0.234   0.202   0.398   0.166
##  2   0.181   0.151   0.461   0.207
##  3   0.171   0.214   0.437   0.178
##  4   0.203   0.227   0.436   0.133
##  5   0.177   0.203   0.430   0.190
##  6   0.163   0.237   0.439   0.162
##  7   0.191   0.326   0.380   0.102
##  8   0.202   0.183   0.466   0.148
##  9   0.188   0.150   0.462   0.200
## 10   0.244   0.286   0.342   0.128
## # … with 1,468 more rows
```

Now to really throw you off! You can even reverse the order of these ranges. 

Try it:

- select columns from `age_o65` to `age_u18`.


```r
select(acs_raw, age_o65:age_u18)
## # A tibble: 1,478 x 4
##    age_o65 age3564 age1834 age_u18
##      <dbl>   <dbl>   <dbl>   <dbl>
##  1   0.166   0.398   0.202   0.234
##  2   0.207   0.461   0.151   0.181
##  3   0.178   0.437   0.214   0.171
##  4   0.133   0.436   0.227   0.203
##  5   0.190   0.430   0.203   0.177
##  6   0.162   0.439   0.237   0.163
##  7   0.102   0.380   0.326   0.191
##  8   0.148   0.466   0.183   0.202
##  9   0.200   0.462   0.150   0.188
## 10   0.128   0.342   0.286   0.244
## # … with 1,468 more rows
```

> NOTE: This is an awful scenario. SOMEONE HALP

Alright, so now we have gotten the hang of selecting columns based on their names. But equally important is the ability to select columns based on their position. Consider the situation in which you regularly receive georeferenced data from a research partner and the structure of the dataset is rather consistent _except_ that they frequently change the name of the coordinate columns. Sometimes the columns are `x` and `y`. Sometimes they are capitalized `X` and `Y`, `lon` and `lat`, or even `long` and `lat`. It eats you up inside! But you know that while the names may change, their positiions never do. You decide to program a solution rather than having a conversation with your research partner—though, I recommend you both level set on reproducibility standards.

 > "...You can treat variable names like they are positions..."
 
 The above was taken from the argument definition of dots `...`. Like providing the name of the column, we can also provide their positions (also referred to as an index). In our previous example, we selected the `name` column. We can select this column by it's position. `name` is the second column in our tibble. We select it like so:


```r
select(acs_raw, 2)
## # A tibble: 1,478 x 1
##    name                                                 
##    <chr>                                                
##  1 Census Tract 7281, Worcester County, Massachusetts   
##  2 Census Tract 7292, Worcester County, Massachusetts   
##  3 Census Tract 7307, Worcester County, Massachusetts   
##  4 Census Tract 7442, Worcester County, Massachusetts   
##  5 Census Tract 7097.01, Worcester County, Massachusetts
##  6 Census Tract 7351, Worcester County, Massachusetts   
##  7 Census Tract 7543, Worcester County, Massachusetts   
##  8 Census Tract 7308.02, Worcester County, Massachusetts
##  9 Census Tract 7171, Worcester County, Massachusetts   
## 10 Census Tract 7326, Worcester County, Massachusetts   
## # … with 1,468 more rows
```

Try it:

- select `age_u18` and `age_o65` by their position


```r
select(acs_raw, 6, 9)
## # A tibble: 1,478 x 2
##    age_u18 age_o65
##      <dbl>   <dbl>
##  1   0.234   0.166
##  2   0.181   0.207
##  3   0.171   0.178
##  4   0.203   0.133
##  5   0.177   0.190
##  6   0.163   0.162
##  7   0.191   0.102
##  8   0.202   0.148
##  9   0.188   0.200
## 10   0.244   0.128
## # … with 1,468 more rows
```

You may see where I am going with this. Just like column names, we can select a range of columns using the same method `index_from:index_to`.

Try it:

- select the columns from `age_u18` to `age_o65` using `:` and the column position
- select the columns in reverse order by their indexes 


```r
select(acs_raw, 6:9)
## # A tibble: 1,478 x 4
##    age_u18 age1834 age3564 age_o65
##      <dbl>   <dbl>   <dbl>   <dbl>
##  1   0.234   0.202   0.398   0.166
##  2   0.181   0.151   0.461   0.207
##  3   0.171   0.214   0.437   0.178
##  4   0.203   0.227   0.436   0.133
##  5   0.177   0.203   0.430   0.190
##  6   0.163   0.237   0.439   0.162
##  7   0.191   0.326   0.380   0.102
##  8   0.202   0.183   0.466   0.148
##  9   0.188   0.150   0.462   0.200
## 10   0.244   0.286   0.342   0.128
## # … with 1,468 more rows
```


```r
select(acs_raw, 9:6)
## # A tibble: 1,478 x 4
##    age_o65 age3564 age1834 age_u18
##      <dbl>   <dbl>   <dbl>   <dbl>
##  1   0.166   0.398   0.202   0.234
##  2   0.207   0.461   0.151   0.181
##  3   0.178   0.437   0.214   0.171
##  4   0.133   0.436   0.227   0.203
##  5   0.190   0.430   0.203   0.177
##  6   0.162   0.439   0.237   0.163
##  7   0.102   0.380   0.326   0.191
##  8   0.148   0.466   0.183   0.202
##  9   0.200   0.462   0.150   0.188
## 10   0.128   0.342   0.286   0.244
## # … with 1,468 more rows
```

> Base R Side Bar: To help build your intuition, I want to point out some base R functionality. Using the colon `:` with integers (whole numbers) is actually not a `select()` specific functionality. This is something that is rather handy and built directly into R. Using the colon operator, we can create ranges of numbers in the same exact way as we did above. If we want create the range of numbers from 1 to 10, we write `1:10`.


-------

to do so we use the function `select()`. Look at the help documentation by running `?select()` inside of the console. What are the arguments?
- `.data` and `...`. We'll tackle this one by one.
  - `.data`: "A tbl." 
    - read this as "A tibble, or data frame". 
    - for those of you who are curious, `tbl` is the formal object class of a tibble. a tibble is still a data frame
    - this means that the first argument will be passed the `acs_raw` object
- `...`: 

> One or more unquoted expressions separated by commas. You can treat variable names like they are positions, so you can use expressions like x:y to select ranges of variables.

- this one is a little bit more complex. `...` referred to as "dots". This really means we can pass any number of other arguments to `select()` here the `...` will be ways of referring to the columns we want. and there are a number of ways we can referrer to which columns we want we can:
  1. write the name (unquoted) of the columns—i.e. i want the column `col_x` would be `select(.data, col_x)`
  2. write the position of the column—i.e. i want the first column would be `select(.data, 1)`
  3. There are also a number of _select helpers_ of which we will go over a few
    - everything()
    - deselecting
- one behavior that you should notice is that select will _always_ return a tibble, even if we don't sepcify any columns to select


### `select()` exercises

- try using the select function on `acs_raw` without passing any column specifications to `...`


```r
select(acs_raw)
```

- select the median house hold income column (`med_house_income`)


```r
select(acs_raw, med_house_income)
## # A tibble: 1,478 x 1
##    med_house_income
##               <dbl>
##  1           105735
##  2            69625
##  3            70679
##  4            74528
##  5            52885
##  6            64100
##  7            37093
##  8            87750
##  9            97417
## 10            43384
## # … with 1,468 more rows
```


- as the documentation notes we can select a range of columns using `col_x:col_y`
- select the columns relating to education from less than high school to doctoral


```r
select(acs_raw, less_than_hs:doc)
## # A tibble: 1,478 x 7
##    less_than_hs hs_grad some_coll  bach master     prof     doc
##           <dbl>   <dbl>     <dbl> <dbl>  <dbl>    <dbl>   <dbl>
##  1       0.0252   0.196     0.221 0.325 0.159  0.0405   0.0333 
##  2       0.0577   0.253     0.316 0.262 0.0971 0.00983  0.00491
##  3       0.0936   0.173     0.273 0.267 0.121  0.0397   0.0332 
##  4       0.0843   0.253     0.353 0.231 0.0671 0.00616  0.00481
##  5       0.145    0.310     0.283 0.168 0.0879 0.00343  0.00158
##  6       0.0946   0.294     0.317 0.192 0.0858 0.0161   0      
##  7       0.253    0.394     0.235 0.101 0.0155 0.000484 0      
##  8       0.0768   0.187     0.185 0.272 0.145  0.0569   0.0782 
##  9       0.0625   0.254     0.227 0.284 0.127  0.0223   0.0236 
## 10       0.207    0.362     0.262 0.124 0.0353 0        0.00972
## # … with 1,468 more rows
```

- though you will likely not use it too often, it's still important to be comfortable with column index (position) selecting
- select the 1st, 5th, and 10th columns


```r
select(acs_raw, 1, 5, 10)
## # A tibble: 1,478 x 3
##       ct_id_10 sex_ratio for_born
##          <dbl>     <dbl>    <dbl>
##  1 25027728100     1.13    0.0438
##  2 25027729200     1.32    0.0873
##  3 25027730700     1.13    0.206 
##  4 25027744200     1.12    0.155 
##  5 25027709701     1.30    0.106 
##  6 25027735100     1.11    0.0280
##  7 25027754300     1.25    0.188 
##  8 25027730802     0.908   0.198 
##  9 25027717100     0.990   0.0797
## 10 25027732600     1.19    0.210 
## # … with 1,468 more rows
```

#### tidyselect helpers

- we use the tidyselect helpers in the `...` argument
- `starts_with()`: a string to search that columns start with
  - find all columns that start with `"med"`


```r
select(acs_raw, starts_with("med"))
## # A tibble: 1,478 x 7
##    med_house_income med_gross_rent med_home_val med_yr_built_raw
##               <dbl>          <dbl>        <dbl>            <dbl>
##  1           105735           1640       349000             1988
##  2            69625            894       230200             1955
##  3            70679           1454       207200             1959
##  4            74528            954       268400             1973
##  5            52885           1018       223200             1964
##  6            64100            867       232700             1966
##  7            37093            910       170900             1939
##  8            87750           1088       270100             1939
##  9            97417           1037       379600             1981
## 10            43384           1017       156500             1939
## # … with 1,468 more rows, and 3 more variables: med_yr_built <chr>,
## #   med_yr_moved_inraw <dbl>, med_yr_rent_moved_in <dbl>
```

- `ends_with()`: a string to search that columns end with
  - select columns that end with `"per"`


```r
select(acs_raw, ends_with("per"))
## # A tibble: 1,478 x 8
##    fam_pov_per fam_house_per fem_head_per same_sex_coup_p… grand_head_per
##          <dbl>         <dbl>        <dbl>            <dbl>          <dbl>
##  1      0.0475         0.797       0.0899            0            0      
##  2      0.0652         0.698       0.120             0            0.00583
##  3      0.0584         0.659       0.114             0            0      
##  4      0.0249         0.657       0.121             0            0      
##  5      0.198          0.531       0.158             0            0.00946
##  6      0.0428         0.665       0.0603            0            0.0353 
##  7      0.0762         0.632       0.227             0            0.00643
##  8      0.101          0.636       0.0582            0.297        0.0260 
##  9      0.0149         0.758       0.0721            0            0.00434
## 10      0.0954         0.460       0.225             0            0.0279 
## # … with 1,468 more rows, and 3 more variables: vacant_unit_per <dbl>,
## #   renters_per <dbl>, home_own_per <dbl>
```

- `contains()`: a string to search for in the column headers
  - the string that we are searching for can be at any position
  - find any column that contains the string `"yr"`


```r
select(acs_raw, contains("yr"))
## # A tibble: 1,478 x 4
##    med_yr_built_raw med_yr_built  med_yr_moved_inraw med_yr_rent_moved_in
##               <dbl> <chr>                      <dbl>                <dbl>
##  1             1988 1980 to 1989                2004                 2012
##  2             1955 1950 to 1959                2003                 2010
##  3             1959 1950 to 1959                2007                 2012
##  4             1973 1970 to 1979                2006                 2011
##  5             1964 1960 to 1969                2006                 2011
##  6             1966 1960 to 1969                2000                 2009
##  7             1939 Prior to 1940               2011                 2012
##  8             1939 Prior to 1940               2006                 2012
##  9             1981 1980 to 1989                2004                 2012
## 10             1939 Prior to 1940               2011                   NA
## # … with 1,468 more rows
```

- `everything()`: helpful when you want to move some columns to the front and dont care about the order of others
  - takes no arguments
  - select the town, county, then everything else


```r
select(acs_raw, town, county, everything())
## # A tibble: 1,478 x 59
##    town  county ct_id_10 name  total_pop pop_den sex_ratio age_u18 age1834
##    <chr> <chr>     <dbl> <chr>     <dbl>   <dbl>     <dbl>   <dbl>   <dbl>
##  1 HOLD… WORCE…  2.50e10 Cens…      4585    333.     1.13    0.234   0.202
##  2 WEST… WORCE…  2.50e10 Cens…      2165   1070.     1.32    0.181   0.151
##  3 WORC… WORCE…  2.50e10 Cens…      6917   2113.     1.13    0.171   0.214
##  4 MILF… WORCE…  2.50e10 Cens…      7278   1346.     1.12    0.203   0.227
##  5 LEOM… WORCE…  2.50e10 Cens…      5059   2894.     1.30    0.177   0.203
##  6 LEIC… WORCE…  2.50e10 Cens…      6632    472.     1.11    0.163   0.237
##  7 WEBS… WORCE…  2.50e10 Cens…      3259   8022.     1.25    0.191   0.326
##  8 WORC… WORCE…  2.50e10 Cens…      2097   5191.     0.908   0.202   0.183
##  9 BERL… WORCE…  2.50e10 Cens…      3098    239.     0.990   0.188   0.150
## 10 WORC… WORCE…  2.50e10 Cens…      3982  17065.     1.19    0.244   0.286
## # … with 1,468 more rows, and 50 more variables: age3564 <dbl>,
## #   age_o65 <dbl>, for_born <dbl>, white <dbl>, black <dbl>, asian <dbl>,
## #   hispanic <dbl>, two_or_more <dbl>, eth_het <dbl>,
## #   med_house_income <dbl>, pub_assist <dbl>, gini <dbl>,
## #   fam_pov_per <dbl>, unemp_rate <dbl>, total_house_h <dbl>,
## #   fam_house_per <dbl>, fem_head_per <dbl>, same_sex_coup_per <dbl>,
## #   grand_head_per <dbl>, less_than_hs <dbl>, hs_grad <dbl>,
## #   some_coll <dbl>, bach <dbl>, master <dbl>, prof <dbl>, doc <dbl>,
## #   commute_less10 <dbl>, commute1030 <dbl>, commute3060 <dbl>,
## #   commute6090 <dbl>, commute_over90 <dbl>, by_auto <dbl>,
## #   by_pub_trans <dbl>, by_bike <dbl>, by_walk <dbl>,
## #   total_house_units <dbl>, vacant_unit_per <dbl>, renters_per <dbl>,
## #   home_own_per <dbl>, med_gross_rent <dbl>, med_home_val <dbl>,
## #   med_yr_built_raw <dbl>, med_yr_built <chr>, med_yr_moved_inraw <dbl>,
## #   med_yr_rent_moved_in <dbl>, area_acres <dbl>, town_id <dbl>,
## #   fips_stco <dbl>, area_acr_1 <dbl>, m_atown <chr>
```

## Selecting Rows

like we can select columns we can also select rows. however rows do not have names. we select the rows based on position
unlike select, if we do not specify any arguments to `...` it will return the entire data frame


```r
slice(acs_raw)
## # A tibble: 1,478 x 59
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
## # … with 1,468 more rows, and 51 more variables: age_o65 <dbl>,
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
## #   m_atown <chr>
```

positive integers


```r
slice(acs_raw)
## # A tibble: 1,478 x 59
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
## # … with 1,468 more rows, and 51 more variables: age_o65 <dbl>,
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
## #   m_atown <chr>
```

the `n()` helper

negative integers

## filter


- logical operators

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
  
  

## asking good questions 

## writing data lol





------ 

##### old notes


They define the greater boston area as Suffolk, Middlesex, and Norfolk counties. 

before we go ahead and start cleaning this data, we need to learn the tools to do so. Please bear with me! 
  
  
  - recall how to load the tidyverse
- we'll read in the `ACS_1317_TRACT.csv` file located in the `data` directory
  - putting this together the file path is `data/ACS_1317_TRACT.csv`.
  - store it in the variable `acs_raw`


To learn these tools we will work with a role-play / workthrough. 
a local non-profit is interested in learning about the demographic characteristics of the greater boston area. They are specifically interested to learn more about the relationship between the age, race, and economic status. They've come to you to provide them with the relevant data. you have acces to the annual BARI census data and you will curate the data for them. 
