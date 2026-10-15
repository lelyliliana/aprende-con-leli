# Distribución y observaciones visibles
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
g <- figura_encuesta(d)
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
archivo <- "salidas/graficos/distribucion.svg"
ggplot2::ggsave(archivo, g, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(archivo)$size > 1000, nrow(ggplot2::ggplot_build(g)$data[[2]]) == 36)
cat("Gráfico SVG: distribución y 36 observaciones; unidad de puntaje declarada
")
