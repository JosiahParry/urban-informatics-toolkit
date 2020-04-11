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

Check out 


```r
# raw_911 <- read_csv("data/911/911-raw.csv", n_max = 5000) %>% 
#   janitor::clean_names()
```




### Resources:

- https://www.annualreviews.org/doi/abs/10.1146/annurev-criminol-011518-024638?journalCode=criminol
- Large-scale data use, ecometrics to assess disorder: https://journals.sagepub.com/doi/abs/10.1177/0022427815577835
