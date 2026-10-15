# Solución ejecutable. Intentar primero la práctica.
a <- 2 + 3 * 4
b <- (2 + 3) * 4
stopifnot(a == 14, b == 20)
cat("Sin paréntesis:", a, "; con paréntesis:", b, "\n")
