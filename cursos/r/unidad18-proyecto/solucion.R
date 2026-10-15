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
