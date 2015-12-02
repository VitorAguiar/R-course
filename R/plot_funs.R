plot_weather <- function(plot_df) {
  
  ylabel <- plot_df %$% paste0(variavel[1], " (", unidade[1], ")")
  
  ggplot(data = plot_df, aes(x = mes, y = valor, group = local, color = local)) +
    stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
    stat_summary(fun.data = mean_cl_boot, geom = "errorbar") +
    stat_summary(fun.data = mean_cl_boot, geom = "line", size = 1.1) +
    scale_color_fivethirtyeight() +
    ylab(ylabel) +
    theme(axis.title = element_text(size = 14),
          axis.text = element_text(size = 10),
          legend.text = element_text(size = 14),
          legend.title = element_text(size = 14))
}

plot_morpho <- function(df, unit) {
  
  p <- 
    ggplot(data = df, aes(x = periodo, y = crescimento, group = localidade, color = localidade)) + 
    stat_summary(fun.data = mean_cl_boot, geom = "point", size = 4) +
    stat_summary(fun.data = mean_cl_boot, geom = "errorbar") +
    stat_summary(fun.data = mean_cl_boot, geom = "line", size = 1.1) +
    xlab("") +
    ylab(sprintf("Taxa de crescimento (%s / dia)", unit)) +
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
    df %>%
    split(.$periodo) %>%
    purrr::map(~ t.test(crescimento ~ localidade, data = .)) %>%
    purrr::map_dbl("p.value") %>%
    format(scientific = TRUE, digits = 2) %>%
    paste("p =", .)
  
  p + 
    annotate("text", x = seq_along(p_pos), y = p_pos, label = p_vals, size = 4)
}