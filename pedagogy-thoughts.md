## 2020-12-13

In spatial analysis introduce typical types of spatial visualization:
  - choropleth
  - dot density
  - cartogram
  

## 2020-11-29

- Make title case all chapter titles
- Rename to "summarizing data" from "summarizing the tidy way"
- Reading data - mention that tibbles are data frames 
- Working with dates and strings in expanding the tool kit
- Add a note on style before toolkit review
- In **Creating new measures** introduce some useful functions:
  - min, max, median, mean, sd

### Introduction mods: 

Modify the introduction to note that the beginning portions of learning to program can be very tough, frustrating, boring at times, and requires a little bit of rote memorization. But at the end of the day the tools you'll be equipped with open up so many doors to so much fun work. 


### Vectors and shit

Bite the bullet and introduce vectors in R as a calculator.

Often we need to store collections of data together. Perhaps these are daily reported cases of COVID or the number of voters per state, etc. When we have two or more values together they are called a **vector**. Vectors are representation of **one-dimensional** data. Think of a vector like a column in a table. This means that vectors have to be the same type. To create a vector we use the function `c()`, short for combine, where each argument is a value in that vector. 

For example `c(1, 3, 5)` creates a vector with three **elements**. Each value is referred to as an element of the vector. The number of elements in a vector is referred to as its length. You can do math on vectors similarly as how you used R like a basic calculator. 

```{r}
odds <- c(1, 3, 5)

# make odds even by adding 1
```

Notice that we add the value 1 to each element of the vector. 

When doing vector math the vectors should generally be the same length _or_ be a scalar (a vector of length 1). 

Look at this below example where we add a vector of the same length to our `odds` object. THe elements are added by position. So the first position (1 and 4 respectively) are added together. The second positions are added together, so on and so forth. 

```{r}
odds + c(4, 2, 0)
```

Now, it is important to also note that therer are other types of data that we will work with in R besides numeric data. The other broad category is what is called **character** or **string** data. These are just words. Or representations of things that we cannot necessarily do math on directly. We represent character data by using quotation marks. 

For example there is an object that comes built into R called `letters`. If we print `letters` we can see it contains 26 elements—one for each of the letters of the alphabet. We can see how many elements there are in a vector with the function `length()`. `length(letters)` returns `26`. 

> Headache prevention: many people confuse when to quote things and when not to. A good rule of thumb is that objects (things you've assigned or created) are not quoted and values are. Over time you'll get a better hang of this. I promise. 


there are many different type of vectors in R (you can even make your own!) so don't feel like you have to know them all right away. We'll adress them as we see them. 



### 2020-02-24

Can call the focus of inductive and deductive a posterior and a priori

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
  


