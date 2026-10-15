# Soluciones de la Unidad 06

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

La función comprueba tipo y longitud antes de usar una condición sobre su contenido. Solo una cantidad numérica entre 0 y 40 satisface ese contrato. El texto "5" no se convierte automáticamente; esa política de conversión se tratará en archivos/calidad.

0 y 40 son límites válidos. -1 y 41 quedan fuera; NA no es una medición conocida; el texto tiene otro tipo; dos valores no son una cantidad escalar. La solución comprueba esos rechazos.

El ciclo agrega cada valor observado a suma y aumenta su denominador. Con ningún observado, dividir cero entre cero produce NaN; una función que exige al menos uno debe rechazar antes. La implementación de media del ejemplo no pretende validar todos los dominios posibles de una medición.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
validar_horas <- function(x) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || !is.finite(x) || x < 0 || x > 40) stop("Una cantidad de horas entre 0 y 40")
  x
}
stopifnot(validar_horas(0) == 0, validar_horas(40) == 40)
for (entrada in list(-1, 41, NA_real_, "5", c(1, 2))) {
  r <- tryCatch(validar_horas(entrada), error = function(e) e)
  stopifnot(inherits(r, "error"))
}
cat("Límites 0 y 40 aceptados; cinco entradas inválidas rechazadas\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad06-funciones/solucion.R
```
