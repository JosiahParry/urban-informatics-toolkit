# Spatial Analysis

In the very beginning of the book we discussed some of the benefits of administrative data. One of the benefits mentioned is that administrative data are inherently **spatial**. Most data tend to be spatial in nature. This is because most events happen at a physical place. In the context of administrative data, we know that all data recorded at that level must fall within the municipal boundaries. Often we know the location within the municipality to a much finer scale—i.e. the block group, the voting ward, or even the exact point location. 

Identifying whether or not your data is spatial is easiest when there are geographic components present such as latitude and longitude. However, your data can also be spatial even if it isn't explicitly stated. Some things you can keep an eye out for are things like neighborhood, towns, county, etc. as these are location specific. It is likely that you will be performing analyses rooted in space and accounting for things such as counties but perhaps without using any geospatial techniques. 

In this section we will go over the very basics of geospatial analysis. 


## Types of spatial data

Within the field of Geographic Information Systems (**GIS**) there are two general umbrellas in which data fall under. These are vector and raster data.

**Vector** data is what you will find yourself working with most frequently. Most simply put they are _"points, lines, and polygons."_ The basis of vector data is the coordinate point. Just like the scatter plots we have built, each coordinate point is a combination of an x and y value (longitude and latitude respectively). This combination of x and y will tell us where something is. By combining two or more points we can trace along a path—think of the connect the dots diagrams you would do at restaurants as a kid—and create line segments. If, however, at any point these lines close, you now have a polygon.

The other umbrella of data is known as **raster** data. Raster data are to deal with more complex data that cannot easily be captured by a single point. Rasters are used to "represent spatially continuous phenomenon" [source](https://rspatial.org/raster/spatial/Spatialdata.pdf). Raster analysis is done to evaluate things like changing vegetation, elevation and slope modeling, analysing reflective surfaces, among much more. Raster analysis typically relies on satellite imagery or LiDAR laser point cloud data. Raster analysis is an extremely complex topic and requires devoted attention. As such, we will not cover it in this book. But, know that it exists and is out there! 


![](http://michaelminn.net/tutorials/gis-data/2019-points-lines-polygons.png)

## Working with spatial data 

Working with spatial data is made rather straightforward by the [`sf`](https://github.com/r-spatial/sf) package. We will be using this package to perform our spatial transformations. We will return to the Airbnb listings data to work through some of the skills that we will need.  

Begin by installing the `sf` (simple-features) package and loading the `locations` Airbnb dataset.


```r
library(sf)
```

```
## Linking to GEOS 3.7.2, GDAL 2.4.2, PROJ 5.2.0
```

```r
library(tidyverse)
```

```
## ── Attaching packages ───────────────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✓ tibble  2.1.3     ✓ purrr   0.3.3
## ✓ tidyr   1.0.2     ✓ dplyr   0.8.3
## ✓ readr   1.3.1     ✓ stringr 1.4.0
## ✓ tibble  2.1.3     ✓ forcats 0.4.0
```

```
## ── Conflicts ──────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
locations <- read_csv("data/airbnb/locations.csv")
```

```
## Parsed with column specification:
## cols(
##   id = col_double(),
##   longitude = col_double(),
##   latitude = col_double()
## )
```

```r
head(locations)
```

```
## # A tibble: 6 x 3
##      id longitude latitude
##   <dbl>     <dbl>    <dbl>
## 1  3781     -71.0     42.4
## 2  5506     -71.1     42.3
## 3  6695     -71.1     42.3
## 4  8789     -71.1     42.4
## 5 10730     -71.1     42.4
## 6 10813     -71.1     42.3
```
So far everything is the same. But now that we have a dataset with coordinate points, we can make this a spatial object using `sf`.

- use `st_as_sf()`
  - spatial transform as sf
  - all spatial transformations are prefixed with `st`
  - requires us to specify the spatial components (lat and long)
    - its annoying because lat long is actually y,x
  - use the `coord` argument to tell `sf` what the spatial components are. 


```r
loc_sf <- st_as_sf(locations,
         coords = c("longitude", "latitude"),
         crs = 4326)

head(loc_sf)
```

```
## Simple feature collection with 6 features and 1 field
## geometry type:  POINT
## dimension:      XY
## bbox:           xmin: -71.09559 ymin: 42.32981 xmax: -71.02991 ymax: 42.36413
## epsg (SRID):    4326
## proj4string:    +proj=longlat +datum=WGS84 +no_defs
## # A tibble: 6 x 2
##      id             geometry
##   <dbl>          <POINT [°]>
## 1  3781 (-71.02991 42.36413)
## 2  5506 (-71.09559 42.32981)
## 3  6695 (-71.09351 42.32994)
## 4  8789 (-71.06265 42.35919)
## 5 10730  (-71.06185 42.3584)
## 6 10813 (-71.08904 42.34961)
```

- We can now see that instead of a long and lat column we have a `geometry` column.
- 



https://geocompr.robinlovelace.net/

https://rud.is/books/30-day-map-challenge/points-01.html
