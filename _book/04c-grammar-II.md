# Grammer of layered graphics II



We've developed a strong foundation for building charts from the ground up by specifying our **defaults** (data, and aesthetic mappings), and adding geom **layers**. In order to take our charts to the next level we need to familiarize ourselves with the other components of the _Layered Grammar of Graphics_: scales, coordinates, and facets.

## Scales 

Recall from _[Grammar of Layered Graphics I](#layered-i)_ that when we supply our aesthetic mappings our axes are filled out automatically.


```r
(p <- ggplot(acs, aes(med_house_income, bach)))
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-2-1.png" width="672" />

By specifying our defaults in the `ggplot()` call, we implicitly are providing the x and y axes. From those mappings, ggplot2 is able to identify the type of variable mapped to each aesthetic and its values. That inference makes it possible for us to plot without having to explicitly state what our axes are.


```r
ggplot(acs, aes(med_house_income, bach)) +
  geom_point(size = 1/3)
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-3-1.png" width="672" />

In the above chart, each column is being mapped as a continuous variable. We are able to manually specify what each scale type is by using the various `scale_*_type()` layers from ggplot2. These layers follow a general format of first specifying `scale` followed by which aesthetic we're scaling, and what data type. For example, to change the `med_house_income` axis to a discrete axis we can apply the layer `scale_x_discrete()`


```r
ggplot(acs, aes(med_house_income, bach)) +
  geom_point(size = 1/3) +
  scale_x_discrete() 
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-4-1.png" width="672" />

In doing so we have lost the axis labels! That is because ggplot2 considers both integers and floating point (numbers with decimals) as continuous and categorical variables as being discrete. 

Nonetheless, we have a lot of functions at our disposal to alter the axes to our liking!

### Transformations

In our data exploration, we will come across non-normal distributions of data.

- income is almost always right skewed displaying some sort of log-normal-ish behavior. 
- we may not want to actually change to underlying values of that variable, but want to apply transformations for the purposes of visualization
- in that case, we can apply scale transformations
- in our visualization of income and education, there is a slight right skew to `med_house_income`
  - it doesn't justify a logarithmic transformation, but may benefit from a sqrt transformation
  - we can apply this with `scale_x_sqrt()`


```r
ggplot(acs, aes(med_house_income, bach)) +
  geom_point(size = 1/3) +
  scale_x_sqrt() 
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-5-1.png" width="672" />

We can apply a log10 transformation as well.


```r
ggplot(acs, aes(med_house_income, bach)) +
  geom_point(size = 1/3) +
  scale_x_log10() 
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-6-1.png" width="672" />

This is an overcorrection clearly the slight upward arch in the original plotting is now inverted

`scale_*_log10()`
`scale_*_reverse()`
`scale_*_sqrt()`
`scale_*_binned()`


```r
ggplot(acs, aes(med_house_income)) +
  geom_bar() + 
  scale_x_binned(n.breaks = 10)
```

<img src="04c-grammar-II_files/figure-html/unnamed-chunk-7-1.png" width="672" />


### Labeling

`labs()`
`lims()`
`expand_limits()`


## Coordinates

`coord_flip()`
`coord_cartesian()` - our default
`coord_polar()`

## Facets


`facet_wrap()`
`facet_grid()`
  