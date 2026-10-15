# Asignación y unidades
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
horas <- 2.5
minutos <- horas * 60
etiqueta <- "Tiempo de estudio"
stopifnot(minutos == 150, is.character(etiqueta))
cat(etiqueta, ": ", minutos, " minutos
", sep = "")
