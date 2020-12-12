# R as a calculator

Before we get going, let's find our footing. R is a statistical programming language. That means that R does math and pretty well too. In this chapter you'll learn the basics of using R including:

  - arithmetic operators
  - creating and assigning variables
  - using functions

## Arithmetic Operators 

Do you remember PEMDAS? If not, a quick refresher that PEMDAS specifies the order of operations for a math expression. Do the math inside of the parentheses, then the exponents, and then the multiplication or the division before addition or subtraction. We can't write the math out, so we need to type it out. Below are the basic arithmetic operators

- `^` : exponentiation (exponents)  [E]
- `*` : multiplication [M]
- `/` : division [D]
- `+` : addition [A]
- `-` : subtraction [S]

These can be used together in parentheses [P] `( )` to determine the order of operations (`PEMDAS`)

There are three different ways to [execute code](https://support.rstudio.com/hc/en-us/articles/200484448-Editing-and-Executing-Code#executing) inside of RStudio[^sup]. The easiest way is to have your cursor on the line of code that you would like to execute. To execute hold `command + enter` (Mac) or `control + enter` (PC). Alternatively you can press the `Run` button at the top of the source page.

Now, try out some mathematic expressions in the console. 

## Variable assignment

I'm sure you recall some basic algebra questions like $y = 3x - 24$. In this equation, x and y are variables that represents some value. We will often need to create variables to represent some value or set of values. In R, we refer to variables as **objects**. Objects can be a single number, a set of words, matrixes, and so many other things. 

To create an object we need to assign it to some value. Object assignment is done with the assignment operator which looks like `<-`. You can automagically insert the assignment operator with `opt + -`. 

Let's work with the above example. We will solve for `y` when `x` is equal to 5.

First, we need to assign 5 to the variable x.


```r
x <- 5
```

If you want to see the contents of an object, you can print it. To print an object you can type the name of it.


```r
x
```

```
## [1] 5
```

We can reference the value that `x` stores in other mathematic expressions. Now what does `y` equal? Now solve for y in the above equation!


```r
y <- 3 * x - 24

y
```

```
## [1] -9
```

## Functions

Functions are a special kind of R object. Very simply, a function is an object that performs some action and (usually) produces an output. Functions exist to simplify a task. You can identify a function by the parentheses that are appended to the function name. A function looks like `function_name()`.  

R has many functions that come built in. The collection of functions that come out of the box with R are called *Base R**.

An example of a simple base R function is `sum()`. `sum()` takes any number of inputs and calculates the sum of those inputs. 

We can run `sum()` without providing any inputs.


```r
sum()
```

```
## [1] 0
```

We can provide more inputs (formally called function arguments) to `sum()`. For example to find the sum of 10 we write


```r
sum(10)
```

```
## [1] 10
```

The sum of a single number is the number itself. We can provide more arguments to `sum()`. Additional arguments are specified by separating them with commas—e.g. `function(argument_1, argument_2)`.

To find the sum of 10, 3, and 2 we write `sum(10, 3, 2)`.


```r
sum(10, 3, 2)
```

```
## [1] 15
```

Much of the analysis we will do is done with functions. You will become much more comfortable with them rather quickly. 

If you ever need to know how a function works, you can look at its help page by typing `?function_name()` in your console. That will bring up the documentation page in the bottom right pane. 


## Data Representations

Often we need to store collections of data together—perhaps these are daily reported cases of COVID, or the number of voters per state, etc. When we have two or more values together we usually store them in what is called a **vector**. Vectors are a representation of **one-dimensional** data. Think of a vector like a column in a table—a table is two dimensional with x and y axes. If we think of vectors in this way, the restriction that vector elements must be of the same type is not so hard to grasp.


To create a vector we use the function `c()`, short for combine, where each argument is a value in that vector. For example `c(1, 3, 5)` creates a vector with three **elements**. Each value is referred to as an element of the vector. The number of elements in a vector is referred to as its length. You can do math on vectors similarly as how you used R like a basic calculator. 


```r
odds <- c(1, 3, 5)

# make odds even by adding 1
odds + 1 
```

```
## [1] 2 4 6
```

Notice that we add the value 1 to each element of the vector. When doing vector calculations with vectors the other elements should generally be either the same length or be a scalar (a vector of length 1).

Look at this below example where we add a vector of the same length to our `odds` object. THe elements are added by position. So the first position (1 and 4 respectively) are added together. The second positions are added together, so on and so forth. 


```r
odds + c(4, 2, 0)
```

```
## [1] 5 5 5
```

Now, it is important to also note that there are other types of data that we will work with in R besides numeric data. The other broad category is what is called **character** or **string** data. I like to think of these as words, things that look like words or, alternatively, things that just don't look like numbers.

We represent character data by using quotation marks. For example there is an object that comes built into R called `letters`. If we print `letters` we can see it contains 26 elements—one for each of the letters of the alphabet. We can see how many elements there are in a vector with the function `length()`. `length(letters)` returns `26`. 

> Headache prevention: many people confuse when to quote things and when not to. A good rule of thumb is that objects (things you've assigned or created with `<-`) are not quoted and values are. Over time you'll get a better hang of this, I promise. 

In R there a few different type of vectors that you will encounter (you can even make your own!) so don't feel like you have to know them all right away.


## Extensions to R (packages)

While R was created as a statistical programming language, it was designed with the intention of being extended to include even more functionality. Extensions to R are called _packages_. R packages often provide a set of functions to accomplish a specific kind of task. 

To analyze, manipulate, and visualize our data, we will use a number of different packages to do so. Throughout this book we will become familiar with a set of packages that together are known as the [Tidyverse](https://tidyverse.org).

R packages do not come installed out of the box. We will need to install them our selves. Base R includes a function called `install.packages()`. `install.packages()` will download a specified package from CRAN and install it for us.

To download packages, we must tell `install.packages()` which package to download. We will provide the name of the package as the only argument to `install.packages()`. The name of the package needs to be put into quotations such as `install.packages("package-name")`.

> Note: By putting text into quotations we are creating what is called a **character string**.

> Reminder: we create objects with the assignment operator `<-`.

When we don't use quotes (create a character string), R thinks we are referring to an object we have created.

### Exercise

Use your new knowledge of functions and installing packages to install the tidyverse.


```r
install.packages("tidyverse")
```

## Loading Packages

Now that you have installed the tidyverse, you are going to need to know how to make it available to you for use. To load a package, we use the function `library()`. Oddly, though, when specifying which package to load, we do not put that name in quotations.

> Note: It is best practice to load all of your packages at the top of your R script. 


```r
library(tidyverse)
```

```
## ── Attaching packages ───────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.0     ✓ purrr   0.3.4
## ✓ tibble  3.0.3     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
```

```
## ── Conflicts ──────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

Notice the message above. When we load the tidyverse, we are actually loading eight packages at once! These are the packages listed under "**Attaching packages**" as well as their associated versions. 

You'll also see messages that says `Conflicts`. These conflicts indicate that the package we loaded has a function with the same name as one that was already loaded. The format looks like `packagename::function()`. So in this case, we can see that the functions `filter()` and `lag()` from `dplyr` conflict with the functions of the same name from the base `stats` installation. When you use `filter()` or `lag()` you will be using the version from dplyr. 

You have now successfully installed and loaded the tidyverse. Next, we will begin to learn how to visually analyze data!  

## What's next? 

Now with this very rudimentary foundation underneath you we will embark upon a very long journey—the journey to learn how to analyze data with R and RStudio. In the following chapters you will learn how to program in R from creating compelling graphics, manipulating data, and performing statistical tests. 

In the next chapter we will dive right into working with data. We will begin by learning how to read data into R. Then, we will work through a first visual analysis after which we will focus on skills used in general data manipulation. 


[^sup]: Executing Code. https://support.rstudio.com/hc/en-us/articles/200484448-Editing-and-Executing-Code#executing.
