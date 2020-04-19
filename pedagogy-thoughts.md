### 2020-02-24

Can call the focus of inductive and deductive a posterior and apriori

### 2019-12-19

I want the learning experience to be done through follow along analysis projects 
the datasets that will be used are real BARI datasets
When do you introduce the technical concepts. 

The R4DS approach is to "get you up to speed with the basic tools of data exploration as quickly as possible". This is arguably the most important bit and I think I agree. I do think, though, that I want to introduce theory behind vectors rather early on. 


How heavy into the _actual_ theory do I go?

Do I provide a review of the Chicago School?

2019-12-29: the data and code should all live in an rstudio.cloud project that will be copied

2020-01-11: when do i introduce measures of central tendency? what about summary stats? 

2020-01-12:
  - create a function which will write the datasets to a `data` directory in the current project
  - i need to have an intro to projects
  - or have at the very beginning a required reaading to get up and started
  - 
  
2020-01-18: after introducing the basics of vis and manipulation etc, 
  - have 4 case studies which will cover the other stuff
  - or intersperse the case studies?
    - for example after the basics, have one rather basic exploration (perhaps the fed shutdown one i did?)
    
    
2020-01-30

build in reminders that this is difficult
remind students to take a break
remind students what they've done so far
build in excersizes that review from earlier chapters that they should feel comfortable with
reminder that r4ds.online has office hours


2020-04-19 Moving notes from index.Rmd


## Timeline

Advanced Topics:

- Draft data reshaping

- Draft text analysis


Text analysis

* unstructured text as data
* what is the scope and limitations of text data?
* working with text data:
  * stop words
  * tokenization



Editing

- Review data sources
- Review scenarios
- Create post-chapter exercises
- Create post-chapter TL;DR
- Make into package
- Create rstudio.cloud image


Topics that I need to find a way to include:

- stringr
- dplyr helpers: 
  - case_when()
  - arrange()
  - n_distinct()
- ! negation
----------------

## Progress Tracker 

* 2020-02-24:
  - fleshed out the introduction of visual analysis
  - next:
    - introduce the EDA workflow
    - introduce the ACS and it's role in social sciences



---
2020-04-19

Old notes from 03e-summary-stats.Rmd

- the lessons to take away from here is that:
  - when creating aggregate measures, there can only be one observation per subset
  - we are creating these aggregate measures we will be doing them on one column (aka a vector) at a time

- what is a summary stat?
- measures of central tendency
- measures of spread
- basic functions used
  - mean, median, & sd
  
  
2020-02-20 twitter responses:
https://twitter.com/JosiahParry/status/1230485651306549248?s=20

https://twitter.com/rhlvenugopal/status/1230489011073896449?s=20
- confidence intervals
- standard error 
- effect size

https://twitter.com/thomas_mock/status/1230489855425175552?s=20
- missing values! 
  


