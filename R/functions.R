# empty function
f <- function() { 
  #This function does nothing
}

class(f)

f()

# function prints but doesn't return anything

f <- function(x) {
  print(x)

f("a")

# function returns a value

f <- function(num) {
  alpha <- letters[num]
  return(alpha)
}

f(10)

# function returns a value considering logical condition
f <- function(num) {
  letters[num]
}

f(10)


f <- function(num) {
  if (num <= 26) {
    letters[num]
  } else {
    stop("argument 'num' needs to be set to an integer <= 26")
  }
}

f(5)
f(30)

# argument with default value

f <- function(num = 1) {
    if (num <= 26) {
    letters[num]
  } else {
    stop("argument 'num' needs to be set to an integer <= 26")
  }
}

f(26)
f()

# argument matching
str(rnorm)

set.seed(1)
rnorm(n = 5, mean = 0, sd = 1)

set.seed(1)
rnorm(5, 0, 1)

set.seed(1)
rnorm(sd = 1, n = 5, mean = 0)


# argument matching with ambiguous abbreviation 

## rnorm
str(rnorm)
rnorm(n = 5, m = 0, s = 1)

## read.csv
altura <- read.csv(file = "../data/altura.csv")
altura <- read.csv(f = "../data/altura.csv")
str(read.csv)

# lazy evaluation

lazy_fun <- function(a, b) {
  a^2
}

lazy_fun(a = 2)

lazy_fun <- function(a, b) {
  a + b
}

lazy_fun(a = 2)

# lazy evaluation when you have a variable in the global environment
# which has the same name as the function argument

f <- function(a) {
  a + b
}

f(a = 2)

b <- 10

f(a = 2)

lazy_fun <- function(a, b) {
  a + b
}

b <- 10

lazy_fun(a = 2)

# the '...' argument

str(lapply)

sapply(X = list(rnorm(100), c(0, 10, 20, NA)), FUN = mean, na.rm = TRUE)

myfun <- function(..., num) {
  x <- paste(...)
  rep(x, num)
}

myfun("ccgt", "acgt", num = 2)

# return a list to return multiple values

foo_list <- function(x) {
  m <- mean(x, na.rm = TRUE)
  md <- median(x, na.rm = TRUE)
  v <- var(x, na.rm = TRUE)
  
  list(mean = m, median = md, variance = v)
}

foo_list(rnorm(100))

# automating complicated tasks: read and process a file

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

# apply the function

format_morpho("../data/dados_morfologicos.xlsx", "ALTURA")
