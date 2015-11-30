#### generate a sample --------------------------------------------------------#

sample(1:10)
sample(1:10, 5)
sample(0:1, 10, replace = TRUE)
sample(0:1, 10, replace = TRUE, prob = c(0.9, 0.1))

#### random number generation giving distribution -----------------------------#
rnorm()
rbinom()
rpois()

#### distributions ------------------------------------------------------------#
dnorm()
dbinom()
dpois()

x <- rnorm(1000, mean = 0, sd = 1)
plot(x = x, y = dnorm(x))

#### cumulative distribution functions ----------------------------------------#

pnorm()
pbinom()
ppois()

pnorm(1, mean = 0, sd = 1)
pnorm(1, mean = 0, sd = 1) - pnorm(-1, mean = 0, sd = 1)
pnorm(2, mean = 0, sd = 1) - pnorm(-2, mean = 0, sd = 1)
pnorm(3, mean = 0, sd = 1) - pnorm(-3, mean = 0, sd = 1)

#### summary statistics for a single group ------------------------------------#

x <- rnorm(50)
mean(x)
median(x)
sd(x)
var(x)

summary(x)
quantile(x)
quantile(x, seq(from = 0, to = 1, by = 0.1))

#### summary statistics by groups ---------------------------------------------#

aggregate(msleep[c("sleep_total", "bodywt")], 
          by = list(order = msleep$order, vore = msleep$vore),
          FUN = mean, na.rm = TRUE)

library(dplyr)
msleep %>% 
  group_by(order, vore) %>% 
  summarise(mean_sleep = mean(sleep_total), mean_weight = mean(bodywt, na.rm = TRUE))

#### statistical tests --------------------------------------------------------#

intake <- c(1260, 1300, 1350, 1480, 1530, 1560, 1620, 1800, 1800, 1970, 2100)

## one sample t test

t.test(intake, mu = 1800)

## Wilcoxon

wilcox.test(intake, mu = 1800)

## two sample t test

sex <- rep(c("m", "f"), c(9, 13))
expend <- c(2200, 2750, 2910, 2830, 2380, 2100, 2315, 2312,
            2195, 1800, 1790, 1930, 1935, 2430, 2000, 2600,
            1470, 7.90, 1880, 1790, 1810, 1940)

energy <- data.frame(sex, expend)

str(energy)

t.test(expend~sex, data = energy)

## paired t test

plant <- CO2$Plant[CO2$Type == "Quebec" & CO2$Treatment == "nonchilled"]
nonchilled <- CO2$uptake[CO2$Type == "Quebec" & CO2$Treatment == "nonchilled"]
chilled <- CO2$uptake[CO2$Type == "Quebec" & CO2$Treatment == "chilled"]

plant_co2 <- data.frame(plant, chilled, nonchilled)

str(plant_co2)

t.test(nonchilled, chilled, data = plant_co2, paired = TRUE)

# compare with:
t.test(nonchilled, chilled, data = plant_co2, paired = FALSE)

## paired Wilcoxon
wilcox.test(nonchilled, chilled, data = plant_co2, paired = TRUE)


#### hands on -----------------------------------------------------------------#

?t.test

t.test(intake, mu = 1800, conf.level = 0.99)
t.test(expend~sex, data = energy, var.equal = TRUE)

my_t_test <- t.test(intake, mu = 1800)
str(my_t_test)

my_t_test$p.value

#### simple linear regression 

iris_setosa <- subset(iris, Species == "setosa")

summary(lm(Sepal.Length~Sepal.Width, data = iris_setosa))

library(ggplot2)
ggplot(data = iris_setosa, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(method = "lm")


## correlation 

## Pearson
cor(iris_setosa$Petal.Length, iris_setosa$Petal.Width)

#Are the correlations different from 0?
cor.test(iris_setosa$Petal.Length, iris_setosa$Petal.Width)

cor(iris_setosa[1:4])


## one-way analysis of variance 

anova(lm(weight~group, data = PlantGrowth))
oneway.test(weight~group, data = PlantGrowth)

pairwise.t.test(PlantGrowth$weight, PlantGrowth$group)

library(ggplot2)
ggplot(PlantGrowth, aes(group, weight)) +
  geom_point(size = 4, alpha = .8) +
  stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = .25, color = "red") +
  stat_summary(aes(group = 1), fun.data = mean_cl_boot, geom = "line", color = "red") +
  xlab("")

## Kruskal-Wallis

kruskal.test(weight~group, data = PlantGrowth)

## two_way analysis of variance

anova(lm(uptake~Type+Treatment, data = CO2))

## tabular data

treatments <- matrix(c(652, 1537, 598, 242, 36, 46, 38, 21, 218, 327, 106, 67),
                     nrow = 3, byrow = T)
colnames(treatments) <- c("0","1-150","151-300",">300")
rownames(treatments) <- c("treatment1", "treatment2", "treatment3")

treatments

## chi-squared 

chisq.test(treatments)

E <- chisq.test(treatments)$expected
O <- chisq.test(treatments)$observed
(O-E)^2/E

## multiple regression

data(cystfibr, package = "ISwR")
str(cystfibr)

summary(lm(pemax~age+sex+height+weight+bmp+fev1+rv+frc+tlc, data=cystfibr))

## anova table for multiple regression 

anova(lm(pemax~age+sex+height+weight+bmp+fev1+rv+frc+tlc, data=cystfibr))

## logistic regression

smoking <- gl(2, 1, 8, c("No", "Yes"))
obesity <- gl(2, 2, 8, c("No", "Yes"))
snoring <- gl(2, 4, 8, c("No", "Yes"))
n.tot <- c(60, 17, 8, 2, 187, 85, 51, 23)
prop.hyp <- c(5, 2, 1, 0, 35, 13, 15, 8)/n.tot
hyp_data <- data.frame(smoking, obesity, snoring, prop.hyp, n.tot)

summary(glm(prop.hyp~smoking+obesity+snoring, binomial, weights = n.tot, 
            data = hyp_data))