# ---------------------------------------------------------------------------- #
# Parameters:
# Pop size
N <- 1000

# Number of generations
ngens <- 2000

# Number of populations
npops <- 10

# Create a matrix to store results.
# Each row will be a generation and each column, a population.

# Allele frequencies:
P <- matrix(nrow = ngens, ncol = npops) 

# for each population (N = 10)
for(i in 1:npops) {
  
  pop <- rep(0:1, each = N/2)
  P[1, i] <- mean(pop == 0)
  
  for(j in 2:ngens) {
    pop <- sample(pop, replace = TRUE)
    P[j, i] <- mean(pop == 0)
  }
}

# Heterozygosity matrix:
H <- 2 * P * (1-P)

# data formatting
library(dplyr)
library(tidyr)

P <- 
  data.frame(generation = 1:ngens, P) %>% 
  gather(population, frequency, -generation) %>% 
  mutate(population = extract_numeric(population) %>% factor())

# Population trajectories
library(ggplot2)

ggplot(P, aes(generation, frequency, group = population, color = population)) +
  geom_line()

# data formatting
H <- 
  data.frame(generation = 1:ngens, th_decrease = 0.5 * (1 - 1/N)^(1:ngens), H) %>%
  gather(population, frequency, -c(generation, th_decrease)) %>% 
  mutate(population = extract_numeric(population) %>% factor())

# Heterozygosity trajectories
ggplot(H, aes(generation, frequency)) +
  geom_line(aes(group = population, linetype = "populations"), color = "grey") +
  geom_line(aes(generation, th_decrease, linetype = "theoretical decrease")) +
  stat_summary(mapping = aes(linetype = "mean"), fun.y = mean, geom = "line") +
  scale_linetype_manual(name = "", values = c("populations" = 2, "theoretical decrease" =  3, "mean" = 1)) +
  theme_bw() +
  labs(title = "Heterozygosity change")