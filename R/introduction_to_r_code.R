#### Environment and assingment -----------------------------------------------#

ls()

x <- 10

ls()

rm(x)

ls()


#### Data structures and Types ------------------------------------------------#

# 1D

## homogeneous: atomic vector
v <- 10
v
class(v)

v <- 1:100
v
class(v)

typeof(v)

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
v
is.integer(v)
typeof(v)

v <- c("a", "c", "t", "g")
v
typeof(v)

## factor
f <- factor(c("a", "b", "b", "a", "b", "a", "b", "a"))
f
typeof(f)
class(f)

## heterogeneous: lists

l <- list(a = 1:10, b = c("a", "t", "c", "g"), c = data.frame(var1 = 1:3, var2 = c("a", "b", "c")))
l
typeof(l)

# 2D

## matrix

m <- matrix(c("a", "b", 1, 2), nrow = 2)
m
typeof(m)

## data frame

df <- data.frame(letter = c("a", "b", "c"), number = 1:3)
df
typeof(df)

list(letter = c("a", "b", "c"), number = 1:3)
as.data.frame(list(letter = c("a", "b", "c"), number = 1:3))

# nD

## array
a <- array(1:12, dim = c(2, 3, 2))
a

### these are the same:
array(1:6, c(2, 3))
matrix(1:6, nrow = 2)

# attributes

length(v)
length(l)
dim(m)
dim(df)
dim(a)

names(v)
names(v) <- c("nt1", "nt2", "nt3", "nt4")
v
names(v)

rownames(m) <- c("ind1", "ind2")
colnames(m) <- c("letter", "number")
#or:
dimnames(m) <- list(c("ind1", "ind2"), c("letter", "number"))

attributes(m)
attributes(df)

# str()
str(v)
str(df)

summary(df)

#### Subsetting ---------------------------------------------------------------#

v
v[1]
v[c(1, 4)]
v[-1]
v[c(TRUE, FALSE, TRUE, FALSE)]
v[v > "c"]

names(v) <- c("nt1", "nt2", "nt3", "nt4")
v["nt3"]

l

l[1]
l["a"]
class(l[1])
l[[1]]
class(l[[1]])
l[[1]][1]

l$a

df

df$letter

m
m[1, 1]
m[2, 1:2]
m[, 1]
m[-1, ]

df
df[2, 1:2]
df[[2]]

#### getting help -------------------------------------------------------------#

help(mean)

?mean

?"["

??"linear model"

apropos("mean")

help(package="dplyr")


#### Apply --------------------------------------------------------------------#

sapply(iris[1:4], mean)

iris_by_species <- split(iris, iris$Species)

lapply(iris_by_species, function(x) 
  summary(lm(Sepal.Length~Sepal.Width, data = x))$r.squared)

#### flow control structures --------------------------------------------------#

for (i in 1:10) print(i)

for (i in 1:10) {
  
  if (i < 5) {
    print(i)
  } else {
    print(i * 100)
  }
}

#### Vectorization and recycling ----------------------------------------------#

(1:10) ^ 2

1:10 * c(2, 3)

#### datasets -----------------------------------------------------------------#

library(help="datasets")


#### Hands on -----------------------------------------------------------------#

head(iris)
str(iris)
summary(iris)
sum(iris$Petal.Length)
mean(iris$Sepal.Width)
tapply(iris$Petal.Length, iris$Species, mean)
sapply(subset(iris, select = -Species), mean)

mean(rnorm(100) > 0)
table(rbinom(100, 1, 0.5))

#### session info -------------------------------------------------------------#
sessionInfo()