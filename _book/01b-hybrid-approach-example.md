# Broken Windows and the origin of Ecometrics




To Cover:

- sampson & raudenbush systematic social observation: https://www.journals.uchicago.edu/doi/abs/10.1086/210356
- ecometrics: where was this first coined for the social sciences????
- 

-----

- 1980 "Broken Windows" in the Atlantic
- Posited that the presence of physical disorder led to crime
- this influenced policing policies like stop and frisk
  - led to the infamous implementation of [CompStat](https://nymag.com/intelligencer/2018/03/the-crime-fighting-program-that-changed-new-york-forever.html)
- the simplicity of the theory was appealing to public officials. media lapped it up
- social scientists were quick to shoot down the theory, seemed to not matter
- come 1999 Sampson and Raudenbush seek to test this find no conclusion
- much more work comes from it
- most noteably is the use of ecometrics in assessing this. I say most noteably because of its approach
  - it combines an inductive approach with a deductive one.
  - this is the quintessence of the Boston approach, of course it comes from Dan O'Brien.
    - why?:
      1. big data (actually big-ish which is rare in social science)
      2. The development and use of ecometrics (induction)
      3. deliberately testing an existing theory (deduction)
      4. Absolutely crushing it.
- what is an ecometric?
  - why is it inductive?
    - taking naturally occuring data, and extracting latent (already existing variables)
    - 


> Note: a case study should be recreating these ecometrics

Explore what the data description from BARI looks like


```r
library(tidyverse)
ecometrics <- readr::read_csv("data/911/911-ecometrics-2014-19.csv") %>% 
  janitor::clean_names()

glimpse(ecometrics)
#> Observations: 302
#> Variables: 15
#> $ type             <chr> "AB===>>>", "ABAN===>>>", "ABANBU", "ABANCELL",…
#> $ tycod            <chr> "AB", "ABAN", "ABAN", "ABAN", "ABAN", "ABAN", "…
#> $ typ_eng          <chr> "ASSAULT AND BATTERY", "ABANDONED CALL", "ABAND…
#> $ sub_tycod        <chr> "===>>>", "===>>>", "BU", "CELL", "INCCAL", "PH…
#> $ sub_eng          <chr> "PICK A SUB-TYPE", "PICK A SUB-TYPE", "FROM A B…
#> $ soc_dis          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ private_conflict <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ violence         <dbl> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,…
#> $ guns             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,…
#> $ frequency_2015   <dbl> 27, 40, 12768, 72081, 686, 1734, 3143, 194, 122…
#> $ frequency_2016   <dbl> 29, 26, 13287, 56074, 1188, 1205, 2687, 397, 19…
#> $ frequency_2017   <dbl> 29, 17, 12599, 39323, 124, 724, 1944, 253, 162,…
#> $ frequency_2018   <dbl> 14, 10, 6422, 19947, 70, 506, 840, 262, 169, 78…
#> $ yr_intro         <dbl> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014,…
#> $ last_yr          <dbl> 2019, 2018, 2019, 2019, 2019, 2019, 2019, 2019,…
```

Check out 


```r
raw_911 <- read_csv("data/911/911-raw.csv", n_max = 5000) %>% 
  janitor::clean_names()
```


```r
raw_911 %>% 
  filter(str_detect(offense_description, coll("battery", T)))
#> # A tibble: 342 x 17
#>    incident_number offense_code offense_code_gr… offense_descrip… district
#>    <chr>           <chr>        <chr>            <chr>            <chr>   
#>  1 I192078613      00802        Simple Assault   ASSAULT SIMPLE … A7      
#>  2 I192078603      00802        Simple Assault   ASSAULT SIMPLE … A7      
#>  3 I192078600      00413        Aggravated Assa… ASSAULT - AGGRA… C11     
#>  4 I192078573      00802        Simple Assault   ASSAULT SIMPLE … B2      
#>  5 I192078563      00413        Aggravated Assa… ASSAULT - AGGRA… B3      
#>  6 I192078563      00802        Simple Assault   ASSAULT SIMPLE … B3      
#>  7 I192078538      00802        Simple Assault   ASSAULT SIMPLE … C6      
#>  8 I192078531      00802        Simple Assault   ASSAULT SIMPLE … C11     
#>  9 I192078530      00413        Aggravated Assa… ASSAULT - AGGRA… C6      
#> 10 I192078529      00413        Aggravated Assa… ASSAULT - AGGRA… E5      
#> # … with 332 more rows, and 12 more variables: reporting_area <dbl>,
#> #   shooting <chr>, occurred_on_date <dttm>, year <dbl>, month <dbl>,
#> #   day_of_week <chr>, hour <dbl>, ucr_part <chr>, street <chr>,
#> #   lat <dbl>, long <dbl>, location <chr>
```




### Resources:

- https://www.annualreviews.org/doi/abs/10.1146/annurev-criminol-011518-024638?journalCode=criminol
- Large-scale data use, ecometrics to assess disorder: https://journals.sagepub.com/doi/abs/10.1177/0022427815577835
