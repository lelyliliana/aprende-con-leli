# Seleccionar sin cambiar el original
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(4, 7, 10)
seleccion <- x[x > 5]
stopifnot(identical(seleccion, c(7, 10)), length(x[0]) == 0, is.na(x[4]))
cat("Mayores que 5:", paste(seleccion, collapse = ", "), "
")
cat("Índice 0: longitud", length(x[0]), "; índice 4: NA
")
