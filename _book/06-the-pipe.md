# The pipe ` %>% ` 





- previously we have been working with one function at a time.
- it will become necessary to perform one function after another
- one way we could go about this is to write over the eisting object multiple times with an assignment `<-` 
- this is repetitive and hard to read
- we can utilize the forward pipe operator ` %>% ` to chain functions together.
- 

from https://magrittr.tidyverse.org/: 

```
Basic piping
x %>% f is equivalent to f(x)
x %>% f(y) is equivalent to f(x, y)
x %>% f %>% g %>% h is equivalent to h(g(f(x)))
```


from tidy soc sci

## Chaining functions

The true power of the `tidyverse` comes from it's ability to chain functions after eachother. This is all enabled by the forward pipe operator `%>%`.

**What it does**: The pipe operator takes the output of it's left hand side `lhs` and provides that output as the first argument in the function of the right hand side. Additionally, it exposes the `lhs` as a temporary variable `.`. 

Remember how I pointed out that the first argument for almost every function is the data? This is where that comes in handy. This allows us to use the pipe to chain together functions and "makes it more intuitive to both read and write" (magrittr vignette).

You've seen how the first argument for every function here has been the data this is done purposefully to enable the use of the pipe. 

As always, the most helpful way to wrap your head around this is to see it in action. Let's take one of the lines of code we used above and adapt it to use a pipe. We will select the name column of our data again. Previously we wrote `select(data_frame, col_name)`.
