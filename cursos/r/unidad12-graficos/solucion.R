# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
g <- ggplot2::ggplot(d, ggplot2::aes(puntaje)) + ggplot2::geom_histogram(binwidth = 10, boundary = 0) +
  ggplot2::labs(x = "Puntaje (0 a 100)", y = "Registros", title = "Distribución de puntajes ficticios") + ggplot2::theme_minimal()
stopifnot(sum(ggplot2::ggplot_build(g)$data[[1]]$count) == 36)
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave("salidas/graficos/histograma.svg", g, width = 7, height = 4, device = grDevices::svg)
cat("Histograma: las frecuencias suman 36 y el ancho de intervalo se declara\n")
