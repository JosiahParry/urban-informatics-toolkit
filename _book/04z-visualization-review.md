# Visualization Review

So here we are, at the end of the third and longest section of the Urban Informatics Toolkit. We've covered a lot of ground and rather quickly so let's recap. 

We started by going over the grammar of graphics. The grammar is used to define the components of a visualization and ggplot2 is the R implementation of the graphics. The grammar has five main components:


1. Defaults:
    - Data
    - Mapping
2. Layers:
    - Data
    - Mapping
    - Geom
    - Stat
    - Position 
3. Scales
4. Coordinates
5. Facets

We build plots by providing data either to `ggplot()` which sets the defaults, or the data can be provided directly to the geom layers. Remember that the `geom_*()` layers are what creates the geometry on the plots. Without them we do not populate the graphic. The layers figure out the positions, scales, and coordinates from the data. We can also adjust these to fit our preference by using `scale_*()` and `coord_()` layerss if we would so desire. 

Following this, we explored the ways in which univariate and bivariate relationships can be explored visually. In this we explored the use of a number of different plots which can be added to your repertoire. Then we looked at how we can use facetting, color, shape, and size to explore beyond two dimensions. And finally, we briefly looked at the use of animation to explore data through time. 

All of the visualization strategies can be used either independently or in combination to create compelling graphics thats tell a story from data.

In the next sectino we will cover a few more advanced and disparate topics which are important to have in your tool kit. It may be good to take a break right now before we continue. 

Are you hydrated?
