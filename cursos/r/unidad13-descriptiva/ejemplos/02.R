# Proporciones con denominador conocido
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
frecuencias <- table(d$satisfaccion, useNA = "ifany")
observadas <- table(d$satisfaccion, useNA = "no")
stopifnot(sum(frecuencias) == 36, sum(observadas) == 34)
p <- prop.table(observadas)
stopifnot(abs(sum(p) - 1) < 1e-12)
cat("Total: 36; satisfacción observada: 34; faltantes: 2
")
cat("Las proporciones de respuestas usan denominador 34, no 36.
")
