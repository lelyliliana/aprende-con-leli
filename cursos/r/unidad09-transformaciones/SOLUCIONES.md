# Soluciones razonadas de la Unidad 09

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Filas seleccionadas

filter conserva registros cuyo puntaje alcanza 80 y arrange ordena por ID. Se comprueba la condición en la salida y se conserva d con 36 filas. Usar otro nombre evita confundir el subconjunto analizado con la tabla original.

## Paso 2. Comparación por identidad

La selección base d[d$puntaje>=80, , drop=FALSE], ordenada por ID, debe devolver los mismos IDs que dplyr. El diccionario exige puntaje conocido, por lo que aquí no hay máscaras NA en esa columna. La comparación detectaría, por ejemplo, usar >80 en una implementación y>=80 en otra.

## Paso 3. Denominadores y caso vacío

Los grupos tienen 18 filas cada uno y 17/16 horas conocidas. La copia sin horas de A conserva 18 filas pero n_horas=0 y media_horas=NA explícito. No se presenta NaN ni 0 como media. .groups="drop" evita que otra operación herede agrupación y se comprueba is_grouped_df.

## Reto de transferencia. Otra variable, las mismas unidades observadas

mutate añade minutos=horas*60 y conserva 36 filas. Tres minutos quedan NA porque tres horas eran desconocidas. La igualdad se comprueba en las posiciones conocidas; na.rm en esa comprobación no equivale a imputar los faltantes del análisis.

## Respuestas de autoevaluación

mutate crea columnas conservando filas; summarise cambia a un resumen por grupo. X tiene dos filas pero una cantidad conocida. NA con n_horas=0 comunica que no se calculó una media con observaciones disponibles.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
# Paso 1. Filtrar no significa sobrescribir el original.
a <- d |> dplyr::filter(puntaje >= 80) |> dplyr::arrange(id)
stopifnot(all(a$puntaje >= 80), nrow(d) == 36, !anyDuplicated(a$id))
cat("Paso 1: filtro de puntajes aplicado; el original conserva 36 filas.\n")
# Paso 2. Implementación independiente y orden comparable.
b <- d[d$puntaje >= 80, , drop = FALSE]
b <- b[order(b$id), , drop = FALSE]
stopifnot(identical(a$id, b$id))
cat("Paso 2: los mismos IDs con dplyr y R base.\n")
# Paso 3. Mostrar el denominador y comprobar el grupo sin observaciones.
resumen <- resumir_encuesta(d)
stopifnot(identical(resumen$n, c(18L, 18L)), identical(resumen$n_horas, c(17L, 16L)))
sin_horas_a <- d
sin_horas_a$horas_semana[sin_horas_a$grupo == "A"] <- NA_real_
r <- resumir_encuesta(sin_horas_a)
stopifnot(r$n_horas[r$grupo == "A"] == 0L, is.na(r$media_horas[r$grupo == "A"]))
stopifnot(!is.nan(r$media_horas[r$grupo == "A"]), !dplyr::is_grouped_df(r))
cat("Paso 3: n=18/18; n_horas=17/16; un grupo sin horas devuelve NA y n_horas=0.\n")
# Reto. Mutate conserva filas y transforma la unidad.
con_minutos <- d |> dplyr::mutate(minutos_semana = horas_semana * 60)
stopifnot(nrow(con_minutos) == 36, sum(is.na(con_minutos$minutos_semana)) == 3)
stopifnot(all(con_minutos$minutos_semana == con_minutos$horas_semana * 60, na.rm = TRUE))
cat("Reto: minutos calculados, 36 filas y 3 faltantes conservados.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad09-transformaciones/solucion.R
```

Salida esperada:

```text
Paso 1: filtro de puntajes aplicado; el original conserva 36 filas.
Paso 2: los mismos IDs con dplyr y R base.
Paso 3: n=18/18; n_horas=17/16; un grupo sin horas devuelve NA y n_horas=0.
Reto: minutos calculados, 36 filas y 3 faltantes conservados.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2009%20%28Transformar%20y%20resumir%20con%20dplyr%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
