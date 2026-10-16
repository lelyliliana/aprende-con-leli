# Pearson, Spearman y una relación que un coeficiente puede ocultar.
# Ejecutar desde cursos/r. Datos construidos, sin inferencia poblacional real.
x <- 1:6
y <- x^2
pearson <- cor(x, y, method = "pearson")
spearman <- cor(x, y, method = "spearman")
manual <- sum((x - mean(x)) * (y - mean(y))) /
  sqrt(sum((x - mean(x))^2) * sum((y - mean(y))^2))
stopifnot(abs(pearson - manual) < 1e-12, pearson < 1,
          abs(spearman - 1) < 1e-12)
prueba <- cor.test(x, y, method = "pearson", conf.level = 0.95)
stopifnot(abs(unname(prueba$estimate) - pearson) < 1e-12,
          unname(prueba$parameter) == 4, length(prueba$conf.int) == 2)
cat(sprintf("Curva creciente: Pearson=%.3f; Spearman=%.3f; n=%d.\n",
            pearson, spearman, length(x)))
cat(sprintf("Pearson: IC95%%=[%.3f, %.3f]; p=%.6f.\n",
            prueba$conf.int[1], prueba$conf.int[2], prueba$p.value))
# Conservar los pares: nunca eliminar faltantes de cada columna por separado.
d <- data.frame(x = c(x, NA, 8), y = c(y, 49, NA))
completos <- complete.cases(d)
stopifnot(sum(completos) == 6, sum(!completos) == 2,
          abs(cor(d$x, d$y, use = "complete.obs") - pearson) < 1e-12)
cat("Faltantes: 8 filas, 6 pares completos y 2 filas excluidas.\n")
u <- -3:3
r_curva <- cor(u, u^2)
stopifnot(abs(r_curva) < 1e-12)
cat(sprintf("Curva en U: Pearson=%.3f; cero no significa ausencia de relación.\n", r_curva))
