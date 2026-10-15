# Solución ejecutable. Intentar primero la práctica.
archivo <- tempfile(fileext = ".csv")
writeLines(c("valor", "3", "texto"), archivo)
r <- suppressWarnings(readr::read_csv(archivo, col_types = readr::cols(valor = readr::col_double())))
problemas <- readr::problems(r)
stopifnot(nrow(problemas) == 1, is.na(r$valor[2]))
unlink(archivo)
cat("Conversión fallida detectada: una incidencia; NA no se acepta sin revisión\n")
