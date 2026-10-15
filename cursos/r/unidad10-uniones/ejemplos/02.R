# Buscar las claves sin correspondencia
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
d$grupo[1] <- "C"  # Escenario de auditoría, no pasa la validación del diccionario.
grupos <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
sin <- dplyr::anti_join(d, grupos, by = "grupo")
r <- dplyr::left_join(d, grupos, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(sin) == 1, sum(is.na(r$modalidad)) == 1, nrow(r) == 36)
cat("Sin correspondencia:", nrow(sin), "; left_join conserva las 36 filas
")
