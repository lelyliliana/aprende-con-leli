# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(id = c("A", "B", "C"), horas = c(5, 5, 8))
columna <- d[, "horas", drop = FALSE]
valores <- d[["horas"]]
print(c(nrow(columna), ncol(columna)))
print(valores)
seleccion <- d[d$horas == 5, , drop = FALSE]
print(seleccion$id)
registro <- list(id = "A", mediciones = c(5, 6))
print(is.list(registro["id"]))
print(registro[["id"]])
stopifnot(nrow(seleccion) == 2, !anyDuplicated(d$id))
