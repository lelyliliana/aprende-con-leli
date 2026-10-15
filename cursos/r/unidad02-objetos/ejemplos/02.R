# Distinguir tipo y apariencia
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
entero <- 3L
real <- 3
texto <- "3"
stopifnot(typeof(entero) == "integer", typeof(real) == "double", typeof(texto) == "character")
stopifnot(entero == real, !identical(entero, real))
cat("Tipos:", typeof(entero), typeof(real), typeof(texto), "
")
cat("Igual valor:", entero == real, "; idénticos:", identical(entero, real), "
")
