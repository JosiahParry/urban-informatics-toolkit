# R as a calculator

Before we get going, let's find our footing. R is a statistical programming language. That means that R does math and pretty well too. In this chapter you'll learn the basics of using R including:

  - arithmetic operators
  - creating and assigning variables
  - using functions
  
  Executing code:
  
    - (either with command + enter on the highlighted code or the line where your cursor is)
  - or the run button above
  - i recommend learning the key strokes. it will be immensely helpful
  - this brings us to the console


## Arithmetic Operators 

Do you remember PEMDAS? If not, a quick refresher that PEMDAS specifies the order of operations for a math equation. Do the math inside of the parentheses, then the exponents, and then the multiplication or the division before addition or subtraction. We can't write the math out, so we need to type it out. Below are the basic arithmetic operators

- `^` : exponentiation (exponents)  [E]
- `*` : multiplication [M]
- `/` : division [D]
- `+` : addition [A]
- `-` : subtraction [S]

These can be used together in parentheses [P] `( )` to determine the order of operations (`PEMDAS`)

Try out some mathematic expressions in the console.

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

## Extensions to R 

While R was created as a statistical programming language, it was designed with the intention of being extended to include even more functionality. Extensions to R are called _packages_. R packages often provide a set of functions to accomplish a specific kind of task. 

To analyse, manipulate, and visualize our data, we will use a number of different packages to do so. Throughout this book we will become familiar with a set of packages that together are known as the [Tidyverse](https://tidyverse.org).

R packages do not come installed out of the box. We will need to install them our selves. Base R includes a function called `install.packages()`. `install.packages()` will download a specified package from CRAN and install it for us.

To download packages, we must tell `install.packages()` which package to download. We will provide the name of the package as the only argument to `install.packages()`. The name of the package needs to be put into quotations such as `install.packages("package-name")`.

> Note: By putting text into quotations we are creating what is called a **character string**.

> Reminder: we create objects with the assignment operator `<-`.

When we don't use quotes (create a character string), R thinks we are referring to an object we have created.

### Exercise

Use your new knowlege of functions and installing packages to install the tidyverse.


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
## ── Attaching packages ───────────────────────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✓ tibble  2.1.3     ✓ purrr   0.3.3
## ✓ tidyr   1.0.2     ✓ dplyr   0.8.3
## ✓ readr   1.3.1     ✓ stringr 1.4.0
## ✓ tibble  2.1.3     ✓ forcats 0.4.0
```

```
## ── Conflicts ──────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

Notice the message above. When we load the tidyverse, we are actually loading eight packages at once! Thesee are the packages listed under "**Attaching packages**."

You have now successfully installed and loaded the tidyverse. Next, we will begin to learn how to visually analyze data!  

### Resources:

- https://techterms.com/definition/string
