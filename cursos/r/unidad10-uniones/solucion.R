# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
catalogo <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
stopifnot(!anyDuplicated(catalogo$grupo))
r <- dplyr::left_join(d, catalogo, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(r) == 36, identical(r$id, d$id), !anyNA(r$modalidad))
cat("Una modalidad por grupo; orden de registros e identidad conservados\n")
