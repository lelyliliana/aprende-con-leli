# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Cada rechazo explica una parte del contrato.
validar_horas <- function(x) {
  if (!is.numeric(x)) stop("Se requiere número")
  if (length(x) != 1L) stop("Se requiere una cantidad")
  if (is.na(x)) stop("La cantidad no puede faltar")
  if (!is.finite(x)) stop("La cantidad debe ser finita")
  if (x < 0 || x > 40) stop("Fuera del intervalo 0 a 40")
  return(x)
}
stopifnot(validar_horas(12) == 12)
cat("Paso 1: validar devuelve una cantidad numérica admitida.\n")
# Paso 2. Casos válidos y cinco rechazos solicitados.
stopifnot(validar_horas(0) == 0, validar_horas(40) == 40)
for (entrada in list(-1, 41, NA_real_, "5", c(1, 2))) {
  error <- tryCatch(validar_horas(entrada), error = function(e) e)
  stopifnot(inherits(error, "error"))
}
cat("Paso 2: 0 y 40 aceptados; cinco entradas inválidas rechazadas.\n")
# Paso 3. Seguir suma y denominador por separado.
media_con_ciclo <- function(x) {
  suma <- 0
  n <- 0L
  for (valor in x) {
    if (!is.na(valor)) {
      suma <- suma + valor
      n <- n + 1L
    }
  }
  if (n == 0L) stop("No hay valores observados")
  return(suma / n)
}
x <- c(3, NA_real_, 5, 7)
stopifnot(media_con_ciclo(x) == 5, media_con_ciclo(x) == mean(x, na.rm = TRUE))
error <- tryCatch(media_con_ciclo(c(NA_real_, NA_real_)), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 3: suma=15; n=3; media=5; todo faltante rechazado.\n")
# Reto. Añadir la validación antes de convertir unidades.
minutos_validos <- function(horas) {
  horas <- validar_horas(horas)
  return(horas * 60)
}
stopifnot(minutos_validos(1.5) == 90)
error <- tryCatch(minutos_validos(Inf), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Reto: conversión válida=90 minutos; infinito rechazado.\n")
