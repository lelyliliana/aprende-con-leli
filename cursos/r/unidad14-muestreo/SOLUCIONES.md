# Soluciones de la Unidad 14

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

Con la misma semilla y secuencia de operaciones se repite la muestra del ejemplo. Cambiar el mecanismo de selección cambia otra cosa, aunque mantengas la semilla. La repetibilidad del programa no garantiza calidad del diseño.

Las medias calculadas en las quinientas muestras varían porque cambian las unidades seleccionadas. Se estudia la distribución del resultado del procedimiento, no se crean quinientas poblaciones reales.

Treinta selecciones de diez IDs con reemplazo repiten al menos un ID. Sin reemplazo, sample rechaza pedir más posiciones de las disponibles. Esto distingue repetir un valor compartido por varias unidades de seleccionar varias veces la misma unidad.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
unidades <- 1:10
set.seed(7)
muestra <- sample(unidades, 30, replace = TRUE)
stopifnot(length(muestra) == 30, anyDuplicated(muestra) > 0)
error <- tryCatch(sample(unidades, 30, replace = FALSE), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Con reemplazo: 30 selecciones de 10 unidades; repeticiones inevitables\n")
cat("Sin reemplazo no se pueden seleccionar 30 unidades de solo 10.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad14-muestreo/solucion.R
```
