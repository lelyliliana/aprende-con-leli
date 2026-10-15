# Datos y entorno identificables
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz(); comprobar_paquetes()
d <- leer_encuesta()
identidad <- tools::md5sum("datos/encuesta.csv")
stopifnot(nchar(unname(identidad)) == 32, nrow(d) == 36)
dir.create("salidas", showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "salidas/sesion.txt", useBytes = TRUE)
cat("Datos identificados por huella; sesión y versiones registradas
")
cat("El informe se renderiza desde el proyecto, no desde objetos de una consola anterior.
")
