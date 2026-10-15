# Primera sesión comprobable
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
compatible <- getRversion() >= "4.3.0"
stopifnot(compatible)
resultado <- 2 + 3 * 4
stopifnot(resultado == 14)
cat("R compatible:", compatible, "
")
cat("2 + 3 * 4 =", resultado, "
")
