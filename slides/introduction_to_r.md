Why?
====

Why use a programming language?
-------------------------------

-   reproducibility and communication
    -   code sharing
-   collaboration
-   automation
-   code is just text!
    -   easy to maintain and track changes
-   allows you to think more about your analysis
-   allows custom analyses
    -   existing software can only answer questions that have already
        been posed

Why R?
------

-   open source
-   free
-   large community
-   thousands of add-on packages
    -   statistical modelling
    -   visualization
    -   data manipulation
    -   biology!
-   connectivity with high performance languages
-   interactive exploratory analysis
-   allows a continuum of expertise

Drawbacks: can be slow and memory consuming

demo: Rstudio
=============

------------------------------------------------------------------------

> *"[In R] Every thing that exists is an object. Everything that happens
> is a function call."*

> -- <cite>John Chambers</cite>

Demo: environment and assignment
================================

Data structures
===============

------------------------------------------------------------------------

<table>
<thead>
<tr class="header">
<th align="center">dimension</th>
<th align="center">Homogeneous</th>
<th align="center">Heterogeneous</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">1d</td>
<td align="center">atomic vector</td>
<td align="center">List</td>
</tr>
<tr class="even">
<td align="center">2d</td>
<td align="center">matrix</td>
<td align="center">data frame</td>
</tr>
<tr class="odd">
<td align="center">nd</td>
<td align="center">array</td>
<td align="center"></td>
</tr>
</tbody>
</table>

**contructor functions:**

-   c()
-   vector()
-   list()
-   matrix()
-   data.frame()
-   array()
-   factor()

Types
-----

-   integer
-   numeric
-   character
-   logical
-   complex
-   raw

Special values
--------------

-   NULL
-   NA
-   NaN
-   Inf
-   TRUE and FALSE

demo: data structures and types
===============================

demo: subsetting
================

------------------------------------------------------------------------

![subsetting](https://pbs.twimg.com/media/CO2_qPVWsAAErbv.png:medium)

operators and functions
=======================

operators
---------

    x + y
    x - y 
    x * y
    x / y
    x ^ y
    x %% y
    x %/% y
    x %*% y
    x == y
    x != y  
    x > y
    x < y
    x >= y
    x <= y
    x | y
    x & y
    x %in% y

    ?Syntax  

Functions
---------

    fun <- function(x) do_something

Anonymous functions:

    function(x) do_something

commom built-in functions
-------------------------

<table>
<tbody>
<tr class="odd">
<td align="center">sum()</td>
<td align="center">str()</td>
<td align="center">rnorm()</td>
</tr>
<tr class="even">
<td align="center">log()</td>
<td align="center">summary()</td>
<td align="center">rbinom()</td>
</tr>
<tr class="odd">
<td align="center">exp()</td>
<td align="center">lm()</td>
<td align="center">runif()</td>
</tr>
<tr class="even">
<td align="center">mean()</td>
<td align="center">table()</td>
<td align="center">rbeta()</td>
</tr>
<tr class="odd">
<td align="center">median()</td>
<td align="center">head()</td>
<td align="center">rgamma()</td>
</tr>
<tr class="even">
<td align="center">var()</td>
<td align="center">tail()</td>
<td align="center">sample()</td>
</tr>
<tr class="odd">
<td align="center">sd()</td>
<td align="center">dim()</td>
<td align="center">rep()</td>
</tr>
<tr class="even">
<td align="center">sqrt()</td>
<td align="center">subset()</td>
<td align="center"></td>
</tr>
</tbody>
</table>

getting help
------------

    help(mean)

    ?mean

    ?"["

    ??"principal component"

    apropos("mean")

    help(package="dplyr")

apply
-----

-   apply
-   lapply
-   sapply
-   tapply
-   mapply

<!-- -->

    sapply(iris[1:4], mean)

    Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
        5.843333     3.057333     3.758000     1.199333 

Anonymous functions are very useful in `apply` functions:

    iris_by_species <- split(iris, iris$Species)
    lapply(iris_by_species, function(x) summary(lm(Sepal.Length~Sepal.Width, data = x))$r.squared)

    $setosa
    [1] 0.5513756

    $versicolor
    [1] 0.2765821

    $virginica
    [1] 0.2090573

flow control structures
-----------------------

-   for
-   while

<!-- -->

    for (iterator in times) do something

-   if
-   else

<!-- -->

    x <- 10
    if (x > 0) y <- 1 else y <- 0
    y

    [1] 1

-   next
-   stop

Vectorization
-------------

vectorized computations operate on all elements of a vector

    (1:10) ^ 2

     [1]   1   4   9  16  25  36  49  64  81 100

    1:10 * c(2, 3)

     [1]  2  6  6 12 10 18 14 24 18 30

datasets
--------

    library(help="datasets")

data in and out
===============

------------------------------------------------------------------------

<table>
<thead>
<tr class="header">
<th align="center">READ</th>
<th align="center">WRITE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">read.table()</td>
<td align="center">write.table()</td>
</tr>
<tr class="even">
<td align="center">read.csv()</td>
<td align="center">write.csv()</td>
</tr>
<tr class="odd">
<td align="center">read.csv2()</td>
<td align="center">write.csv2()</td>
</tr>
<tr class="even">
<td align="center">readLines()</td>
<td align="center">writeLines()</td>
</tr>
<tr class="odd">
<td align="center">readRDS()</td>
<td align="center">saveRDS()</td>
</tr>
</tbody>
</table>

Hands on!
=========

Choose a dataset and try to subset, apply functions, etc

e.g.:

    head(iris)
    str(iris)
    summary(iris)
    sum(iris$Petal.Length)
    mean(iris$Sepal.Width)
    tapply(iris$Petal.Length, iris$Species, mean)
    sapply(subset(iris, select = -Species), mean)

Generate data and apply the functions we've seen:

    mean(rnorm(100) > 0)
    table(rbinom(100, 1, 0.5))

Read the data at:

    http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:gbmam93.csv

And apply functions to rows and columns using the function apply

Packages
========

------------------------------------------------------------------------

[CRAN](https://cran.rstudio.com/web/packages/available_packages_by_date.html)

January 2015: 6000 packages on CRAN

    install.packages("PackageName")
    library("PackageName")

**GitHub:**

    devtools::install_github("UserName/PackageName")

------------------------------------------------------------------------

    sessionInfo()

    R version 3.2.1 (2015-06-18)
    Platform: x86_64-apple-darwin13.4.0 (64-bit)
    Running under: OS X 10.10.5 (Yosemite)

    locale:
    [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    loaded via a namespace (and not attached):
     [1] magrittr_1.5    formatR_1.2.1   tools_3.2.1     htmltools_0.2.6
     [5] yaml_2.1.13     stringi_1.0-1   rmarkdown_0.8.1 knitr_1.11     
     [9] stringr_1.0.0   digest_0.6.8    evaluate_0.8   

Good practices
--------------

-   style guides
-   use existing tools when available
    -   longer history
    -   larger audience
-   keep packages updated
-   do not save history or your environment
    -   rerun analysis from script
-   use a version control system
