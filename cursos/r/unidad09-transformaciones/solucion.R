# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
a <- d |> dplyr::filter(puntaje >= 80) |> dplyr::arrange(id)
b <- d[d$puntaje >= 80, , drop = FALSE]
b <- b[order(b$id), , drop = FALSE]
stopifnot(identical(a$id, b$id), nrow(d) == 36)
cat("Filtro contrastado con selección base; se conserva el original\n")
