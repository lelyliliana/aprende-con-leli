# Solución ejecutable. Intentar primero la práctica.
horas <- 1.75
minutos <- horas * 60
codigo <- "007"
stopifnot(minutos == 105, nchar(codigo) == 3, as.numeric(codigo) == 7)
cat("Minutos:", minutos, "; código conservado como texto:", codigo, "\n")
