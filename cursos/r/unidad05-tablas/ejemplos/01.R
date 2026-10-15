# Una fila, una observación
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- data.frame(id = c("P1", "P2", "P3"), horas = c(2, 4, 6), stringsAsFactors = FALSE)
columna <- d[, "horas", drop = FALSE]
stopifnot(is.data.frame(columna), ncol(columna) == 1, nrow(d) == 3)
stopifnot(identical(d[d$horas >= 4, "id"], c("P2", "P3")))
cat("Tabla:", nrow(d), "filas y", ncol(d), "columnas
")
cat("Selección conservada como tabla:", is.data.frame(columna), "
")
