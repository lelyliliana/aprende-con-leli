# Soluciones de la Unidad 12

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La caja resume una distribución y los puntos muestran los registros. En esta encuesta el puntaje está completo: las 36 observaciones deben aparecer. El desplazamiento horizontal con semilla solo facilita lectura; no cambia el resultado.

El histograma de la solución declara ancho 10, borde 0 y eje de registros. La suma de sus frecuencias es 36. Eso comprueba el conteo, pero todavía debes revisar visualmente etiquetas, cortes y legibilidad.

Para una serie temporal, cada estación debe conservar su propia línea y el orden de fechas. Conectar filas de estaciones distintas produciría una relación gráfica que no está en el diseño. Todos los archivos del ejemplo usan datos ficticios.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
g <- ggplot2::ggplot(d, ggplot2::aes(puntaje)) + ggplot2::geom_histogram(binwidth = 10, boundary = 0) +
  ggplot2::labs(x = "Puntaje (0 a 100)", y = "Registros", title = "Distribución de puntajes ficticios") + ggplot2::theme_minimal()
stopifnot(sum(ggplot2::ggplot_build(g)$data[[1]]$count) == 36)
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave("salidas/graficos/histograma.svg", g, width = 7, height = 4, device = grDevices::svg)
cat("Histograma: las frecuencias suman 36 y el ancho de intervalo se declara\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad12-graficos/solucion.R
```
