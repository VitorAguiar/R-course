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
  mutate(mes = factor(mes, levels = unique(mes)))
  filter(weather_data, variavel == "precipitação")

ylabel <- weather_data %$% paste(variavel[1], "(mm)")

ggplot(data = weather_data, aes(x = mes, y = valor, group = local, color = local)) +
  stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar") +
  stat_summary(fun.data = mean_cl_boot, geom = "line", size = 1.1) +
  scale_color_fivethirtyeight() +
  ylab(ylabel) +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14))


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

p_pos <-
  ggplot_build(p)$data[[3]] %>%
  dplyr::group_by(x) %>%
  dplyr::summarise(y = min(y), ymax = max(ymax)) %$%
  {ymax + min(y)}

p_vals <- 
  morpho_data %>%
  split(.$periodo) %>%
  purrr::map(~ t.test(crescimento ~ localidade, data = .)) %>%
  purrr::map_dbl("p.value") %>%
  format(scientific = TRUE, digits = 2) %>%
  paste("p =", .)

p + 
  annotate("text", x = seq_along(p_pos), y = p_pos, label = p_vals, size = 4)
