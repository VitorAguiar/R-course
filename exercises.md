1.  Create a vector `simul_vec` of random numbers sampled from the
    distribution of your choice (Normal, Poisson, Binomial, etc).

2.  Create a function that returns a list with the mean and the standard
    deviation of the object `simul_vec`.

3.  The function `rowMeans` returns the means of all rows in a
    data.frame. Create a function `sdMeans` that returns the sd of all
    rows (use the function `apply`). Read in the data [Mamiferos na
    Great
    Basin](http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:gbmam93.csv)
    and apply your function.

4.  Read in the data [Levantamento em 3 caixetais do Estado de São
    Paulo](http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:caixeta.csv).
    With `ggplot2`, make a plot of `h` vs. `cap`, faceting by
    `local`~`parcela` with the `facet_grid` component. Try to use the
    argument `margins = TRUE` in `facet_grid`.

5.  Create a data.frame from the data `Titanic` (already loaded in your
    R session) using the function `as.data.frame()`. Group the data by
    different variables (or multiple variables at once) and take the
    average frequency of survivors in the grouped data.

6.  Execute the following code to create the data.frame `df2`:

df2 \<- read.table(header=TRUE, text=" ind sex control trt1 trt2 1 m 7.9
12.3 10.7 2 f 6.3 10.6 11.1 3 f 9.5 13.1 13.8 4 m 11.5 13.4 12.9 ")

1.  Convert `df2` to the long format with the function `gather` from the
    package `tidyr`. The columns `control`, `trt1` and `trt2` will be
    converted to 2 columns: 1) `treatment`, which will indicate the kind
    of condition in the experiment, and 2) `value` which will store the
    measurements for each observation.

2.  Make a boxplot with `ggplot2` with the variable `sex` on the x axis,
    `value` on the y axis, and fill by `condition`.
