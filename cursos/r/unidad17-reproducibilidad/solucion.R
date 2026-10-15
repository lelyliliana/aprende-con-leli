# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
# Paso 1. Registrar procedencia y versiones; no confundirlas con validez.
d <- leer_encuesta()
huella <- unname(tools::md5sum("datos/encuesta.csv"))
dir.create("salidas", showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "salidas/practica-sesion.txt", useBytes = TRUE)
stopifnot(nchar(huella) == 32, file.exists("salidas/practica-sesion.txt"))
cat("Paso 1: huella de datos y sesión registradas; no prueban validez científica.\n")
# Paso 2. Comprobar las fuentes y las cifras que debe mostrar el informe.
stopifnot(file.exists("proyecto/informe.qmd"), file.exists("_quarto.yml"))
stopifnot(nrow(d) == 36, sum(is.na(d$horas_semana)) == 3)
cat("Paso 2: fuentes presentes; el informe debe mostrar 36 registros y 3 horas faltantes.\n")
cat("El renderizado real de Quarto se ejecuta con verificar.R --quarto.\n")
# Paso 3. Escribir y leer una copia temporal antes de comparar.
copia <- d
copia$puntaje[1] <- copia$puntaje[1] + 1
archivo <- tempfile(fileext = ".csv")
write.csv(copia, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
modificada <- leer_encuesta(archivo)
a <- resumir_encuesta(d)
b <- resumir_encuesta(modificada)
g <- d$grupo[1]
stopifnot(abs(b$media_puntaje[b$grupo == g] - a$media_puntaje[a$grupo == g] - 1 / 18) < 1e-10)
stopifnot(huella == unname(tools::md5sum("datos/encuesta.csv")), huella != unname(tools::md5sum(archivo)))
unlink(archivo)
cat("Paso 3: copia válida cambia la media en 1/18; original y su huella intactos.\n")
# Reto. Repetir la lectura y no depender de un objeto modificado.
otra <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, otra))
cat("Reto: releer el original recupera el mismo resumen; registrar versiones no las bloquea.\n")
