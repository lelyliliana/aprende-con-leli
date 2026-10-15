# Factor y fecha explícitos
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
nivel <- factor(c("alta", "baja", "media"), levels = c("baja", "media", "alta"), ordered = TRUE)
codigo <- factor(c("10", "20"))
correcto <- as.numeric(as.character(codigo))
fechas <- as.Date(c("15/01/2026", "18/01/2026"), format = "%d/%m/%Y")
stopifnot(identical(as.integer(nivel), c(3L, 1L, 2L)), identical(correcto, c(10, 20)))
stopifnot(as.numeric(fechas[2] - fechas[1]) == 3)
cat("Factor: códigos", paste(as.integer(codigo), collapse = ","), "; valores", paste(correcto, collapse = ","), "
")
cat("Días transcurridos:", as.numeric(fechas[2] - fechas[1]), "
")
