
## filter


```r
library(tidyverse)
```

```
## ── Attaching packages ──────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✓ tibble  2.1.3     ✓ purrr   0.3.3
## ✓ tidyr   1.0.2     ✓ dplyr   0.8.3
## ✓ readr   1.3.1     ✓ stringr 1.4.0
## ✓ tibble  2.1.3     ✓ forcats 0.4.0
```

```
## ── Conflicts ─────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
acs_raw <- read_csv("data/ACS_1317_TRACT.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   name = col_character(),
##   med_yr_built = col_character(),
##   town = col_character(),
##   county = col_character(),
##   m_atown = col_character()
## )
```

```
## See spec(...) for full column specifications.
```


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
