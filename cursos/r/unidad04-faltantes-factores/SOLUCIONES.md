# Soluciones de la Unidad 04

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La media observada de 0,NA,20 es 10 y utiliza dos datos. No estima por sí sola la media que tendría el conjunto si se conociera el tercero.

Con todos los valores faltantes, eliminar NA deja cero observaciones y la media resulta NaN. No significa una media de cero. El contrato de una función debe decidir cómo comunicar que no hay valores utilizables.

Un nivel desconocido se convierte en NA al construir el factor con niveles cerrados. Esa ausencia fue creada por una incompatibilidad con el diccionario. Debes distinguirla de una respuesta originalmente vacía antes de resumir o excluir registros.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
x <- c(0, NA_real_, 20)
stopifnot(mean(x, na.rm = TRUE) == 10, sum(!is.na(x)) == 2)
vacio <- mean(c(NA_real_, NA_real_), na.rm = TRUE)
stopifnot(is.nan(vacio))
f <- factor(c("alta", "desconocida"), levels = c("baja", "media", "alta"))
stopifnot(sum(is.na(f)) == 1)
cat("Media con dos observados: 10; todo faltante: NaN; etiqueta desconocida: NA\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad04-faltantes-factores/solucion.R
```
