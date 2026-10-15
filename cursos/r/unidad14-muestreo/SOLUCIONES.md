# Soluciones razonadas de la Unidad 14

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Una secuencia controlada

Las dos muestras con la misma semilla y operaciones coinciden. Cambiar semilla inicia otro estado del generador; no garantiza una mejor muestra ni que cualquier resumen necesariamente cambie. La reproducibilidad se interpreta con versión y configuración del entorno.

## Paso 2. Variabilidad del procedimiento

medias contiene 500 números, uno por cada muestra de 50. En la simulación su desviación es menor que la de los valores de población. La primera mide variación entre estimaciones bajo ese mecanismo; la segunda variación entre unidades. No son denominadores intercambiables para cualquier análisis.

## Paso 3. Reemplazo y disponibilidad

Con reemplazo hay 30 extracciones y algún ID necesariamente se repite. Sin reemplazo el tamaño pedido excede los 10 IDs y se rechaza. En una población con cantidades iguales, dos valores repetidos podrían corresponder a IDs distintos; se sigue identidad, no solo igualdad numérica.

## Reto de transferencia. Mecanismo sesgado

Las primeras 100 posiciones son ceros y su media 0. La población artificial tiene media 4.5. La selección excluyó todos los demás valores por su ubicación ordenada. Una semilla no modifica esa regla determinista ni la vuelve representativa.

## Respuestas de autoevaluación

Con replace=TRUE se permite volver a extraer un ID. Valores iguales pueden pertenecer a unidades distintas. La semilla controla el estado del generador, no el diseño de recolección. Cada elemento de medias es una estimación de una repetición.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Repetir requiere restablecer la semilla antes de la misma operación.
poblacion <- rep(0:9, each = 100)
set.seed(20261015)
a <- sample(poblacion, 50, replace = FALSE)
set.seed(20261015)
b <- sample(poblacion, 50, replace = FALSE)
set.seed(20261016)
copia_otra_semilla <- sample(poblacion, 50, replace = FALSE)
stopifnot(identical(a, b), length(copia_otra_semilla) == 50)
cat("Paso 1: misma semilla reproduce la muestra; otra semilla inicia otra secuencia.\n")
# Paso 2. Guardar una media por muestra.
set.seed(23)
medias <- replicate(500, mean(sample(poblacion, 50, replace = FALSE)))
stopifnot(length(medias) == 500, sd(medias) < sd(poblacion))
cat("Paso 2: 500 medias; su dispersión es menor en esta simulación.\n")
# Paso 3. Imposibilidad de obtener 30 IDs distintos de solo 10.
unidades <- 1:10
set.seed(7)
muestra <- sample(unidades, 30, replace = TRUE)
error <- tryCatch(sample(unidades, 30, replace = FALSE), error = function(e) e)
stopifnot(length(muestra) == 30, anyDuplicated(muestra) > 0, inherits(error, "error"))
cat("Paso 3: con reemplazo se repiten IDs; sin reemplazo la petición es imposible.\n")
# Reto. La media de las primeras 100 unidades muestra un mecanismo sesgado.
sesgada <- poblacion[1:100]
stopifnot(mean(sesgada) == 0, mean(poblacion) == 4.5)
cat("Reto: primeras 100 unidades, media=0; población artificial, media=4.5.\n")
cat("Una semilla no corrige un mecanismo de selección sesgado.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad14-muestreo/solucion.R
```

Salida esperada:

```text
Paso 1: misma semilla reproduce la muestra; otra semilla inicia otra secuencia.
Paso 2: 500 medias; su dispersión es menor en esta simulación.
Paso 3: con reemplazo se repiten IDs; sin reemplazo la petición es imposible.
Reto: primeras 100 unidades, media=0; población artificial, media=4.5.
Una semilla no corrige un mecanismo de selección sesgado.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2014%20%28Muestreo%2C%20simulaci%C3%B3n%20y%20variabilidad%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
