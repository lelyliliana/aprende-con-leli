# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(nrow(r$validas) == 3, identical(r$validas$id, c("S01", "S02", "S05")))
archivo <- tempfile(fileext = ".csv")
contradiccion <- r$original
contradiccion$puntaje[3] <- "81"
write.csv(contradiccion, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(limpiar_entrada(archivo), error = function(e) e)
stopifnot(inherits(error, "error"))
unlink(archivo)
cat("Duplicado equivalente resuelto según política; duplicado contradictorio rechazado\n")
