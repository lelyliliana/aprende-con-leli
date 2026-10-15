# Soluciones de la Unidad 15

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El intervalo del primer ejemplo corresponde a una media bajo su modelo; no describe un rango para el 95% de individuos. p=1 aquí indica coincidencia del estadístico con el valor nulo, no una prueba de verdad o equivalencia.

Welch compara medias de grupos planteados como independientes y permite varianzas distintas. La diferencia del ejercicio es 4.2. La independencia, el diseño y las condiciones de la aproximación todavía deben justificarse.

La solución une las mediciones por ID con relación uno a uno. Las seis diferencias son 1,2,1,3,2,3 y su media es 2. El análisis pareado trabaja con esas diferencias. Invertir el orden del archivo no debe cambiar qué mediciones pertenecen a una misma persona. No generalices estos datos construidos a personas reales.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
antes <- data.frame(id = 1:6, puntaje = c(60, 65, 70, 75, 80, 85))
despues <- data.frame(id = 6:1, puntaje = rev(antes$puntaje + c(1, 2, 1, 3, 2, 3)))
pares <- dplyr::inner_join(antes, despues, by = "id", suffix = c("_antes", "_despues"), relationship = "one-to-one")
stopifnot(nrow(pares) == 6, !anyNA(pares))
cambios <- pares$puntaje_despues - pares$puntaje_antes
r <- t.test(pares$puntaje_despues, pares$puntaje_antes, paired = TRUE)
stopifnot(mean(cambios) == 2, abs(unname(r$estimate) - 2) < 1e-12)
cat("Seis pares unidos por ID; cambio medio=2; se analiza la diferencia dentro de cada persona\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad15-inferencia/solucion.R
```
