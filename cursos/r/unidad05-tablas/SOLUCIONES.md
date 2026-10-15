# Soluciones de la Unidad 05

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

Dos valores de 5 con IDs A y B no son duplicados de identidad. La consulta conserva ambas filas. duplicated sobre valor y duplicated sobre id responden preguntas diferentes.

drop=FALSE mantiene un data.frame cuando seleccionas una columna. Una simplificación a vector no es necesariamente un error, pero debe coincidir con lo que exige la función siguiente.

[ devuelve una sublista; [[ extrae su elemento. En dos mediciones por persona, una clave posible es ID/momento, siempre que el diseño garantice una sola medición de esa persona en ese momento. La forma de la tabla debe seguir a su unidad de observación.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
d <- data.frame(id = c("A", "B", "C"), valor = c(5, 5, 8))
stopifnot(!anyDuplicated(d$id), anyDuplicated(d$valor) > 0)
r <- d[d$valor == 5, , drop = FALSE]
stopifnot(nrow(r) == 2, identical(r$id, c("A", "B")))
cat("Valores repetidos no implican ID duplicado; consulta conserva dos filas\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad05-tablas/solucion.R
```
