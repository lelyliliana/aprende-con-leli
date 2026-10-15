# Soluciones de la Unidad 07

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La encuesta correcta tiene 36 filas y tres vacíos permitidos en horas. La exportación debe conservar esas ausencias y las seis columnas, sin agregar índices como datos.

En el CSV de la solución, la segunda entrada es texto en una columna declarada double. readr registra una incidencia y genera NA para ese valor. Esa marca no tiene el mismo origen que un vacío de una pregunta sin respuesta.

La solución suprime la advertencia únicamente para inspeccionar explícitamente problems y comprobar la incidencia; no elimina el problema ni lo considera un dato válido. Para Excel se elige una hoja identificada y una cantidad de filas, en vez de asumir una única tabla por libro.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
archivo <- tempfile(fileext = ".csv")
writeLines(c("valor", "3", "texto"), archivo)
r <- suppressWarnings(readr::read_csv(archivo, col_types = readr::cols(valor = readr::col_double())))
problemas <- readr::problems(r)
stopifnot(nrow(problemas) == 1, is.na(r$valor[2]))
unlink(archivo)
cat("Conversión fallida detectada: una incidencia; NA no se acepta sin revisión\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad07-archivos/solucion.R
```
