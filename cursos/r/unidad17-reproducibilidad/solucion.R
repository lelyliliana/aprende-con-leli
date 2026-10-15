# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
a <- resumir_encuesta(leer_encuesta())
b <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, b), file.exists("proyecto/informe.qmd"), file.exists("_quarto.yml"))
cat("Fuentes, datos y cálculo identificados; renderizar Quarto ejecuta el informe aparte\n")
cat("Registrar versiones no equivale a congelarlas; la guía distingue ambos alcances.\n")
