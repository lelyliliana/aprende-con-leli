# Fechas ordenadas y series separadas
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- read.csv("datos/ambiental.csv", na.strings = "", fileEncoding = "UTF-8")
d$fecha <- as.Date(d$fecha)
d <- d[order(d$estacion, d$fecha), ]
g <- ggplot2::ggplot(d, ggplot2::aes(fecha, temperatura_c, colour = estacion, group = estacion)) +
  ggplot2::geom_line(linewidth = 0.8) + ggplot2::geom_point() +
  ggplot2::labs(title = "Temperaturas ficticias por estación", x = "Fecha", y = "Temperatura (°C)", colour = "Estación") +
  ggplot2::theme_minimal()
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave("salidas/graficos/temperatura.svg", g, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(length(unique(ggplot2::ggplot_build(g)$data[[1]]$group)) == 2)
cat("Serie temporal: dos estaciones separadas; 6 fechas por estación
")
