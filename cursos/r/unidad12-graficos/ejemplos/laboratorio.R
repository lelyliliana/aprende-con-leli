# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(horas = c(1, 2, 3, 4), puntaje = c(50, 60, 65, 80))
g <- ggplot2::ggplot(d, ggplot2::aes(x = horas, y = puntaje)) +
  ggplot2::geom_point(size = 3, colour = "#235789") +
  ggplot2::labs(title = "Cuatro observaciones ficticias", x = "Horas semanales", y = "Puntaje (0 a 100)") +
  ggplot2::theme_minimal()
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
archivo <- "salidas/graficos/laboratorio.svg"
ggplot2::ggsave(archivo, g, width = 7, height = 4, device = grDevices::svg)
stopifnot(nrow(ggplot2::ggplot_build(g)$data[[1]]) == 4, file.info(archivo)$size > 1000)
cat("Figura guardada: salidas/graficos/laboratorio.svg\n")
cat("Cuatro puntos, horas en x y puntaje en y; asociación descriptiva.\n")
