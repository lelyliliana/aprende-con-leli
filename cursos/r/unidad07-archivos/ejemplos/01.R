# CSV con tipos y faltantes declarados
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
stopifnot(nrow(d) == 36, sum(is.na(d$horas_semana)) == 3)
carpeta <- tempfile("csv-")
dir.create(carpeta)
archivo <- file.path(carpeta, "copia.csv")
write.csv(d, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
copia <- leer_encuesta(archivo)
stopifnot(isTRUE(all.equal(d, copia)))
unlink(carpeta, recursive = TRUE)
cat("CSV: 36 filas, 3 faltantes en horas; ida y vuelta conservada
")
