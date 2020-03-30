# Multiple data sets




Many times working with just one data set will not suffice. More often than not the data that we will be working with be will need to be supplemented by other data sets. These datasets have a shared relation which are what enables us to **join** them together. A join is a way of combining the columns between two sets of data while ensuring the rows are properly aligned. 

The relationship that joins these tables together are expressed in the data through what is called a **common identifier**. This a variable exists in both datasets—perhaps, with a different name—and can be used as a reference to associate rows from each table together. 

Recall to our definition of tidy data. The definition that we used characterized the data inside of a single table. There is actually another rule: "each observational unit forms a table." So, in our previous definition a row was a single observation. When we extend the definition as such this is still the case but we have to create distinctions between "observational units[s]." 

To explore this concept we will use data about Airbnb listings in Boston. These data come from [Inside Airbnb](http://insideairbnb.com). Inside Airbnb collects Airbnb's public listing and makes them available through a "non-commercial set of tools and data that allows you to explore how Airbnb is really being used in cities around the world" (http://insideairbnb.com/about.html). 

Inside Airbnb data are another example of harnessing naturally occurring data. The listings are not generated with the intent of _being_ data, but by the virtue of their existence, they become data. We are able to harness them to learn about the shifting neighborhood dynamic of cities. They can tell us something about  short term rentals in a locale and about where people may be visiting and when.

We will first look at two data sets: `listings`, and `hosts`.





