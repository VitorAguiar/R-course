------------------------------------------------------------------------

Ideally, a function:

-   performs a clearly specified task
-   has easily understood inputs
-   does not have side effects
-   returns value

functions can only return a single value

------------------------------------------------------------------------

    f <- function() { 
      #This function does nothing
    }

    class(f)

    [1] "function"

    f()

    NULL

------------------------------------------------------------------------

    f <- function(x) {
      print(x)
    }

    f("a")

    [1] "a"

------------------------------------------------------------------------

    f <- function(num) {
      alpha <- letters[num]
      return(alpha)
    }

    f(10)

    [1] "j"

    f <- function(num) {
      letters[num]
    }

    f(10)

    [1] "j"

------------------------------------------------------------------------

    f <- function(num) {
      if (num <= 26) {
        letters[num]
      } else {
        stop("argument 'num' needs to be set to an integer <= 26")
      }
    }

    f(5)

    [1] "e"

    f(30)

    Error in f(30): argument 'num' needs to be set to an integer <= 26

------------------------------------------------------------------------

    f <- function(num = 1) {
        if (num <= 26) {
        letters[num]
      } else {
        stop("argument 'num' needs to be set to an integer <= 26")
      }
    }

    f(26)

    [1] "z"

    f()

    [1] "a"

    str(rnorm)

    function (n, mean = 0, sd = 1)  

    set.seed(1)
    rnorm(n = 5, mean = 0, sd = 1)

    [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

    set.seed(1)
    rnorm(5, 0, 1)

    [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

    set.seed(1)
    rnorm(sd = 1, n = 5, mean = 0)

    [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

    # rnorm
    str(rnorm)

    function (n, mean = 0, sd = 1)  

    rnorm(n = 5, m = 0, s = 1)

    [1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884

    #read.csv
    altura <- read.csv(file = "../data/altura.csv")
    altura <- read.csv(f = "../data/altura.csv")

    Error in read.csv(f = "../data/altura.csv"): argument 1 matches multiple formal arguments

    str(read.csv)

    function (file, header = TRUE, sep = ",", quote = "\"", dec = ".", 
        fill = TRUE, comment.char = "", ...)  

------------------------------------------------------------------------

    lazy_fun <- function(a, b) {
      a^2
    }

    lazy_fun(a = 2)

    [1] 4

    lazy_fun <- function(a, b) {
      a + b
    }

    lazy_fun(a = 2)

    Error in lazy_fun(a = 2): argument "b" is missing, with no default

    f <- function(a) {
      a + b
    }

    f(a = 2)

    Error in f(a = 2): object 'b' not found

    b <- 10

    f(a = 2)

    [1] 12

    lazy_fun <- function(a, b) {
      a + b
    }

    b <- 10

    lazy_fun(a = 2)

    Error in lazy_fun(a = 2): argument "b" is missing, with no default

------------------------------------------------------------------------

    str(lapply)

    function (X, FUN, ...)  

    sapply(X = list(rnorm(100), c(0, 10, 20, NA)), FUN = mean, na.rm = TRUE)

    [1]  0.1304151 10.0000000

    myfun <- function(..., num) {
      x <- paste(...)
      rep(x, num)
    }

    myfun("ccgt", "acgt", num = 2)

    [1] "ccgt acgt" "ccgt acgt"

------------------------------------------------------------------------

    foo_list <- function(x) {
      m <- mean(x, na.rm = TRUE)
      md <- median(x, na.rm = TRUE)
      v <- var(x, na.rm = TRUE)
      
      list(mean = m, median = md, variance = v)
    }

    foo_list(rnorm(100))

    $mean
    [1] -0.01984126

    $median
    [1] -0.1679293

    $variance
    [1] 1.009418

doing lot a of copying and pasting?
-----------------------------------

You need a function!

    library(magrittr)

    format_morpho <- function(input_file, sheet) {
      
      variavel <- gsub(" ", "_", tolower(sheet))
      
      x <- 
        readxl::read_excel(input_file, sheet = sheet, na = "NA") %>%
        tidyr::gather(t1, valor, -c(mae, localidade, individuo)) %>%
        dplyr::mutate(t1 = t1 %>% as.character() %>% as.numeric() %>% 
                        as.Date(origin = "1904-01-01")) %>%
        dplyr::mutate(variavel = rep(variavel, nrow(.)))
      
      dates <- unique(x$t1)
      prev_dates <- c(dates[1], dates[-length(dates)])
      prev <- data.frame(t0 = prev_dates, t1 = dates)
      
      x %>%
        dplyr::inner_join(prev, by = "t1") %>%
        dplyr::mutate(dias_passados = as.numeric(t1 - t0)) %>%
        dplyr::group_by(mae, localidade, individuo) %>%
        dplyr::mutate(crescimento = round(c(0, diff(valor))/dias_passados, digits = 2)) %>%
        dplyr::ungroup() %>%
        dplyr::filter(dias_passados > 0) %>%
        dplyr::select(variavel, localidade, mae, individuo, t0, t1, crescimento) %>%
        dplyr::arrange(localidade, mae, individuo, t0, t1)
    }

------------------------------------------------------------------------

    format_morpho("../data/dados_morfologicos.xlsx", "ALTURA")

    Source: local data frame [616 x 7]

       variavel localidade   mae individuo         t0         t1 crescimento
          (chr)      (chr) (dbl)     (chr)     (date)     (date)       (dbl)
    1    altura         RJ     3         A 2015-01-12 2015-01-22        0.00
    2    altura         RJ     3         A 2015-01-22 2015-03-01        0.00
    3    altura         RJ     3         A 2015-03-01 2015-04-10        0.06
    4    altura         RJ     3         A 2015-04-10 2015-05-12        0.12
    5    altura         RJ     3         A 2015-05-12 2015-06-08        0.04
    6    altura         RJ     3         A 2015-06-08 2015-07-09        0.00
    7    altura         RJ     3         A 2015-07-09 2015-08-24        0.00
    8    altura         RJ     3         B 2015-01-12 2015-01-22        0.10
    9    altura         RJ     3         B 2015-01-22 2015-03-01        0.00
    10   altura         RJ     3         B 2015-03-01 2015-04-10        0.02
    ..      ...        ...   ...       ...        ...        ...         ...
