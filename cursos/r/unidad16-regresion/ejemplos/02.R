# Residuos y extrapolación
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- data.frame(x = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
m <- lm(y ~ x, data = d)
stopifnot(abs(sum(residuals(m))) < 1e-10, sum(residuals(m)^2) > 0)
fuera <- 20 < min(d$x) || 20 > max(d$x)
stopifnot(fuera)
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
svg("salidas/graficos/diagnostico.svg", width = 8, height = 4)
par(mfrow = c(1, 2))
plot(fitted(m), residuals(m), xlab = "Ajustado", ylab = "Residuo", main = "Residuos")
abline(h = 0, lty = 2)
qqnorm(residuals(m), main = "Gráfico Q-Q"); qqline(residuals(m))
invisible(dev.off())
cat("Residuos no nulos; x=20 está fuera del rango observado [0,5]
")
cat("Un gráfico diagnóstico orienta revisión; no certifica por sí solo los supuestos.
")
