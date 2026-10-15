# Una unión muchos a uno comprobada
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
grupos <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
r <- dplyr::left_join(d, grupos, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(r) == nrow(d), !anyNA(r$modalidad), !anyDuplicated(r$id))
fallo <- tryCatch(dplyr::left_join(d, rbind(grupos, grupos[1, ]), by = "grupo", relationship = "many-to-one"), error = function(e) e)
stopifnot(inherits(fallo, "error"))
cat("Unión: 36 filas; clave de catálogo duplicada rechazada
")
