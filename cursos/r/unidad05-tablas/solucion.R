# Solución ejecutable. Intentar primero la práctica.
d <- data.frame(id = c("A", "B", "C"), valor = c(5, 5, 8))
stopifnot(!anyDuplicated(d$id), anyDuplicated(d$valor) > 0)
r <- d[d$valor == 5, , drop = FALSE]
stopifnot(nrow(r) == 2, identical(r$id, c("A", "B")))
cat("Valores repetidos no implican ID duplicado; consulta conserva dos filas\n")
