# Reciclaje y orden por columnas
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(1, 2, 3, 4)
r <- x + c(10, 20)
stopifnot(identical(r, c(11, 22, 13, 24)))
m <- matrix(1:6, nrow = 2)
stopifnot(m[1, 2] == 3, m[2, 3] == 6)
cat("Reciclaje:", paste(r, collapse = ", "), "
")
cat("Matriz: fila 1, columna 2 =", m[1, 2], "
")
