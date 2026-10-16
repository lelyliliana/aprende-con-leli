# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Estimar en horas y reconstruir la predicción.
d <- data.frame(horas = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
m_horas <- lm(y ~ horas, data = d)
p_horas <- unname(predict(m_horas, newdata = data.frame(horas = 2.5)))
stopifnot(abs(coef(m_horas)[[1]] - 2) < 1e-10, abs(coef(m_horas)[[2]] - 3) < 1e-10, abs(p_horas - 9.5) < 1e-10)
cat("Paso 1: intercepto=2; pendiente=3 por hora; predicción=9.5.\n")
# Paso 2. Misma medición con otra unidad.
d$minutos <- d$horas * 60
m_minutos <- lm(y ~ minutos, data = d)
p_minutos <- unname(predict(m_minutos, newdata = data.frame(minutos = 150)))
stopifnot(abs(coef(m_minutos)[["minutos"]] - 0.05) < 1e-10, abs(p_horas - p_minutos) < 1e-10)
cat("Paso 2: pendiente=0.05 por minuto; misma predicción en 150 minutos.\n")
# Paso 3. Generar el diagnóstico y comprobar el rango observado.
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
archivo <- "salidas/graficos/practica-residuos.svg"
grDevices::svg(archivo, width = 7, height = 4)
plot(fitted(m_horas), residuals(m_horas), xlab = "Puntaje ajustado", ylab = "Residuo", main = "Caso construido")
abline(h = 0, lty = 2)
invisible(dev.off())
stopifnot(file.info(archivo)$size > 1000, min(d$horas) == 0, max(d$horas) == 5, 20 > max(d$horas))
cat("Paso 3: diagnóstico generado; rango=[0,5]; 20 horas es extrapolación.\n")
# Reto. Cada observado es ajustado más residuo, dentro de la tolerancia.
stopifnot(max(abs(d$y - (fitted(m_horas) + residuals(m_horas)))) < 1e-10)
stopifnot(sum(residuals(m_horas)^2) > 0)
cat("Reto: observados reconstruidos; residuos no nulos; asociación no demuestra causa.\n")
# Ampliación. Otra curva monótona y cambio de dirección.
x <- 1:6
y <- c(1, 2, 4, 8, 16, 32)
grDevices::svg("salidas/graficos/practica-correlacion.svg", width = 7, height = 4)
plot(x, y, xlab = "x", ylab = "y", main = "Curva creciente construida", pch = 19)
invisible(dev.off())
stopifnot(file.info("salidas/graficos/practica-correlacion.svg")$size > 1000)
r <- cor(x, y)
rho <- cor(x, y, method = "spearman")
stopifnot(r > 0.9, r < 0.95, abs(rho - 1) < 1e-12)
d_pares <- data.frame(x = c(x, NA), y = c(y, 64))
stopifnot(sum(complete.cases(d_pares)) == 6,
          abs(cor(d_pares$x, d_pares$y, use = "complete.obs") - r) < 1e-12)
stopifnot(abs(cor(x, -y) + r) < 1e-12,
          abs(cor(x, -y, method = "spearman") + 1) < 1e-12)
cat(sprintf("Ampliación: Pearson=%.3f; Spearman=%.3f; 6 pares; al negar y cambia el signo.\n", r, rho))
