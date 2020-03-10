# Creating Ecometrics




> Note: a case study should be recreating these ecometrics

Explore what the data description from BARI looks like


```r
library(tidyverse)
## ── Attaching packages ───────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
## ✓ tibble  2.1.3     ✓ purrr   0.3.3
## ✓ tidyr   1.0.2     ✓ dplyr   0.8.3
## ✓ readr   1.3.1     ✓ stringr 1.4.0
## ✓ tibble  2.1.3     ✓ forcats 0.4.0
## ── Conflicts ──────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
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
## Observations: 302
## Variables: 15
## $ type             <chr> "AB===>>>", "ABAN===>>>", "ABANBU", "ABANCELL",…
## $ tycod            <chr> "AB", "ABAN", "ABAN", "ABAN", "ABAN", "ABAN", "…
## $ typ_eng          <chr> "ASSAULT AND BATTERY", "ABANDONED CALL", "ABAND…
## $ sub_tycod        <chr> "===>>>", "===>>>", "BU", "CELL", "INCCAL", "PH…
## $ sub_eng          <chr> "PICK A SUB-TYPE", "PICK A SUB-TYPE", "FROM A B…
## $ soc_dis          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
## $ private_conflict <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
## $ violence         <dbl> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,…
## $ guns             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,…
## $ frequency_2015   <dbl> 27, 40, 12768, 72081, 686, 1734, 3143, 194, 122…
## $ frequency_2016   <dbl> 29, 26, 13287, 56074, 1188, 1205, 2687, 397, 19…
## $ frequency_2017   <dbl> 29, 17, 12599, 39323, 124, 724, 1944, 253, 162,…
## $ frequency_2018   <dbl> 14, 10, 6422, 19947, 70, 506, 840, 262, 169, 78…
## $ yr_intro         <dbl> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014,…
## $ last_yr          <dbl> 2019, 2018, 2019, 2019, 2019, 2019, 2019, 2019,…
```

Check out the offense descriptions


```r
raw_911 <- read_csv("data/911/911-raw.csv") %>% 
  janitor::clean_names()
## Parsed with column specification:
## cols(
##   INCIDENT_NUMBER = col_character(),
##   OFFENSE_CODE = col_character(),
##   OFFENSE_CODE_GROUP = col_character(),
##   OFFENSE_DESCRIPTION = col_character(),
##   DISTRICT = col_character(),
##   REPORTING_AREA = col_double(),
##   SHOOTING = col_character(),
##   OCCURRED_ON_DATE = col_datetime(format = ""),
##   YEAR = col_double(),
##   MONTH = col_double(),
##   DAY_OF_WEEK = col_character(),
##   HOUR = col_double(),
##   UCR_PART = col_character(),
##   STREET = col_character(),
##   Lat = col_double(),
##   Long = col_double(),
##   Location = col_character()
## )
```


```r
raw_911 %>% 
  count(offense_code_group)
## # A tibble: 68 x 2
##    offense_code_group                   n
##    <chr>                            <int>
##  1 Aggravated Assault               10687
##  2 Aircraft                            60
##  3 Arson                              109
##  4 Assembly or Gathering Violations  1143
##  5 Auto Theft                        6211
##  6 Auto Theft Recovery               1385
##  7 Ballistics                        1338
##  8 Biological Threat                    3
##  9 Bomb Hoax                          109
## 10 Burglary - No Property Taken         5
## # … with 58 more rows
```

- There are fewer types of code groups. 
- They are rather informative.
- 33k missing observations though
- is the same amount of missingness present in the descriptions?


```r
raw_911 %>% 
  count(offense_description)
## # A tibble: 279 x 2
##    offense_description                              n
##    <chr>                                        <int>
##  1 A&B HANDS, FEET, ETC.  - MED. ATTENTION REQ.     1
##  2 A&B ON POLICE OFFICER                            7
##  3 ABDUCTION - INTICING                            12
##  4 AFFRAY                                         318
##  5 AIRCRAFT INCIDENTS                              70
##  6 ANIMAL ABUSE                                    89
##  7 ANIMAL CONTROL - DOG BITES - ETC.              493
##  8 ANIMAL INCIDENTS                               388
##  9 ANIMAL INCIDENTS (DOG BITES, LOST DOG, ETC)     34
## 10 ANNOYING AND ACCOSTIN                            3
## # … with 269 more rows
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
