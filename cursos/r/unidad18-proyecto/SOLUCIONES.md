# Soluciones razonadas de la Unidad 18

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Productos conectados con la pregunta

La construcción añade lectura, resumen, figura y escritura en etapas. El resumen final tiene 2 grupos, 36 registros y 33 horas observadas. El JSON marca datos ficticios y 36 filas. La figura requiere revisión visual y sesion.txt permite consultar el entorno. El script lee productos tabulares y JSON; no sustituye esa lectura visual.

## Paso 2. Rechazo observable

El puntaje-1 incumple el dominio y se rechaza al leer antes de crear la carpeta nueva. La prueba confirma un error y que esa carpeta sigue sin existir. No modifica el origen. Una carpeta preexistente no serviría para demostrar que no se creó, por eso la prueba usa una nueva.

## Paso 3. Rúbrica y otro contrato

Debes aportar pregunta/diccionario, calidad, resúmenes, figura/interpretación y reproducción, cada criterio con producto y justificación. No hay una nota automática universal para tu redacción. En ambiental la clave estación/fecha distingue 12 registros; 11 tienen conteo conocido. La solución calcula resúmenes por estación; el HTML y la autoevaluación se completan mediante la guía escrita.

## Reto de transferencia. Alcances distintos

Hay 1 conteo faltante. Total observado suma mediciones disponibles, no una población definida bajo un diseño de abundancia. Faltan, entre otros, esfuerzo y detección. El programa valida antes de escribir, pero usa escritura directa; un corte durante la entrega podría dejar productos parciales. Son límites que deben explicarse sin ocultarlos ni reclamar garantías adicionales.

## Respuestas de autoevaluación

Cada producto permite revisar una parte del análisis. El rechazo previo protege el contrato de entrada, pero no garantiza escritura transaccional. La transferencia necesita redefinir unidad, clave, dominios y pregunta. Cada criterio de la rúbrica requiere evidencia reconstruible y una explicación de decisiones.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
source("proyecto/analizar.R", encoding = "UTF-8")
# Paso 1. Ejecutar y revisar el contenido de los productos.
salida <- "salidas/practica-final"
r <- ejecutar_analisis("datos/encuesta.csv", salida)
archivos <- c("resumen.csv", "puntajes.svg", "registro.json", "sesion.txt")
stopifnot(all(file.exists(file.path(salida, archivos))))
csv <- read.csv(file.path(salida, "resumen.csv"))
registro <- jsonlite::read_json(file.path(salida, "registro.json"), simplifyVector = TRUE)
stopifnot(nrow(csv) == 2, sum(csv$n) == 36, sum(csv$n_horas) == 33, registro$filas == 36)
cat("Paso 1: productos leídos; 2 grupos, 36 registros y 33 horas observadas.\n")
# Paso 2. Rechazo previo sin crear una carpeta de resultados.
carpeta <- tempfile("practica-r-")
dir.create(carpeta)
d <- leer_encuesta()
d$puntaje[1] <- -1
entrada <- file.path(carpeta, "invalida.csv")
salida_invalida <- file.path(carpeta, "rechazada")
write.csv(d, entrada, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(ejecutar_analisis(entrada, salida_invalida), error = function(e) e)
stopifnot(inherits(error, "error"), !dir.exists(salida_invalida))
unlink(carpeta, recursive = TRUE)
cat("Paso 2: puntaje negativo rechazado antes de crear la salida.\n")
# Paso 3. Transferencia con otra unidad de observación.
ambiental <- read.csv("datos/ambiental.csv", na.strings = "", fileEncoding = "UTF-8")
ambiental$fecha <- as.Date(ambiental$fecha)
stopifnot(!anyDuplicated(ambiental[c("estacion", "fecha")]))
resumen <- ambiental |> dplyr::group_by(estacion) |>
  dplyr::summarise(registros = dplyr::n(), observados = sum(!is.na(conteo)),
    total_observado = sum(conteo, na.rm = TRUE), .groups = "drop")
stopifnot(sum(resumen$registros) == 12, sum(resumen$observados) == 11)
cat("Paso 3: unidad estación-fecha; 12 registros y 11 conteos observados.\n")
cat("Renderizado y rúbrica requieren además revisar el HTML y justificar decisiones.\n")
# Reto. Completar conteos para cada estación sin inventar el dato faltante.
resumen$faltantes <- resumen$registros - resumen$observados
stopifnot(sum(resumen$faltantes) == 1, identical(r$datos, leer_encuesta()))
cat("Reto: 1 conteo faltante declarado; total observado no equivale a abundancia poblacional.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad18-proyecto/solucion.R
```

Salida esperada:

```text
Paso 1: productos leídos; 2 grupos, 36 registros y 33 horas observadas.
Paso 2: puntaje negativo rechazado antes de crear la salida.
Paso 3: unidad estación-fecha; 12 registros y 11 conteos observados.
Renderizado y rúbrica requieren además revisar el HTML y justificar decisiones.
Reto: 1 conteo faltante declarado; total observado no equivale a abundancia poblacional.
```

El archivo R comprueba cálculos y archivos. Los pasos que requieren renderizar con Quarto o valorar una interpretación se completan además siguiendo la explicación escrita; no se sustituyen por ejecutar este archivo.

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2018%20%28Proyecto%20integrador%20y%20transferencia%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
