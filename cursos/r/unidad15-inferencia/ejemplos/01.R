# Intervalo de una media y contraste declarado
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(8, 9, 10, 11, 12)  # Datos construidos para practicar el cálculo.
r <- t.test(x, mu = 10, conf.level = 0.95)
stopifnot(unname(r$estimate) == 10, abs(r$p.value - 1) < 1e-12)
stopifnot(r$conf.int[1] < 10, r$conf.int[2] > 10)
cat(sprintf("n=5; media=10; IC95%%=[%.3f, %.3f]; p=%.3f
", r$conf.int[1], r$conf.int[2], r$p.value))
cat("Interpretación condicionada al diseño y supuestos; no prueba que la media sea exactamente 10.
")
