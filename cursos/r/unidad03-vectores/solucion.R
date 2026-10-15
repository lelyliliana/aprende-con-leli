# Solución ejecutable. Intentar primero la práctica.
x <- c(2, 4, 6, 8, 10)
seleccion <- x[x >= 6]
sin_primero <- x[-1]
stopifnot(identical(seleccion, c(6, 8, 10)), length(sin_primero) == 4, length(x) == 5)
stopifnot(all(c(TRUE, FALSE, TRUE, FALSE, TRUE) == (x %% 4 == 2)))
cat("Seleccionados:", paste(seleccion, collapse = ", "), "; original sin cambio\n")
