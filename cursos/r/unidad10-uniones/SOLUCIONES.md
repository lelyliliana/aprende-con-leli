# Soluciones razonadas de la Unidad 10

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Contrato muchos a uno

El catálogo tiene una sola fila por grupo. La encuesta contiene varias personas por grupo y left_join permite que compartan modalidad. La salida conserva 36 personas. Se declara by="grupo" y relationship="many-to-one" para expresar la correspondencia esperada.

## Paso 2. Integridad después de unir

nrow debe seguir en 36, los IDs deben coincidir con la entrada y no deben faltar modalidades en este archivo. Al repetir A en el catálogo, una persona de A encontraría más de una fila y la relación rechaza la unión. No se corrige escogiendo una modalidad arbitraria.

## Paso 3. Tres preguntas diferentes

anti_join devuelve la fila de C. inner_join conserva 35 y deja fuera esa persona; left_join conserva 36 y deja una modalidad NA. La unión izquierda sigue cumpliendo muchos a uno, porque cero coincidencias no significa múltiples coincidencias. La cobertura necesita su propia auditoría.

## Reto de transferencia. Independencia de posición

Invertir el catálogo debe conservar la asociación ID/modalidad de la salida. La solución contrasta ambas columnas. Esta comprobación aporta evidencia contra una relación por posición, pero no sustituye revisar que las etiquetas del catálogo tengan el significado correcto.

## Respuestas de autoevaluación

left conserva toda la izquierda; inner conserva coincidencias. Muchas personas con una única modalidad de catálogo por grupo cumplen muchos a uno. relationship no exige cobertura completa de todas las claves.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
catalogo <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
# Paso 1. Catálogo único por grupo.
stopifnot(!anyNA(catalogo$grupo), !anyDuplicated(catalogo$grupo))
r <- dplyr::left_join(d, catalogo, by = "grupo", relationship = "many-to-one")
cat("Paso 1: catálogo con clave única; unión muchos a uno.\n")
# Paso 2. Conservar identidad y rechazar multiplicación de filas.
stopifnot(nrow(r) == nrow(d), identical(r$id, d$id), !anyNA(r$modalidad))
duplicado <- rbind(catalogo, catalogo[1, ])
error <- tryCatch(dplyr::left_join(d, duplicado, by = "grupo", relationship = "many-to-one"), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 2: 36 filas e IDs conservados; catálogo duplicado rechazado.\n")
# Paso 3. Auditar el escenario inválido sin aceptarlo como encuesta válida.
con_c <- d
con_c$grupo[1] <- "C"
sin <- dplyr::anti_join(con_c, catalogo, by = "grupo")
interna <- dplyr::inner_join(con_c, catalogo, by = "grupo", relationship = "many-to-one")
izquierda <- dplyr::left_join(con_c, catalogo, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(sin) == 1, sin$id == d$id[1], nrow(interna) == 35, nrow(izquierda) == 36)
stopifnot(sum(is.na(izquierda$modalidad)) == 1)
cat("Paso 3: anti_join identifica 1 fila; inner conserva 35 y left conserva 36.\n")
# Reto. El orden del catálogo no debe decidir la correspondencia.
invertido <- dplyr::left_join(d, catalogo[2:1, ], by = "grupo", relationship = "many-to-one")
stopifnot(identical(invertido$id, r$id), identical(invertido$modalidad, r$modalidad))
cat("Reto: invertir el catálogo conserva modalidades e identidad.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad10-uniones/solucion.R
```

Salida esperada:

```text
Paso 1: catálogo con clave única; unión muchos a uno.
Paso 2: 36 filas e IDs conservados; catálogo duplicado rechazado.
Paso 3: anti_join identifica 1 fila; inner conserva 35 y left conserva 36.
Reto: invertir el catálogo conserva modalidades e identidad.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2010%20%28Unir%20tablas%20sin%20perder%20el%20control%20de%20las%20filas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
