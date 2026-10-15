# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
# Paso 1. La caja resume y los puntos muestran los registros.
g <- figura_encuesta(d)
construido <- ggplot2::ggplot_build(g)
stopifnot(nrow(construido$data[[2]]) == 36, length(unique(construido$data[[1]]$group)) == 2)
cat("Paso 1: dos grupos, caja de resumen y 36 puntos individuales.\n")
# Paso 2. Guardar con unidades y comprobar propiedades de la figura.
archivo <- "salidas/graficos/practica-distribucion.svg"
ggplot2::ggsave(archivo, g, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(archivo)$size > 1000, g$labels$y == "Puntaje (0 a 100)")
cat("Paso 2: SVG generado con título y unidad de puntaje; falta la inspección humana del archivo.\n")
# Paso 3. Verificar frecuencias con dos anchos explícitos.
histograma <- function(ancho) {
  ggplot2::ggplot(d, ggplot2::aes(puntaje)) +
    ggplot2::geom_histogram(binwidth = ancho, boundary = 0) +
    ggplot2::labs(title = "Puntajes ficticios", x = "Puntaje (0 a 100)", y = "Registros") +
    ggplot2::theme_minimal()
}
h10 <- histograma(10)
h5 <- histograma(5)
stopifnot(sum(ggplot2::ggplot_build(h10)$data[[1]]$count) == 36)
stopifnot(sum(ggplot2::ggplot_build(h5)$data[[1]]$count) == 36)
ggplot2::ggsave("salidas/graficos/histograma.svg", h10, width = 7, height = 4, device = grDevices::svg)
ggplot2::ggsave("salidas/graficos/histograma-5.svg", h5, width = 7, height = 4, device = grDevices::svg)
cat("Paso 3: anchos 10 y 5; ambos conservan frecuencia total=36.\n")
# Reto. Etiquetar una figura de horas requiere declarar las ausencias.
observadas <- d[!is.na(d$horas_semana), , drop = FALSE]
stopifnot(nrow(observadas) == 33, nrow(d) - nrow(observadas) == 3)
cat("Reto: una figura solo de horas observadas usa 33 registros y declara 3 faltantes.\n")
