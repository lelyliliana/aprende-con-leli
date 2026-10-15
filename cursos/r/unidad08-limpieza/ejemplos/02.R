# Auditar sin reemplazar el original
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(is.na(r$validas$horas_semana[3]), r$original$horas_semana[2] == "7,5")
stopifnot(sum(!r$incidencias$aceptada) == 5)
cat("Vacío permitido sigue siendo NA; el original conserva 7,5
")
cat("Filas no aceptadas:", paste(r$incidencias$fila[!r$incidencias$aceptada], collapse = ", "), "
")
