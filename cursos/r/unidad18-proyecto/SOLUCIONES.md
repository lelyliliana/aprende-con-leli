# Soluciones de la Unidad 18

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La entrada válida genera resumen, gráfico y registro del entorno. Los grupos tienen 18 registros cada uno, pero la media de horas utiliza 17 y 16 valores observados. El informe debe conservar esa distinción y declarar datos ficticios.

La solución crea una entrada temporal con puntaje -1. La validación falla antes de crear la carpeta de resultados; el original del curso se conserva. Esto comprueba el orden validar/calcular/escribir, no atomicidad de todos los archivos frente a una interrupción del sistema.

El caso ambiental tiene doce filas y once conteos conocidos. Describe el total observado y sus ausencias sin convertirlo en una estimación poblacional de abundancia. La rúbrica suma 100 y exige evidencia para pregunta, calidad, cálculos, figura y reproducción.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("proyecto/analizar.R", encoding = "UTF-8")
carpeta <- tempfile("proyecto-")
dir.create(carpeta)
d <- leer_encuesta(); d$puntaje[1] <- -1
entrada <- file.path(carpeta, "invalida.csv")
salida <- file.path(carpeta, "salida")
write.csv(d, entrada, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(ejecutar_analisis(entrada, salida), error = function(e) e)
stopifnot(inherits(error, "error"), !dir.exists(salida))
unlink(carpeta, recursive = TRUE)
cat("Entrada fuera del diccionario rechazada antes de crear resultados\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad18-proyecto/solucion.R
```
