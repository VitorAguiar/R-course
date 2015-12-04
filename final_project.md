Requirements
------------

1.  Based on your real data, generate fake data that can be publicly
    shared.

2.  Read the data in R.

3.  Manipulate the data with the packages `dplyr` and `tidyr`.

4.  Explore the data, compute summary statistics or apply statistical
    tests.

5.  Create at least one function and use it on the data.

6.  Make plots with `ggplot2` (minimum of 3 plots).

Suggestions
-----------

#### Read data:

Files of almost every format can be read in R.

-   R base functions
-   `readr` package
-   function `fread()` from the `data.table` package for large data
-   packages for specific kinds of data, e.g.:
    -   the `seqinr` package for nucleotide sequences
    -   the `ape` package for phylogenetics

Alternative: create your data directly in R

#### Data manipulation

-   remove or treat NA's
-   process the data and convert it into a structure that is suitable
    for data analysis
-   never modify the original data

#### exploratory data analysis

-   group and summarise your data in different ways to confirm your
    interpretations
-   use the apply family of functions to compute summary statistics

#### visualization

-   explore and visualize your data exhaustively

#### statistics

-   use the built-in statistical tests in R to explore the association
    between variables in your data

#### getting help

In R:

-   `?`
-   `??`
-   `help()`

On the internet

-   Google
-   [stackoverflow](http://stackoverflow.com/questions/tagged/r)
-   [Rseek](http://rseek.org)

#### good practices

-   version control (git and GitHub)
-   create functions to automate tasks
-   add documentation to your script
