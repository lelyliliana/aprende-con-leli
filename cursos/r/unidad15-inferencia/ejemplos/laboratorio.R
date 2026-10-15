# Laboratorio guiado. Ejecutar desde cursos/r.
x <- c(8, 9, 10, 11, 12)
n <- length(x)
media <- mean(x)
error_estandar <- sd(x) / sqrt(n)
cuantil <- qt(0.975, df = n - 1)
margen <- cuantil * error_estandar
intervalo <- c(media - margen, media + margen)
r <- t.test(x, mu = 10)
stopifnot(max(abs(intervalo - unname(r$conf.int[1:2]))) < 1e-10)
cat(sprintf("n=%d; media=%.3f; error estándar=%.3f\n", n, media, error_estandar))
cat(sprintf("Cuantil=%.3f; margen=%.3f; intervalo=[%.3f, %.3f]\n", cuantil, margen, intervalo[1], intervalo[2]))
cat("El intervalo corresponde a la media del modelo, no a individuos.\n")
