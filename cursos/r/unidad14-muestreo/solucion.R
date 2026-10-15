# Solución ejecutable. Intentar primero la práctica.
unidades <- 1:10
set.seed(7)
muestra <- sample(unidades, 30, replace = TRUE)
stopifnot(length(muestra) == 30, anyDuplicated(muestra) > 0)
error <- tryCatch(sample(unidades, 30, replace = FALSE), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Con reemplazo: 30 selecciones de 10 unidades; repeticiones inevitables\n")
cat("Sin reemplazo no se pueden seleccionar 30 unidades de solo 10.\n")
