# Solución ejecutable. Intentar primero la práctica.
validar_horas <- function(x) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || !is.finite(x) || x < 0 || x > 40) stop("Una cantidad de horas entre 0 y 40")
  x
}
stopifnot(validar_horas(0) == 0, validar_horas(40) == 40)
for (entrada in list(-1, 41, NA_real_, "5", c(1, 2))) {
  r <- tryCatch(validar_horas(entrada), error = function(e) e)
  stopifnot(inherits(r, "error"))
}
cat("Límites 0 y 40 aceptados; cinco entradas inválidas rechazadas\n")
