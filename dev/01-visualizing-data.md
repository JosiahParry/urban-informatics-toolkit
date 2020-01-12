# Visualizing Trends and Relationships


- most data analyses start with a visualization. 
- the data we have will dictate the type of visualizations we create
- there are many many different ways in which data can be represented
- generally these can be bucketed into two major categories
  - numeric 
    - integer
    - double
  - character 
    - think groups, factors, nominal, anything that doesn't have a numeric value that makes sense to count, aggregate, etc.
  
- in R we will use a package called ggplot2 to do the visualizaiton of our data 

- this one line of code will install the packages that we need to do this work. Don't be too concerned about _what_ a package is. We will go over this in more detail later. Very simply, a package is a collection of functions that make certain things possible or easier to do in R. We like to use packages because reinventing the wheel is never fun.

## revisiting the cartesian plane

- x and y coordinates
- generally two numeric values on the x and y. think of the standards scatterplot (below)
- we also can place groups on one axis
  - i.e. barchart (below)
- in more infrequent cases, we can have groups on the x and y 
  - heatmap
  
## our first visualization

## The grammar of layered graphics

- the `gg` in ggplot stands for "grammar of graphics".
- once we can internalize the grammar, creating plots becomes rather easy
- we specify our aesthetics
- we **add** layers (hence the plus sign). these take values from the specified aesthetics
- can add multiple layers
- add aesthetics other than x and y. helps us visualize more dimensions of the data. we can use shape, color, and size

