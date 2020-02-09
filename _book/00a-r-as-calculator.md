# R as a calculator

Before we get going, let's find our footing. R is a statistical programming language. That means that R does math and pretty well too. 

Navigate and enter your console. You will know you have activated the console when the cursor starts flashing. As stated earlier, the console is where your code is executed. We can type R commands directly into the console and execute them there by pressing enter. 

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
