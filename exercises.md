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
    With `ggplot2`, make a scatterplot of `h` vs. `cap`, faceting by
    `local`~`parcela` using the `facet_grid()` component. Try to use the
    argument `margins = TRUE` in `facet_grid()`. Add a
    `geom_smooth(method = lm)`.

5.  Create a data.frame from the data `Titanic` (already loaded in your
    R session) using the function `as.data.frame()`. Group the data by
    different variables (or multiple variables at once) and take the
    average frequency of survivors in the grouped data (use the package
    `dplyr`)

6.  Use the data below to create the data.frame `df2`:

    <table>
    <thead>
    <tr class="header">
    <th align="center">ind</th>
    <th align="center">sex</th>
    <th align="center">control</th>
    <th align="center">trt1</th>
    <th align="center">trt2</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td align="center">1</td>
    <td align="center">m</td>
    <td align="center">7.9</td>
    <td align="center">12.3</td>
    <td align="center">10.7</td>
    </tr>
    <tr class="even">
    <td align="center">2</td>
    <td align="center">f</td>
    <td align="center">6.3</td>
    <td align="center">10.6</td>
    <td align="center">11.1</td>
    </tr>
    <tr class="odd">
    <td align="center">3</td>
    <td align="center">f</td>
    <td align="center">9.5</td>
    <td align="center">13.1</td>
    <td align="center">13.8</td>
    </tr>
    <tr class="even">
    <td align="center">4</td>
    <td align="center">m</td>
    <td align="center">11.5</td>
    <td align="center">13.4</td>
    <td align="center">12.9</td>
    </tr>
    </tbody>
    </table>

7.  Convert `df2` to the long format with the function `gather` from the
    package `tidyr`. The columns `control`, `trt1` and `trt2` will be
    converted to 2 columns: 1) `treatment`, which will indicate the kind
    of condition in the experiment, and 2) `value` which will store the
    measurements for each observation.

8.  Make a boxplot with `ggplot2` with the variable `sex` on the x axis,
    `value` on the y axis, and fill by `treatment`.
