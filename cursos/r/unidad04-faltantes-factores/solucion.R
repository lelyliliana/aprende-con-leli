# Solución ejecutable. Intentar primero la práctica.
x <- c(0, NA_real_, 20)
stopifnot(mean(x, na.rm = TRUE) == 10, sum(!is.na(x)) == 2)
vacio <- mean(c(NA_real_, NA_real_), na.rm = TRUE)
stopifnot(is.nan(vacio))
f <- factor(c("alta", "desconocida"), levels = c("baja", "media", "alta"))
stopifnot(sum(is.na(f)) == 1)
cat("Media con dos observados: 10; todo faltante: NaN; etiqueta desconocida: NA\n")
