# Genetic Drift

## Create a haploid population of 1000 individuals with alleles 0 or 1 

# Number of individuals:
N <- 1000

# Population of individuals '0' or '1':
pop <- rep(0:1, each = N/2)

# or:
pop <- rep(0:1, times = c(500, 500))

# or:
pop <- rep(0:1, times = c(0.5, 0.5)*N)

## define vector with the frequencies of allele 0 in 2000 generations

# Number of generations
ngens <- 2000

# vector of frequencies:
p <- numeric(ngens)

# 1st element of vector 'p' will be the allele frequency in parent generation:
p[1] <- mean(pop == 0)

# Now we have to calculate the allele frequencies in the next generations.
# Let's use a 'for loop' to calculate the frequency in each generation and
# save the result as an element of vector 'p':
for(i in 2:ngens) {
  
  # the next generation is a random sample of the parental population:
  pop <- sample(pop, replace = TRUE)
  
  # allele frequency in the ith generation:
  p[i] <- mean(pop == 0)
}

freq_df <- data.frame(generation = 1:ngens, frequency = p)

library(ggplot2)

ggplot(freq_df, aes(x = generation, y = frequency)) +
  geom_line() +
  labs(title = "Allele frequency change") +
  coord_cartesian(ylim = c(0, 1))