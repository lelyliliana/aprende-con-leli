# Soluciones razonadas de la Unidad 06

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Precondiciones antes de operar

La solución revisa is.numeric, length==1, ausencia, finitud y rango en ese orden. Un vector vacío falla longitud antes de producir una condición vacía; texto falla tipo antes de comparaciones de rango. La salida es el valor admitido. El contrato es de una cantidad, no de una columna entera.

## Paso 2. Razones de cada rechazo

0 y 40 están dentro del intervalo cerrado. -1 y 41 incumplen rango; NA incumple conocimiento del valor; "5" incumple tipo; c(1, 2) incumple escalaridad. tryCatch conserva la condición de error para comprobar inherits. No sustituye el error por una cantidad válida.

## Paso 3. Dos estados del acumulador

Después de 3: suma 3, n=1. Después deNA: suma 3, n=1. Después de 5: suma 8, n=2. Después de 7: suma 15, n=3. La media es 5 y coincide con mean(x, na.rm=TRUE). Con todo faltante se rechaza antes de dividir 0/0. Esta función docente supone un vector numérico apropiado; no es un validador universal.

## Reto de transferencia. Componer funciones

minutos_validos recibe horas, pasa esa entrada al validador y multiplica el resultado admitido por 60. Para 1.5 devuelve 90. Inf se rechaza por finitud y no llega a convertirse. Así una misma regla se reutiliza y su modificación no obliga a copiar validaciones en varias funciones.

## Respuestas de autoevaluación

Parámetro es el nombre de la entrada en la definición; argumento es el valor de la llamada. Definir guarda el procedimiento y llamar lo ejecuta. La media necesita contar cantidades además de sumarlas. Revisar tipo y longitud antes de contenido evita condiciones inválidas para if.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Cada rechazo explica una parte del contrato.
validar_horas <- function(x) {
  if (!is.numeric(x)) stop("Se requiere número")
  if (length(x) != 1L) stop("Se requiere una cantidad")
  if (is.na(x)) stop("La cantidad no puede faltar")
  if (!is.finite(x)) stop("La cantidad debe ser finita")
  if (x < 0 || x > 40) stop("Fuera del intervalo 0 a 40")
  return(x)
}
stopifnot(validar_horas(12) == 12)
cat("Paso 1: validar devuelve una cantidad numérica admitida.\n")
# Paso 2. Casos válidos y cinco rechazos solicitados.
stopifnot(validar_horas(0) == 0, validar_horas(40) == 40)
for (entrada in list(-1, 41, NA_real_, "5", c(1, 2))) {
  error <- tryCatch(validar_horas(entrada), error = function(e) e)
  stopifnot(inherits(error, "error"))
}
cat("Paso 2: 0 y 40 aceptados; cinco entradas inválidas rechazadas.\n")
# Paso 3. Seguir suma y denominador por separado.
media_con_ciclo <- function(x) {
  suma <- 0
  n <- 0L
  for (valor in x) {
    if (!is.na(valor)) {
      suma <- suma + valor
      n <- n + 1L
    }
  }
  if (n == 0L) stop("No hay valores observados")
  return(suma / n)
}
x <- c(3, NA_real_, 5, 7)
stopifnot(media_con_ciclo(x) == 5, media_con_ciclo(x) == mean(x, na.rm = TRUE))
error <- tryCatch(media_con_ciclo(c(NA_real_, NA_real_)), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 3: suma=15; n=3; media=5; todo faltante rechazado.\n")
# Reto. Añadir la validación antes de convertir unidades.
minutos_validos <- function(horas) {
  horas <- validar_horas(horas)
  return(horas * 60)
}
stopifnot(minutos_validos(1.5) == 90)
error <- tryCatch(minutos_validos(Inf), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Reto: conversión válida=90 minutos; infinito rechazado.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad06-funciones/solucion.R
```

Salida esperada:

```text
Paso 1: validar devuelve una cantidad numérica admitida.
Paso 2: 0 y 40 aceptados; cinco entradas inválidas rechazadas.
Paso 3: suma=15; n=3; media=5; todo faltante rechazado.
Reto: conversión válida=90 minutos; infinito rechazado.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2006%20%28Funciones%2C%20decisiones%20y%20repetici%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
