# The basics 

## What is R and why do I care?

What is R? R is the 18th letter of the alphabet, the fourth letter in _QWERTY_—like the keyboard—and, most importantly, R is a software package for statistical computing. 

- R is developed and maintained by a group known as the R Core Team
- they are part of the R Foundation

The R-project describes R as:

> R is an integrated suite of software facilities for data manipulation, calculation and graphical display.
https://www.r-project.org/about.html

- it's like a very fancy calculator that does many things in addition to all sorts of math
- R is produced by the R-project
- independent non-profit organization funded by the R foundation
- R is more than just a language for statistics
  - it is designed to be extended for further capabilities, and indeed it has been, this is done through software packages
  - will review this very shortly
- you may have been exposed to stata and spss previously.
  - R is different.
- R is unique for a number of reasons 
- it is both free and open source
- while it is free monetarily, free refers to "liberty, not price." (https://gnu.org) 
- while you continue in your learning be aware of the four essential freedoms and how it relates to the importance of scientific inquiry:

> 1. The freedom to run the program as you wish, for any purpose (freedom 0).
> 2. The freedom to study how the program works, and change it so it does your computing as you wish (freedom 1). Access to the source code is a precondition for this.
> 3. The freedom to redistribute copies so you can help others (freedom 2).
> 4. The freedom to distribute copies of your modified versions to others (freedom 3). By doing this you can give the whole community a chance to benefit from your changes. Access to the source code is a precondition for this.
- this is important to know as you begin to be a part of the R community

- these freedoms are part of the success of R as a language
- many of the statistical techniques that are being discovered and implemented are being done in R
- academics from around the globe are contributing to the language and the tools 
- we need to begin to think of tooling as **part of** the scientific process, not apart from it
- while you will likely use R to engage in scientific inquiry, many people have developed these tools specifically for that purpose and are no less scientific than what you will engage in
  - this means you should cite R when you get that chance
  - you should think about how the science you engage in will contribute to the open science movement
  - are you following the four essential freedoms?

https://cran.r-project.org/


## The RStudio IDE

- R when downloaded is a programming language that is interacted with through the terminal which, while some people love it, can feel like programming in the matrix
![](https://media.giphy.com/media/rWY9ySfjytitq/giphy.gif)
_ For this reason, we will download RStudio
- RStudio is an IDE (integrated development environment)
- i think of R and RStudio is typesetting a printing press and using a word processor like microsoft word
- Chester Ismay and Albert Kim's Modern Dive provide another excellent analogy of R and RStudio
  - R is the engine
  - RStudio is the car dashboard:
    - https://moderndive.com/1-getting-started.html
- rstudio gives you a place to write R, make and visualize graphics, and analyse data.
- R and RStudio can be used to build web applications (shiny gallery), websites and blogs, and even art (generative thomas). 
- there are (almost) no limits as to what you can do with R and RStudio

Let's get familiar with RStudio. You need to know where you are when working within RStudio. There are 4 quadrants that we work with (called panes). 

![](static/rstudio-editor.png)

This lovely graphic was created by my colleage thomas mock. [Source](https://github.com/jthomasmock/intro-tidyverse/blob/master/intro-to-tidyverse.rmd)

Let's focus on the edit, console, and output areas 

### The Editor

- The editor is where you will actually write your R code. 
- R code is written in text files that have the `.R` extension
- you can also write in what is known as an RMarkdown Document which has an extension of `.Rmd`
  - SIDE BAR
    - fun fact, this book is written in RMarkdown 
    - R markdown lets you integrate prose and R code together.
    - RMarkdown can be rendered into many formats including pdf, html, ppt
    - we will go over this at the end of the book
- we will work within R scripts primarily to keep things simple
- i donkt know if youre like me at all, but when I write, I tend to have two documents up, or at least two sections of a document. One for where the finalized content and another one as scratch paper
  - think of the editor as the place where you put the writing you want to keep
- executing code
  - (either with command + enter on the highlighted code or the line where your cursor is)
  - or the run button above
  - i recommend learning the key strokes. it will be immensely helpful
  - this brings us to the console


### The console

- the console is where your r code is actually executed
- so when you run a line of code from the editor 
- i also treat the console as my scratch paper
- you can write r code in here and it will not be saved into your R script (your word document)
- when you produce R code that creates a visualization, the code will be executed in the console and the visualization will show up in the viewer pane (the "Output" section)

### Output

- This quadrant is a very versatile section. 
- It will be used primarily for looking at things.
- this is where you will see your visualizations
- help documentation
- where you can navigate your files and open things

## Installing R & RStudio 

It's easiest if you install R _and then_ RStudio

- you will download R from the **C**entral **R** **A**rchival **N**etwork aka CRAN
  - this is the "offical" location for R and it's software extensions (called packages)
- install R: https://cran.r-project.org/
- install RStudio: https://rstudio.com/products/rstudio/download/#download
- when you're ready to get started, open RStudio not R (look for the circular logo)

if you get lost, check out the RStudio IDE cheatsheet


## R Projects

- once you open up RStudio you will be able to get rocking and rolling
- though, we want to instill some best practices from the get go
- one of which is the use of R projects. This will help contain code and files in one location. By being diligent in creating R projects you will save yourself SO MUCH hair pulling. 
- now what makes an R project and R project?
- a folder with a special `.Rproj` file
- the `Rproj` file lets R know that the directory (folder) you are working from is a project and will manage file paths for you. This may not be making a ton of sense, but it will once we get further through this book. 
- how do you make a new R project?
  - file new project
  - name the thing something informative
    - do NOT use spaces or periods. 
    - use dashes or underscores
- when should you make a new project?
  - if the code is related to eachother
  - i think of every general analysis as its own project
- refer to rstats.wtf

