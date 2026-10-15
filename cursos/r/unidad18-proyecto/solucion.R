# Solución ejecutable. Intentar primero la práctica.
source("proyecto/analizar.R", encoding = "UTF-8")
carpeta <- tempfile("proyecto-")
dir.create(carpeta)
d <- leer_encuesta(); d$puntaje[1] <- -1
entrada <- file.path(carpeta, "invalida.csv")
salida <- file.path(carpeta, "salida")
write.csv(d, entrada, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(ejecutar_analisis(entrada, salida), error = function(e) e)
stopifnot(inherits(error, "error"), !dir.exists(salida))
unlink(carpeta, recursive = TRUE)
cat("Entrada fuera del diccionario rechazada antes de crear resultados\n")
