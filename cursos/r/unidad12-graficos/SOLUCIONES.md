# Soluciones razonadas de la Unidad 12

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Dos capas con propósitos distintos

La caja resume la distribución por grupo y los 36 puntos muestran observaciones. El desplazamiento horizontal separa coincidencias, mientras height=0 conserva el puntaje. El código comprueba dos grupos en la capa de cajas y 36 filas de puntos; la interpretación requiere mirar también la figura.

## Paso 2. Archivo y contenido

La solución genera practica-distribucion.svg y comprueba la etiqueta del puntaje. Debes abrirlo y registrar si el título es completo, las unidades se leen y los puntos no quedan cortados. Si no lo has revisado, la inspección humana sigue pendiente aunque el script termine correctamente.

## Paso 3. Mismos datos, distinta agrupación

Los archivos histograma.svg e histograma-5.svg usan anchos 10 y 5. Las frecuencias suman 36 en ambos. Puedes observar cambios de picos y detalle porque los intervalos son distintos. Comparar esos aspectos exige conservar escala y criterios de corte explícitos, además de no deducir causas por la forma.

## Reto de transferencia. Base visible de la figura

Se representarían 33 cantidades conocidas y se declararían 3 faltantes de 36 registros. Una leyenda posible es «Horas semanales de 33 participantes ficticios con medición disponible; 3 registros sin horas». El código comprueba las cuentas; una figura completa añadiría sus ejes y la geometría apropiada.

## Respuestas de autoevaluación

aes asigna variables a propiedades visuales; geom_point añade marcas. El jitter vertical cambiaría la posición que comunica puntaje. Los histogramas dependen de los anchos y límites de sus intervalos, incluso con las mismas cantidades.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
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
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad12-graficos/solucion.R
```

Salida esperada:

```text
Paso 1: dos grupos, caja de resumen y 36 puntos individuales.
Paso 2: SVG generado con título y unidad de puntaje; falta la inspección humana del archivo.
Paso 3: anchos 10 y 5; ambos conservan frecuencia total=36.
Reto: una figura solo de horas observadas usa 33 registros y declara 3 faltantes.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2012%20%28Visualizaci%C3%B3n%20con%20ggplot2%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
