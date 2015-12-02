library(magrittr)
library(data.table)
library(dplyr)
library(stringr)
library(tidyr)

header <- 
  scan("../data/mouse_500k_snps.vcf", what = "character", sep = "\n", nlines = 100) %>%
  .[grep("^##", .)]

mouse_vcf <- fread("../data/mouse_500k_snps.vcf", header = TRUE, 
                   skip = length(header))

dim(mouse_vcf)

names(mouse_vcf)
class(mouse_vcf)

head(mouse_vcf)

mouse_vcf %<>% as_data_frame()

mouse_vcf

mouse_vcf %>% count(`#CHROM`) %>% arrange(desc(n))
mouse_vcf %>% count(FILTER) %>% arrange(desc(n))

mouse_vcf %<>% arrange(`#CHROM`, POS)

mouse_vcf %<>% filter(FILTER == "PASS")

mouse_vcf %<>% filter(ID != ".")

mouse_vcf %<>% select(`#CHROM`, POS, ID, `129P2`:WSBEiJ)

mouse_vcf %<>% mutate_each(funs(. %>% str_extract("^\\d/\\d")), `129P2`:WSBEiJ)

mouse_vcf %>% count(`129P2`)

lapply(names(mouse_vcf)[-c(1:3)], 
       function(i) count_(mouse_vcf, paste0("`", i, "`")))

mouse_vcf %<>% gather(individual, genotype, `129P2`:WSBEiJ)

mouse_vcf

mouse_vcf %>% 
  group_by(`#CHROM`, individual) %>% 
  summarise(n = mean(genotype == "0/0", na.rm = TRUE)) %>%
  arrange(desc(n))

mouse_vcf %>% 
  group_by(`#CHROM`, individual) %>% 
  summarise(n = mean(genotype == "0/0", na.rm = TRUE)) %>%
  arrange(n)

mouse_vcf %>% 
  group_by(`#CHROM`) %>% 
  summarise(n = mean(is.na(genotype))) %>%
  arrange(desc(n))

library(ggplot2)
mouse_vcf %>% 
  group_by(`#CHROM`) %>% 
  summarise(n = mean(is.na(genotype))) %>%
  arrange(desc(n)) %>%
  ggplot(data = ., aes(x = `#CHROM`, y = n)) + 
  geom_bar(stat = "identity")

mouse_vcf %>% 
  group_by(individual) %>% 
  summarise(n = mean(is.na(genotype))) %>%
  arrange(desc(n)) 

mouse_vcf %>%
  separate(genotype, into = c("allele_1", "allele_2"), sep = "/")

# remind the lapply used above
# with tidy data, we can do:

mouse_vcf %>% count(individual, genotype)

mouse_vcf %>% count(individual, genotype) %>% spread(individual, n)
mouse_vcf %>% count(individual, genotype) %>% spread(genotype, n)
mouse_vcf %>% count(individual, genotype) %>% filter(!is.na(genotype)) %>% spread(genotype, n)

mouse_vcf %>% mutate(genotype = factor(genotype, levels = sort(unique(genotype))),
                     genotype = as.integer(genotype))

#PCA

