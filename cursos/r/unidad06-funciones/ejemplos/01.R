# Una función con contrato
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
media_observada <- function(x) {
  if (!is.numeric(x)) stop("Se requiere un vector numérico")
  observados <- x[!is.na(x)]
  if (!length(observados)) stop("No hay valores observados")
  mean(observados)
}
stopifnot(media_observada(c(0, 10, NA_real_)) == 5)
fallo <- tryCatch(media_observada(c(NA_real_)), error = function(e) e)
stopifnot(inherits(fallo, "error"))
cat("Media:", media_observada(c(0, 10, NA_real_)), "; entrada sin datos rechazada
")
