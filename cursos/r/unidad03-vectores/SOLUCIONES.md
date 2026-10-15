# Soluciones de la Unidad 03

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La máscara x>=6 selecciona 6,8,10. x[-1] produce 4,6,8,10 mientras x conserva los cinco valores. Una selección es un resultado que puedes asignar a otro nombre.

El vector lógico asociado a x%%4==2 es TRUE,FALSE,TRUE,FALSE,TRUE. La condición se evalúa por elemento.

La matriz se llena por columnas: su primera fila queda 1,3,5 y la segunda 2,4,6. El reciclaje 1:4 + c(10,20) devuelve 11,22,13,24. Esa repetición no valida que hayas emparejado las observaciones correctas.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
x <- c(2, 4, 6, 8, 10)
seleccion <- x[x >= 6]
sin_primero <- x[-1]
stopifnot(identical(seleccion, c(6, 8, 10)), length(sin_primero) == 4, length(x) == 5)
stopifnot(all(c(TRUE, FALSE, TRUE, FALSE, TRUE) == (x %% 4 == 2)))
cat("Seleccionados:", paste(seleccion, collapse = ", "), "; original sin cambio\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad03-vectores/solucion.R
```
