# Separar aceptados e incidencias
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(nrow(r$original) == 8, nrow(r$validas) == 3)
stopifnot(sum(r$incidencias$duplicada) == 1, sum(r$incidencias$invalida) == 4)
stopifnot(identical(r$validas$id, c("S01", "S02", "S05")), r$validas$horas_semana[2] == 7.5)
cat("Originales: 8; aceptados: 3; duplicados: 1; inválidos: 4
")
