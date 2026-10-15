# Consultar un resultado sin objetos previos
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
puntajes <- c(7, 8, 9)
resultado <- mean(puntajes)
stopifnot(resultado == 8, length(puntajes) == 3)
cat("Datos:", paste(puntajes, collapse = ", "), "
")
cat("Media:", resultado, "
")
