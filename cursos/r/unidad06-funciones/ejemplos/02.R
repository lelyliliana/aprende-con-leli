# Repetición y resultado equivalente
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(3, NA_real_, 5, 7)
suma <- 0
n <- 0L
for (valor in x) {
  if (!is.na(valor)) { suma <- suma + valor; n <- n + 1L }
}
stopifnot(n == 3L, suma / n == mean(x, na.rm = TRUE))
cat("Observados:", n, "; suma:", suma, "; media:", suma / n, "
")
