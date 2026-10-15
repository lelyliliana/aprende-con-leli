# Soluciones de la Unidad 13

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

Con cinco valores, media=29.2, mediana=12, mínimo=10 y máximo=100. La media se desplaza por la magnitud de 100; la mediana depende de la posición ordenada. No debes borrar 100 solo para aproximar ambas medidas.

Investiga si la unidad, el origen y la variable permiten 100. La decisión de aceptación pertenece al dominio y al diseño, no a una preferencia por cierta apariencia del gráfico.

En satisfacción, 34 personas ficticias respondieron y hay dos faltantes. Proporciones entre respuestas usan 34; porcentajes sobre todos los registros usan 36 y deben describir la ausencia. Especifica qué conjunto estás comunicando.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
x <- c(10, 11, 12, 13, 100)
resumen <- c(n = length(x), media = mean(x), mediana = median(x), minimo = min(x), maximo = max(x))
stopifnot(resumen[["media"]] == 29.2, resumen[["mediana"]] == 12)
cat("n=5; media=29.2; mediana=12; mínimo=10; máximo=100\n")
cat("Antes de excluir 100, se revisan origen, unidad y criterio de aceptación.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad13-descriptiva/solucion.R
```
