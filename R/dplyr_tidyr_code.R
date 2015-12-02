library(magrittr)

# magrittr operators: %>% and %<>%

#1 R base
class(iris)

#1 magrittr
iris %>% class()

#2 R base
grep("Petal", names(iris))

#2 magrittr
names(iris) %>% grep("Petal", .)

#3 R base
sapply(as.data.frame(list(a = 1:10, b = rbinom(10, 1, .5), c = rnorm(10))), mean)

#3 magrittr
list(a = 1:10, b = rbinom(10, 1, .5), c = rnorm(10)) %>%
  as.data.frame() %>%
  sapply(mean)

#4 R base
x <- 10
x <- log10(x) 
x

#4 magrittr
x <- 10
x %<>% log10()

#5 R base
iris <- iris[iris$Species == "virginica", ]

#5 magrittr
iris %<>% .[.$Species == "virginica", ]


#### dplyr --------------------------------------------------------------------#
data(msleep, package = "ggplot2")
library(dplyr)

str(msleep)

msleep %>% count(order)

msleep %>% filter(order == "Carnivora" & !is.na(brainwt))

msleep %>% 
  filter(order == "Carnivora" & !is.na(brainwt)) %>%
  select(genus, bodywt)


msleep %>%
  group_by(order) %>%
  summarise(average_sleep = mean(sleep_total)) %>%
  arrange(desc(average_sleep))

msleep %>% 
  group_by(order, vore) %>%
  summarise(average_sleep = mean(sleep_total), average_bodywt = mean(bodywt)) %>%
  ungroup() %>%
  arrange(average_sleep, average_bodywt) %>%
  as.data.frame()

msleep %>%
  group_by(order) %>%
  summarise_each(funs(mean(., na.rm = TRUE)), sleep_total, brainwt, bodywt)

msleep %>%
  group_by(order) %>%
  summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)), 
                 sleep_total, brainwt, bodywt) %>%
  select(order, starts_with("sleep"), starts_with("brainwt"), starts_with("bodywt"))

msleep %>%
  select(genus, sleep_total, awake) %>%
  mutate(prop_sleep_awake = sleep_total/awake)

msleep %>%
  select(genus, bodywt) %>%
  mutate(bodywt = round(bodywt*2.20462, digits = 2))

msleep %>%
  select(genus, sleep_total, awake) %>%
  mutate_each(funs(./24), sleep_total, awake) %>%
  arrange(desc(sleep_total))

msleep %>%
  select(genus, sleep_total, awake) %>%
  mutate_each(funs(./24), sleep_total, awake) %>%
  arrange(sleep_total, awake, genus)

msleep %>%
  select(genus, sleep_total, awake) %>%
  mutate_each(funs(./24), sleep_total, awake) %>%
  arrange(sleep_total, awake, genus) %>%
  rename(prop_sleep = sleep_total)

#### tidyr --------------------------------------------------------------------#

monkeys <- paste(sample(1:20), c(rep("ES", 10), rep("MG", 10)), sep = "_")

monkey_wt <- data_frame(individual = monkeys,
                        "2013/01/01" = rnorm(20, 5, 1),
                        "2014/01/14" = rnorm(20, 7, 1.5),
                        "2015/02/02" = rnorm(20, 10, 2))

monkey_wt

library(tidyr)

monkey_wt %<>%
  gather(key=date, value=weight, 2:4)

monkey_wt

monkey_wt %>% spread(date, weight)

monkey_wt %<>%  
  separate(individual, into = c("id_number", "state"), sep = "_") %>%
  mutate(id_number = as.numeric(id_number)) %>%
  arrange(id_number, state)

monkey_wt

monkey_wt %<>%
  extract(date, c("year", "month"), "(\\d+)/(\\d+)")

monkey_wt

monkey_wt %>% unite(date, year:month, sep = "/")

monkey_wt %>% 
  filter(state == "ES") %>% 
  spread(id_number, weight)
