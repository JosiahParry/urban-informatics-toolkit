# Creating Ecometrics




> Note: a case study should be recreating these ecometrics

Explore what the data description from BARI looks like


```r
library(tidyverse)
## ── Attaching packages ───────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
## ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
## ✓ tibble  3.0.0     ✓ dplyr   0.8.5
## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
## ── Conflicts ──────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
ecometrics <- readr::read_csv("data/911/911-ecometrics-2014-19.csv") %>% 
  janitor::clean_names()
## Parsed with column specification:
## cols(
##   TYPE = col_character(),
##   tycod = col_character(),
##   typ_eng = col_character(),
##   sub_tycod = col_character(),
##   sub_eng = col_character(),
##   SocDis = col_double(),
##   PrivateConflict = col_double(),
##   Violence = col_double(),
##   Guns = col_double(),
##   Frequency_2015 = col_double(),
##   Frequency_2016 = col_double(),
##   Frequency_2017 = col_double(),
##   Frequency_2018 = col_double(),
##   yr.intro = col_double(),
##   last.yr = col_double()
## )

glimpse(ecometrics)
## Rows: 302
## Columns: 15
## $ type             <chr> "AB===>>>", "ABAN===>>>", "ABANBU", "ABANCELL", "ABA…
## $ tycod            <chr> "AB", "ABAN", "ABAN", "ABAN", "ABAN", "ABAN", "ABAN"…
## $ typ_eng          <chr> "ASSAULT AND BATTERY", "ABANDONED CALL", "ABANDONED …
## $ sub_tycod        <chr> "===>>>", "===>>>", "BU", "CELL", "INCCAL", "PH", "R…
## $ sub_eng          <chr> "PICK A SUB-TYPE", "PICK A SUB-TYPE", "FROM A BUSINE…
## $ soc_dis          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
## $ private_conflict <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
## $ violence         <dbl> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0…
## $ guns             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0…
## $ frequency_2015   <dbl> 27, 40, 12768, 72081, 686, 1734, 3143, 194, 122, 88,…
## $ frequency_2016   <dbl> 29, 26, 13287, 56074, 1188, 1205, 2687, 397, 190, 94…
## $ frequency_2017   <dbl> 29, 17, 12599, 39323, 124, 724, 1944, 253, 162, 74, …
## $ frequency_2018   <dbl> 14, 10, 6422, 19947, 70, 506, 840, 262, 169, 78, 361…
## $ yr_intro         <dbl> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014…
## $ last_yr          <dbl> 2019, 2018, 2019, 2019, 2019, 2019, 2019, 2019, 2019…
```

Check out the offense descriptions


```r
# raw_911 <- read_csv("data/911/911-raw.csv") %>% 
#   janitor::clean_names()
```


```r
# raw_911 %>% 
#   count(offense_code_group)
```

- There are fewer types of code groups. 
- They are rather informative.
- 33k missing observations though
- is the same amount of missingness present in the descriptions?


```r
# raw_911 %>% 
#   count(offense_description)
```

- no missingness
- more types
- what do we do?
  - choose one of these?
  - we can actually use both
  - filter data set to exclude NAs from `offense_code_group`.
  - `anti_join()` that dataset from raw
  - now use the raw_911 remainders and hand code that.
- reminder: we cannot automate everything. It requires long hours, dedication, and freakin' grit.
