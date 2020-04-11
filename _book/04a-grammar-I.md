# Grammer of layered graphics I  {#layered-i}




```r
library(tidyverse)

acs_messy <- read_csv("data/ACS_1317_TRACT.csv")

acs <- acs_messy %>% 
  separate(name, sep = ", ", into = c("tract", "county", "state")) %>% 
  mutate(tract = str_remove(tract, "Census Tract ")) %>% 
  na.omit()
```

You've made it quite far through this book. Now, I want to bring us back to the very beginning. In the first chapter we created a few visualizations with `ggplot2`. I want to unpack ggplot2 a bit more and also address some of the more philosophical underpinnings of visualization.

This chapter introduces you to the idea of the grammar of graphics, discusses when which visualizations are appropriate, and some fundamental design principles follow. 


## The Grammar of Layered Graphics

The `gg` in `ggplot2` refers to the grammar of graphics (and the `2` is because it's the second iteration). _The Grammar of Graphics_ (Wilkinson, 1999) is a seminal book in data visualization for the sciences in which, Wilkinson defines a complete system (grammar) for creating visualizations that go beyond the standard domain of "named graphics"—e.g. histogram, barchart, etc. [^wickham] 

ggplot2 is "an open source implementation of the grammar of graphics for **R**."[^wickham] Once we can internalize the grammar of graphics, creating plots will be an intuitive and artistic process rather than a mechanical one.

There are five high level components of the layered grammar[^wickham]. We will only cover the first two in this chapter.

1. **Defaults**:
    - Data
    - Mapping
2. **Layers**:
    - Data*
    - Mapping* 
    - Geom
    - Stat
    - Position 
3. Scales
4. Coordinates
5. Facets

## Layers and defaults

In the first chapter of this section we explored these principles but did not put a name to them. Recall that we can use `ggplot()` by itself and it returns a chart of nothing.


```r
ggplot()
```

<img src="04a-grammar-I_files/figure-html/unnamed-chunk-3-1.png" width="672" />

This is because we have not specified any of the defaults. In order for us to plot anything at all, we need to specify what (the data object) will be visualized, which features (the aesthetic mappings), and how (the geoms). When we begin to specify our x and y aesthetics the scales are interpreted.


```r
ggplot(acs, aes(med_house_income, by_auto))
```

<img src="04a-grammar-I_files/figure-html/unnamed-chunk-4-1.png" width="672" />

The final step is to add the geom layer which will inherit the data, aesthetic mappings, scale, and position while the `geom_*()` layer dictates the geometry.


```r
ggplot(acs, aes(bach, med_house_income))+ 
  geom_point()
```

<img src="04a-grammar-I_files/figure-html/unnamed-chunk-5-1.png" width="672" />

While this is the most common way you might define a ggplot, you should also be aware of the fact that each layer can stand on its own without you defining any of the defaults in the `ggplot()` call. Each geom inherits the defaults from `ggplot()`, but each `geom_*()` also has arguments for `data`, and `mapping`, providing you with increased flexibility.

> Note: the `geom_*()`s have the data as the second argument so either put the data there or name the argument explicitly. The choice is yours. Choose wisely! 

What happens if we provide all of this information to `geom_point()` and entirely omit `ggplot()`?


```r
geom_point(aes(med_house_income, by_auto), acs)
#> mapping: x = ~med_house_income, y = ~by_auto 
#> geom_point: na.rm = FALSE
#> stat_identity: na.rm = FALSE
#> position_identity
```

We see that we do not have the plot, but we do have all of the information required of a layer is printed out to the console. If we add an empty ggplot call ahead of the layer, we will be able to create the plot.


```r
ggplot() + 
  geom_point(aes(med_house_income, by_auto), acs)
```

<img src="04a-grammar-I_files/figure-html/unnamed-chunk-7-1.png" width="672" />

Being able to specify different data objects within each layer will provie to be extraordinarily helpful when we begin to work with spatial data, or plotting two different data frames with the same axes, or any other creative problem you wish to solve. 

