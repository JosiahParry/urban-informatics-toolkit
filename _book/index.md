--- 
title: "Urban Informatics Toolkit"
description: "A hands on introduction approach to analyzing the urban Commons."
author: "Josiah Parry"
date: "2020-03-30"
site: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
---





# Welcome

Welcome to the Urban Informatics Toolkit! 
This book will provide you with an introduction to some of the history of Urban Informatics as a field, important concepts in the field, and provide you with the skills required to jumpstart your own exploration of the urban commons.

I have always struggled with overly academic writing and overly technical and obtuse descriptions of concepts, tasks, and phenomena that can be written in easy to understand ways. 

my goal for this text is to provide you with a non-technical instruction to a technical topic. I want this to be friendly and not adversarial nor patronizing. I will do my best to try and explain this language and topics the way that I would to my friends over a beer.


## What to expect

- This book is partitioned into chapters where each goes over a small subset of skills that is important to know and a few case studies. 
- the first half of the book will introduce you to the basic tools that you will need to know to become self-sufficient. From there on, we will work with case studies that also introduce new topics and further more advances skills
- In Part II each chapter, with a few exceptions, will introduce you to a social phenomenon. We will ask a question, and use a relevant dataset to answer this question. While we work to approach each question, we will pause to learn about the tools that we are using, understand what they are doing and why. There will _always_ be a TL;DR for each chapter recapping what we covered, and links to further resources. 
- technical chapters will be interspersed with non-techinical chapters.

## Reminders

Learning to program can be exceptionally difficult at times. It can be a roller coaster of emotions. It is expected that you will not understand everything the first go around. Do not get down on yourself. I encourage you to take breaks and not push yourself too hard. I understand you have deadlines, but sometimes it is better if you take a break, eat a healthy snack, go exercise, sleep, be social, etc and then come back. You will be much happier and your work will be even better and that I promise you! 

Perhaps I am showing my cards a bit too much, but I have always found that with tough assignments it is better to go to bed early and finish them in the morning than it is to stay up exceptionally late. Moral of that story is, get some sleep and take care of yourself! I'll be sure to remind you from time to time.


## Setting the Context: 


Urban Informatics is in a way a  byproduct of the "deluge" or "proliferation" of data. In essence, as we as a society have progressed technologically, we have been able to capture and store data on a rather unprecedented scale. This has led to massive stores of data that are used primarily for record keeping that are updated at near-real-time. For example, think of every time you make a Facebook post or send a tweet. That post or tweet is subsequently recorded in a remote database to ensure that it can be accessed at a later time. Dan O'Brien notes that this characteristic of big data is of the utmost consequence for "the advancement of science and policy in the digital age" (O'Brien, Urban Commons, p. 59). These naturally occurring data are so useful because they are essentially a track record of individuals' behavior over time. It is in a way as close as we can get to measuring behavior at real time. 

If we turn to the urban context, the importance of big data may become ever more apparent. For example, Boston local government has been keeping detailed records of property assessments, taxes owed and paid, by whom, their demographic characteristics, when and even where down to the ward level (Boston Public Library, recently digitized records). These administrative records have been kept on ink and paper until just a few decades ago. Through digitization efforts, these data are now accessible to historians, urban scholars, local government, and the general public. Having such data accessible provides a way to quantitatively inspect the development of the city from its geography, its policies, its demography, and much more that we have yet to see uncovered. 

There are a number of benefits that naturally occurring data provide. The first is that these are, in theory, comprehensive and contains information about all residents. Through administrative data we should, for example,  be able to determine the number of employed tax paying citizens as well as the underemployed who receive government benefits. Additionally, since these data are already being collected, the associated costs are minimal. In contrast to empirically collected data, administrative data are not just a representation of a single moment in time, but rather continually changing and updating. And due to the fact that administrative data are collected at the municipal level we are inherently dealing with geospatial data—data that have a location associated it. 

While there are many benefits to administrative big data, there are a couple of dangers we ought to be aware of. The first is that even though big data are comprehensive in theory, we cannot always take them as objective observations of the natural world. We must be cognizant of the fact that the biases that humans have are also represented in data. We cannot and should not separate theory from data. To take from Dan O'Brien

> ". . . the very point of science is to explain why things work the wsay they do. . .If we limit our inquiries only to correlation and eschew explanation, we are no longer conducting science." (O'Brien, 2019, Urban Commons p.61)

Furthermore, we should always be wary of the data that we use. Investigate its integrity, its source, its measurment constructs for what we may be using to understand one thing may be something else which we may not anticipate or expect. And laslty, always be aware of the ways in which you may be bringing in your own world views into your work as what we are after is not confirmation but understanding. 



-----

## outline / notes


The study of Urban Informatics is inherently intertwined with big data. Working with big data requires a set of skills that extends beyond quantitative and qualitative analysis expertise. Students need to know how to access, manipulate, analyze, communicate and share data artifacts. The intention of this practicum is to develop educational content to cultivate an expertise in data.

An online text and accompanying exercises will be created to teach students data science in a manner that is tailored toward Urban Informatics studies. Writing this content will provide an opportunity to synthesize the learnings and skills taught in the Urban Informatics program. The manner in which it will be done will also further access to the field and assist in the cultivation of future students.

------


Introduce interacting with public data via webportals and APIs

Geospatial analysis: 

* data are often grounded in space
* its important to understand where things happen
* 3 Common data that are associated with space
  * 311 - point (vector data)
  * census tracts - polygon (vector)
  * sattelite imagery - raster (we wont cover this)
* polygon is the most simple to work with
  * visualization of aggregate data
  * aggregating by polygon (building permits)
* points are a bit trickier
  * often we want to join this 
  

Text analysis

* unstructured text as data
* what is the scope and limitations of text data?
* working with text data:
  * stop words
  * tokenization





## Timeline

To Do: put dates to these.

Core Toolkit

- Draft intro to R, RStudio (R files, and R projects) 
  - done 2020-02-15
- Draft exploratory analysis
  - done
- Draft filtering data (logical statements)
   - done
- Draft mutate
- Draft %>% 
  - done 2020-02-18
- Draft data structures
  - done 2020-02-16
- Draft summary statistics
  - done 2020-02-20
- Draft group_by and summarize
  - done 2020-02-21
- Draft visualization principles
- Draft multiple data sources

UI Specific:

- Draft approaches to UI (inductive vs deductive) 
- Draft schools of UI (hybrid approach)
- Draft ecometrics

Advanced Topics:

- Draft data reshaping
- Draft spatial analysis
- Draft text analysis

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
  - ntile()
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


-------------


---------


