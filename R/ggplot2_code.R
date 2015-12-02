library(ggplot2)
library(ggthemes)
library(magrittr)

anscombe

# mean
sapply(anscombe, mean)

# variance
sapply(anscombe, var)

# correlation x y
mapply(cor, anscombe[1:4], anscombe[5:8])

# linear regression line
mapply(function(x, y) summary(lm(y ~ x))$coef[,1], anscombe[1:4], anscombe[5:8])

anscombe2 <-
  anscombe %>% 
  dplyr::mutate(i = 1:nrow(.)) %>%
  tidyr::gather(variable, value, x1:y4) %>%
  tidyr::extract(variable, c("variable", "idx"), "(x|y)([1-4])") %>%
  tidyr::spread(variable, value)

ggplot(anscombe2, aes(x, y)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  facet_wrap(~idx, scales = "free") +
  labs(title = "Anscombe's Quartet of 'Identical' Simple Linear Regressions")

# scatterplot
ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point()

# R base
with(iris, plot(Sepal.Length, Petal.Length))

# ggplot2
ggplot(iris, aes(Sepal.Length, Petal.Length)) + 
  geom_point()

# multiple histograms
par(mfrow = c(3, 1))
with(subset(iris, Species == "setosa"), hist(Sepal.Length, col = "red", main = "setosa"))
with(subset(iris, Species == "versicolor"), hist(Sepal.Length, col = "green", main = "versicolor"))
with(subset(iris, Species == "virginica"), hist(Sepal.Length, col = "blue", main = "virginica"))

# ggplot2:
ggplot(iris, aes(x = Sepal.Length, y = ..density.., fill = Species)) +
  geom_histogram(binwidth = 0.5) +
  facet_wrap(~Species, ncol = 1)

# automatic colors and legends
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(size = 4)

#shapes
ggplot(iris, aes(Sepal.Length, Petal.Length, shape = Species)) +
  geom_point(size = 4)

#mapping to a fourth variable
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(aes(size = Petal.Width))

#separate plots by species and fit smooth line
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + 
  geom_point() +
  geom_smooth(method = lm) +
  facet_wrap(~Species, scales = "free_x")

#smooth
ggplot(iris, aes(Sepal.Length, Petal.Length)) +
  geom_point(size = 4) +
  geom_smooth(method = lm)

ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm)

ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(aes(group = 1), method = lm)

#jitter
ggplot(iris, aes(Species, Petal.Length, color = Species)) +
  geom_jitter()

ggplot(iris, aes(Species, Petal.Length*Petal.Width, color = Species)) +
  geom_jitter()

#boxplot
ggplot(iris, aes(Species, Petal.Length*Petal.Width, fill = Species)) +
  geom_boxplot()

#histogram
ggplot(iris, aes(Petal.Length)) + 
  geom_histogram(binwidth = .2) 

ggplot(iris, aes(Petal.Length, fill = Species)) + 
  geom_histogram(binwidth = .1) 

ggplot(iris, aes(Petal.Length, fill = Species)) + 
  geom_histogram(aes(y = ..density..), binwidth = .1) 

#density smooth
ggplot(iris, aes(Petal.Length, fill = Species)) + 
  geom_density(alpha = .7) +
  theme_bw()

# bar
ggplot(msleep, aes(order, fill = vore)) + 
  geom_bar() +
  xlab("") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(dplyr::filter(msleep, !is.na(conservation)), aes(vore, fill = conservation)) + 
  geom_bar(position = "stack")

ggplot(dplyr::filter(msleep, !is.na(conservation)), aes(vore, fill = conservation)) + 
  geom_bar(position = "fill")

ggplot(dplyr::filter(msleep, !is.na(conservation)), aes(vore, fill = conservation)) + 
  geom_bar(position = "dodge")

# text 
ggplot(msleep, aes(bodywt, sleep_total, label = genus, color = vore)) + 
  geom_text(size = 3) +
  scale_x_log10()

#faceting
ggplot(iris, aes(Petal.Length, fill = Species)) + 
  geom_density(color = NA) +
  facet_wrap(~Species, ncol = 1) + 
  theme_bw()

#additional themes and color schemes
p <- 
  ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + 
  geom_point()

p + scale_color_wsj() + theme_wsj()

p + scale_color_fivethirtyeight() + theme_fivethirtyeight()

p + scale_color_economist() + theme_economist()

#lines
f <- seq(0.05, 0.95, by = 0.05)

hw <- 
  data.frame(allele_freq = f, f11 = f^2, f12 = 2*f*(1 - f), f22 = (1 - f)^2) %>%
  tidyr::gather(genotype, genotype_freq, f11:f22)

ggplot(data = hw, aes(x = allele_freq, y = genotype_freq, group = genotype)) +
  geom_line(size = 2)

#log
ggplot(data = msleep, aes(x = brainwt, y = bodywt, color = vore)) + 
  geom_point()

ggplot(data = msleep, aes(x = log10(brainwt), y = log10(bodywt), color = vore)) + 
  geom_point()

ggplot(data = msleep, aes(x = brainwt, y = bodywt, color = vore)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

#colors
library(RColorBrewer)
display.brewer.all()

#setting color

#wrong:
ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, color = "darkblue")) +
  geom_point()

#right:
ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(color = "darkblue")

#colorblind
ggplot(data = msleep, aes(x = brainwt, y = bodywt, color = vore)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  scale_colour_colorblind() #from ggthemes