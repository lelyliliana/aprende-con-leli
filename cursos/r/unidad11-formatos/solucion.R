# Solución ejecutable. Intentar primero la práctica.
a_ancho_seguro <- function(d) {
  if (anyDuplicated(d[c("id", "momento")])) stop("Clave id-momento duplicada")
  tidyr::pivot_wider(d, names_from = momento, values_from = puntaje)
}
d <- data.frame(id = c("A", "A"), momento = c("antes", "despues"), puntaje = c(60, 72))
r <- a_ancho_seguro(d)
stopifnot(r$despues - r$antes == 12)
error <- tryCatch(a_ancho_seguro(rbind(d, d[1, ])), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Cambio individual: 12; duplicado rechazado antes de pivot_wider\n")
