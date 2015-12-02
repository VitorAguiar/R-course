library(magrittr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)

### dados climaticos

weather_data <- 
  read_csv("../data/dados_climaticos.csv") %>%
  gather(variavel, valor, -(local:mes)) %>%
  separate(variavel, c("variavel", "unidade"),
           sep = "_\\(|\\)_", extra = "drop") %>%
  mutate(mes = factor(mes, levels = unique(mes))) %>%
  filter(variavel == "precipitação")

png("../data/precipitacao.png", width = 12, height = 8, units = "in", res = 300)
ggplot(data = weather_data, aes(x = mes, y = valor, group = local, color = local)) +
  stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar") +
  stat_summary(fun.data = mean_cl_boot, geom = "line", size = 1.1) +
  scale_color_fivethirtyeight() +
  ylab("precipitação (mm)") +
  theme_bw() +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14))
dev.off()

### dados morfologicos

morpho_data <-
  read_csv("../data/dados_morfologicos.csv") %>%
  filter(variavel == "altura") 

p <- 
  ggplot(data = morpho_data, aes(x = periodo, y = crescimento, group = localidade, color = localidade)) + 
  stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar") +
  stat_summary(fun.data = mean_cl_boot, geom = "line", size = 1.1) +
  xlab("") +
  ylab("Taxa de crescimento (cm / dia)") +
  scale_color_fivethirtyeight() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14)) 

p_vals <- 
  morpho_data %>%
  split(.$periodo) %>%
  purrr::map(~ t.test(crescimento ~ localidade, data = .)) %>%
  purrr::map_dbl("p.value") %>%
  format(scientific = TRUE, digits = 2) %>%
  paste("p =", .)

p + 
  annotate("text", x = seq_along(p_pos), y = p_pos, label = p_vals, size = 4)
