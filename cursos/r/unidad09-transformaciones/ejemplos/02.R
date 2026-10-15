# Resumen y denominador explícito
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- resumir_encuesta(leer_encuesta())
stopifnot(identical(r$n, c(18L, 18L)), identical(r$n_horas, c(17L, 16L)))
stopifnot(!dplyr::is_grouped_df(r))
cat("Grupo A: n=18, horas observadas=17
Grupo B: n=18, horas observadas=16
")
