# Faltante no equivale a cero
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(0, 10, NA_real_)
stopifnot(is.na(mean(x)), mean(x, na.rm = TRUE) == 5)
validos <- sum(!is.na(x))
cat("Registros:", length(x), "; observados:", validos, "; faltantes:", sum(is.na(x)), "
")
cat("Media observada:", mean(x, na.rm = TRUE), "
")
