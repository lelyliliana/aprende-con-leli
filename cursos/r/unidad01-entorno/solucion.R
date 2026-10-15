# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Versión y raíz son comprobaciones distintas.
stopifnot(getRversion() >= "4.3.0", file.exists("Curso-R.Rproj"))
version <- R.version.string
carpeta <- getwd()
stopifnot(nzchar(version), dir.exists(carpeta))
cat("Paso 1: R compatible y raíz del curso comprobados.\n")
# Paso 2. Ejecutar los archivos, no depender de cálculos anteriores.
source("unidad01-entorno/ejemplos/01.R", encoding = "UTF-8")
source("unidad01-entorno/ejemplos/02.R", encoding = "UTF-8")
cat("Paso 2: ejemplos 01 y 02 ejecutados.\n")
# Paso 3. Precedencia.
a <- 2 + 3 * 4
b <- (2 + 3) * 4
stopifnot(a == 14, b == 20)
cat("Paso 3: sin paréntesis=14; con paréntesis=20.\n")
# Reto. Escribir primero la expresión y después comparar.
minutos <- (1 + 0.5) * 60
stopifnot(minutos == 90)
cat("Reto: una hora y media equivale a 90 minutos.\n")
