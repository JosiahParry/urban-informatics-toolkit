--- 
title: "Urban Informatics Toolkit"
description: "A hands on introduction approach to analyzing the urban Commons."
author: "Josiah Parry"
date: "2020-02-26"
site: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
---





# Welcome


## Timeline

To Do: put dates to these.

Core Toolkit

- Draft intro to R, RStudio (R files, and R projects) 
  - done 2020-02-15
- Draft exploratory analysis
- Draft filtering data (logical statements)
- Draft %>% 
  - done 2020-02-18
- Draft data structures
  - done 2020-02-16
- Draft summary statistics
  - done 2020-02-20
- Draft group_by and summarize
  - done 2020-02-21
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

Welcome to the Urban Informatics Toolkit! 
This book will provide you with an introduction to some of the history of Urban Informatics as a field, important concepts in the field, and provide you with the skills required to jumpstart your own exploration of the urban commons.

## What is Urban Informatics

## What to expect

- This book is partitioned into chapters where each goes over a small subset of skills that is important to know and a few case studies. 
- the first half of the book will introduce you to the basic tools that you will need to know to become self-sufficient. From there on, we will work with case studies that also introduce new topics and further more advances skills
- In Part II each chapter, with a few exceptions, will introduce you to a social phenomenon. We will ask a question, and use a relevant dataset to answer this question. While we work to approach each question, we will pause to learn about the tools that we are using, understand what they are doing and why. There will _always_ be a TL;DR for each chapter recapping what we covered, and links to further resources. 
- technical chapters will be interspersed with non-techinical chapters.

## Reminders

Learning to program can be exceptionally difficult at times. It can be a roller coaster of emotions. It is expected that you will not understand everything the first go around. Do not get down on yourself. I encourage you to take breaks and not push yourself too hard. I understand you have deadlines, but sometimes it is better if you take a break, eat a healthy snack, go exercise, sleep, be social, etc and then come back. You will be much happier and your work will be even better and that I promise you! 

Perhaps I am showing my cards a bit too much, but I have always found that with tough assignments it is better to go to bed early and finish them in the morning than it is to stay up exceptionally late. Moral of that story is, get some sleep and take care of yourself! I'll be sure to remind you from time to time.

---------

## Setting the Context: 

### Big Data

### Open Data 



-----

## outline / notes


The study of Urban Informatics is inherently intertwined with big data. Working with big data requires a set of skills that extends beyond quantitative and qualitative analysis expertise. Students need to know how to access, manipulate, analyze, communicate and share data artifacts. The intention of this practicum is to develop educational content to cultivate an expertise in data.

An online text and accompanying exercises will be created to teach students data science in a manner that is tailored toward Urban Informatics studies. Writing this content will provide an opportunity to synthesize the learnings and skills taught in the Urban Informatics program. The manner in which it will be done will also further access to the field and assist in the cultivation of future students.

------

I have always struggled with overly academic writing and overly technical and obtuse descriptions of concepts, tasks, and phenomena that can be written in easy to understand ways. 

my goal for this text is to provide you with a non-technical instruction to a technical topic. I want this to be friendly and not adversarial nor patronizing. I will do my best to try and explain this language and topics the way that I would to my friends over a beer.

------


intro is what is ui
What is administrative data 
Current examples of the data driven city 
Why we need to learn data with theory
The data workflow
Question then data 
Data then questions new approach due to massive data 
There are many insights yet to be discovered 
R 
The hard part is getting started. I want to make this as easy as possible with social science and UI examples bear with me for a bit. 
* Basics as a calculator
* Visualization / Visualizing relationships / Visuializing relationships
  * the type of the data that we have will dictate how we visualize it
  * Univariate
  * Bivariate
* Data Manipulation
  * filtering data
Tidy and untidy data
* tidy data: 
  * this is just to introduce you to the idea and get an idea of what it looks like. No need to understand the code or anything that will show up afterwards.
  * the principles
  * demonstrate what it looks like
The boring part data structures 
Administrative data data cleaning manopulatoon 
Aggregation 

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


