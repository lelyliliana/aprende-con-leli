# Soluciones de la Unidad 10

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El catálogo válido tiene A y B una vez. La unión muchos a uno conserva 36 registros, su identidad y una modalidad por grupo. La solución comprueba la unicidad del catálogo y declara relationship.

Duplicar A permite varias coincidencias para sus participantes y se rechaza en la relación prevista. No se resuelve escogiendo arbitrariamente una modalidad sin evidencia.

Con una clave C, anti_join devuelve una fila. left_join conserva las 36 y añade un NA en modalidad. inner_join puede dejar solo 35; esa reducción no equivale a corregir el registro. El diccionario y la auditoría determinan si la clave debe corregirse o si el catálogo necesita una ampliación válida.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
catalogo <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
stopifnot(!anyDuplicated(catalogo$grupo))
r <- dplyr::left_join(d, catalogo, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(r) == 36, identical(r$id, d$id), !anyNA(r$modalidad))
cat("Una modalidad por grupo; orden de registros e identidad conservados\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad10-uniones/solucion.R
```
