# Soluciones de la Unidad 08

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

Se aceptan S01, S02 y S05. La tercera fila es duplicada equivalente de S02. Las filas 4,5,7,8 incumplen edad, horas, grupo o puntaje. S05 conserva horas NA porque ese campo puede faltar.

La coma decimal se interpreta bajo una política explícita y se conserva en el original. La función devuelve original, validas e incidencias; no reemplaza silenciosamente el archivo de entrada.

La solución cambia una repetición de S02 de 80 a 81. Como el mismo ID tiene ahora valores distintos, limpiar_entrada rechaza. Resolver ese conflicto necesitaría información adicional. Contar una fila excluida no justifica por sí solo la decisión de excluirla.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(nrow(r$validas) == 3, identical(r$validas$id, c("S01", "S02", "S05")))
archivo <- tempfile(fileext = ".csv")
contradiccion <- r$original
contradiccion$puntaje[3] <- "81"
write.csv(contradiccion, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(limpiar_entrada(archivo), error = function(e) e)
stopifnot(inherits(error, "error"))
unlink(archivo)
cat("Duplicado equivalente resuelto según política; duplicado contradictorio rechazado\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad08-limpieza/solucion.R
```
