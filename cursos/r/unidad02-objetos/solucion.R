# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. La entrada se expresa en horas; la salida, en minutos.
horas <- 1.75
minutos <- horas * 60
stopifnot(minutos == 105)
cat("Paso 1: 1.75 horas = 105 minutos.\n")
# Paso 2. Conservar el identificador y convertir solo una copia.
codigo <- "007"
numero <- as.numeric(codigo)
stopifnot(identical(codigo, "007"), numero == 7, nchar(codigo) == 3)
cat("Paso 2: texto 007 conservado; copia numérica=7.\n")
# Paso 3. Igualdad de valor e identidad de tipo.
entero <- 3L
real <- 3
stopifnot(entero == real, !identical(entero, real))
cat("Paso 3:", typeof(entero), "y", typeof(real), "; igual valor, tipos distintos.\n")
# Reto. Un cambio no recalcula las asignaciones anteriores.
horas <- 2
minutos <- horas * 60
horas <- 4
stopifnot(minutos == 120)
minutos <- horas * 60
stopifnot(minutos == 240)
cat("Reto: antes de recalcular=120; después=240 minutos.\n")
