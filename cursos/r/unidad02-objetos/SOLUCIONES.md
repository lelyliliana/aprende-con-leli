# Soluciones de la Unidad 02

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

1.75 horas equivalen a 105 minutos. La multiplicación cambia la unidad de interpretación; el nombre del objeto debe ayudar a reconocerla.

"007" conserva tres caracteres; as.numeric devuelve 7. Si el campo es un identificador, mantenerlo como texto preserva la representación. No toda cadena numérica es una magnitud.

3L y 3 tienen igual valor numérico para ==; identical considera además el tipo. typeof devuelve integer y double. El resultado no implica que uno sea un error: depende de qué exige el contrato del análisis.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
horas <- 1.75
minutos <- horas * 60
codigo <- "007"
stopifnot(minutos == 105, nchar(codigo) == 3, as.numeric(codigo) == 7)
cat("Minutos:", minutos, "; código conservado como texto:", codigo, "\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad02-objetos/solucion.R
```
