# Soluciones razonadas de la Unidad 05

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Igualdad de medición no es duplicación

La consulta conserva A y B, ambas con valor 5. Sus IDs son distintos, por lo que representan dos personas bajo este diseño. Exigir valores únicos descartaría mediciones válidas y alteraría el tamaño y los resúmenes.

## Paso 2. Estructura explícita

d[, "valor", drop=FALSE] conserva una tabla 3×1; d[["valor"]] extrae el vector 5, 5, 8. El primero responde a operaciones de tabla, el segundo puede enviarse a mean. No deduzcas esa diferencia únicamente de cómo se ve la impresión.

## Paso 3. Contenedor y clave compuesta

[ conserva una lista y[[ extrae "A" como texto. En las cuatro mediciones, ID se repite legítimamente; ID/momento tiene cuatro combinaciones distintas. Esa combinación es la clave de una medición en este ejemplo, aunque todavía deben revisarse ausencias y dominio.

## Reto de transferencia. Repetición añadida

La quinta fila duplica A/1, por lo que anyDuplicated de las dos columnas devuelve 5. Si revisaras solo ID, detectarías una repetición esperada ya en la segunda fila y no distinguirías el error que acabas de introducir.

## Respuestas de autoevaluación

En d[filas, columnas], antes de la coma se seleccionan observaciones y después variables. [[ extrae el vector, mientras drop=FALSE conserva tabla. ID/momento es necesario cuando un ID admite varias mediciones previstas.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Dos valores iguales pueden pertenecer a personas distintas.
d <- data.frame(id = c("A", "B", "C"), valor = c(5, 5, 8))
r <- d[d$valor == 5, , drop = FALSE]
stopifnot(!anyDuplicated(d$id), nrow(r) == 2, identical(r$id, c("A", "B")))
cat("Paso 1: los IDs A y B comparten valor 5; ambos se conservan.\n")
# Paso 2. Forma explícita de tabla de una columna.
columna <- d[, "valor", drop = FALSE]
stopifnot(is.data.frame(columna), nrow(columna) == 3, ncol(columna) == 1)
cat("Paso 2: tabla de 3 filas y 1 columna.\n")
# Paso 3. Contenedor y contenido.
lista <- list(id = "A", valores = c(5, 8))
stopifnot(is.list(lista["id"]), identical(lista[["id"]], "A"))
mediciones <- data.frame(id = c("A", "A", "B", "B"), momento = c(1, 2, 1, 2))
stopifnot(anyDuplicated(mediciones$id) > 0, !anyDuplicated(mediciones[c("id", "momento")]))
cat("Paso 3: [ conserva lista; [[ extrae texto; la clave repetida es ID y momento.\n")
# Reto. Detectar repetición de una medición, no de una persona.
con_error <- rbind(mediciones, mediciones[1, ])
stopifnot(anyDuplicated(con_error[c("id", "momento")]) == 5L)
cat("Reto: la quinta fila repite la clave de la primera.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad05-tablas/solucion.R
```

Salida esperada:

```text
Paso 1: los IDs A y B comparten valor 5; ambos se conservan.
Paso 2: tabla de 3 filas y 1 columna.
Paso 3: [ conserva lista; [[ extrae texto; la clave repetida es ID y momento.
Reto: la quinta fila repite la clave de la primera.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2005%20%28Listas%20y%20tablas%20de%20datos%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
