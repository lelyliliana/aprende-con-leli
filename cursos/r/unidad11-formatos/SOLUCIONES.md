# Soluciones de la Unidad 11

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El formato largo tiene cuatro mediciones y dos personas. ID/momento es la clave prevista. Esa distinción impide interpretar cuatro filas como cuatro personas independientes.

La solución usa un caso A con antes=60 y despues=72: diferencia 12. Antes de volver a ancho verifica que no exista una combinación repetida. Si la hay, detiene el proceso.

La validación es una política de a_ancho_seguro. pivot_wider admite otros usos, incluso agregaciones declaradas; eso no justifica reducir automáticamente duplicados cuya causa todavía no se conoce. La operación debe conservar qué medición pertenece a cada unidad.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
a_ancho_seguro <- function(d) {
  if (anyDuplicated(d[c("id", "momento")])) stop("Clave id-momento duplicada")
  tidyr::pivot_wider(d, names_from = momento, values_from = puntaje)
}
d <- data.frame(id = c("A", "A"), momento = c("antes", "despues"), puntaje = c(60, 72))
r <- a_ancho_seguro(d)
stopifnot(r$despues - r$antes == 12)
error <- tryCatch(a_ancho_seguro(rbind(d, d[1, ])), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Cambio individual: 12; duplicado rechazado antes de pivot_wider\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad11-formatos/solucion.R
```
