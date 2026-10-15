# Soluciones razonadas de la Unidad 11

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. De columnas a valores

La tabla larga tiene id, momento, puntaje. A aparece con antes 60 y despues 72; B con antes 70 y despues 75. Su clave es ID/momento. Los nombres de las columnas medidas pasan a valores de momento, mientras sus números se reúnen en puntaje.

## Paso 2. Dos denominadores

Hay 4 mediciones y 2 personas. Las cuatro combinaciones son distintas. Dos mediciones de A siguen perteneciendo a A y pueden estar relacionadas; una transformación de formato no establece independencia estadística.

## Paso 3. Una cantidad por celda de salida

El validador revisa claves conocidas y no repetidas. Solo entonces pivot_wider puede colocar un puntaje por ID/momento. Los cambios despues-antes son 12 para A y 5 para B. Una copia de A/antes produce un rechazo anterior al pivote, no una agregación automática.

## Reto de transferencia. Contenido frente a orden

La tabla ancha invertida puede listar primero B. Al ordenar por ID se recuperan A, B y los mismos cambios 12, 5. Comparar solo los vectores sin IDs y sin ordenar podría señalar diferencias de orden como si fueran diferencias de medición.

## Respuestas de autoevaluación

names_to guarda los nombres de las columnas convertidas y values_to los valores medidos. Dos personas por dos momentos producen cuatro filas. Dos puntajes para A/antes requieren resolver la identidad o la contradicción antes de decidir una agregación.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Declarar exactamente qué columnas son momentos.
ancha <- data.frame(id = c("A", "B"), antes = c(60, 70), despues = c(72, 75))
larga <- tidyr::pivot_longer(ancha, cols = c(antes, despues), names_to = "momento", values_to = "puntaje")
stopifnot(identical(names(larga), c("id", "momento", "puntaje")))
cat("Paso 1: clave de una fila larga=ID y momento.\n")
# Paso 2. No confundir mediciones con personas.
stopifnot(nrow(larga) == 4, length(unique(larga$id)) == 2)
stopifnot(nrow(unique(larga[c("id", "momento")])) == 4)
cat("Paso 2: 4 mediciones, 2 personas y 4 claves distintas.\n")
# Paso 3. Rechazar la ambigüedad antes de construir columnas.
a_ancho_seguro <- function(d) {
  if (anyNA(d$id) || anyNA(d$momento)) stop("Clave ausente")
  if (anyDuplicated(d[c("id", "momento")])) stop("Clave ID-momento duplicada")
  tidyr::pivot_wider(d, names_from = momento, values_from = puntaje)
}
vuelta <- a_ancho_seguro(larga)
cambios <- vuelta$despues - vuelta$antes
stopifnot(identical(cambios, c(12, 5)))
error <- tryCatch(a_ancho_seguro(rbind(larga, larga[1, ])), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 3: cambios A=12 y B=5; duplicado rechazado.\n")
# Reto. El orden puede variar; la clave y los valores deben conservarse.
invertida <- a_ancho_seguro(larga[4:1, ])
invertida <- invertida[order(invertida$id), ]
stopifnot(identical(invertida$id, vuelta$id), identical(invertida$despues - invertida$antes, cambios))
cat("Reto: invertir filas no altera los cambios después de ordenar por ID.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad11-formatos/solucion.R
```

Salida esperada:

```text
Paso 1: clave de una fila larga=ID y momento.
Paso 2: 4 mediciones, 2 personas y 4 claves distintas.
Paso 3: cambios A=12 y B=5; duplicado rechazado.
Reto: invertir filas no altera los cambios después de ordenar por ID.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2011%20%28Datos%20largos%2C%20anchos%20y%20unidad%20de%20observaci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
