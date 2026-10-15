# Lista y control de identidad
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
registro <- list(id = "P1", mediciones = c(12, 14, 15), observada = TRUE)
stopifnot(is.list(registro), length(registro$mediciones) == 3, is.list(registro["id"]))
stopifnot(identical(registro[["id"]], "P1"))
cat("Con [ se obtiene lista:", is.list(registro["id"]), "
")
cat("Con [[ se obtiene el valor:", registro[["id"]], "
")
