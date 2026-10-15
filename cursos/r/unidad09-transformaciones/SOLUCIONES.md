# Soluciones de la Unidad 09

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El filtro dplyr y la selección base deben recuperar los mismos IDs bajo la misma condición. Ordenarlos permite comparar sin depender del orden de entrada. El original conserva sus 36 registros.

La encuesta tiene n=18 por grupo. Para horas, A utiliza 17 observaciones y B 16. El resumen informa ambos tamaños en vez de ocultar el denominador de la media.

.groups="drop" evita que el resultado conserve agrupación para operaciones posteriores. Si ninguna hora está observada en un grupo, se comunica n_horas=0 y media NA, sin interpretarla como cero ni como estimación de las respuestas faltantes.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
a <- d |> dplyr::filter(puntaje >= 80) |> dplyr::arrange(id)
b <- d[d$puntaje >= 80, , drop = FALSE]
b <- b[order(b$id), , drop = FALSE]
stopifnot(identical(a$id, b$id), nrow(d) == 36)
cat("Filtro contrastado con selección base; se conserva el original\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad09-transformaciones/solucion.R
```
