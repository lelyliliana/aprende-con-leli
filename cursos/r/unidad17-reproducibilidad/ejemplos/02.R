# Repetir el cálculo conservando el resultado
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
a <- resumir_encuesta(leer_encuesta())
b <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, b), sum(a$n) == 36, sum(a$n_horas) == 33)
cat("Dos lecturas y cálculos independientes: mismo resumen; 36 registros, 33 horas observadas
")
