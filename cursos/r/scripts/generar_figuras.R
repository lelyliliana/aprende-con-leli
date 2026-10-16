# Ejecutar desde cursos/r. Reconstruye PNG en salidas/figuras-doc.
if (!file.exists("Curso-R.Rproj")) stop("Trabaja desde cursos/r")
destino <- "salidas/figuras-doc"
dir.create(destino, recursive = TRUE, showWarnings = FALSE)
guardar <- function(nombre, grafico) {
  ggplot2::ggsave(file.path(destino, nombre), grafico, width = 7, height = 4.5,
                 dpi = 150, device = "png", bg = "white")
}
source("unidad12-graficos/ejemplos/laboratorio.R", encoding = "UTF-8")
guardar("dispersion.png", g)
source("unidad12-graficos/ejemplos/01.R", encoding = "UTF-8")
guardar("distribucion.png", g)
source("unidad12-graficos/ejemplos/02.R", encoding = "UTF-8")
guardar("temperatura.png", g)
source("unidad12-graficos/solucion.R", encoding = "UTF-8")
guardar("histograma-10.png", h10)
guardar("histograma-5.png", h5)
d <- data.frame(x = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
m <- lm(y ~ x, data = d)
png(file.path(destino, "residuos.png"), width = 1200, height = 650, res = 150)
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3, 1))
plot(fitted(m), residuals(m), xlab = "Ajustado", ylab = "Residuo",
     main = "Residuos", pch = 19, col = "#235789")
abline(h = 0, lty = 2)
qqnorm(residuals(m), main = "Gráfico Q-Q", pch = 19, col = "#235789")
qqline(residuals(m))
invisible(dev.off())
x <- 1:6; u <- -3:3
png(file.path(destino, "correlacion.png"), width = 1200, height = 650, res = 150)
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3, 1))
plot(x, x^2, xlab = "x", ylab = "y = x²", pch = 19, col = "#235789",
     main = "Creciente: Spearman = 1")
plot(u, u^2, xlab = "x", ylab = "y = x²", pch = 19, col = "#235789",
     main = "Curva en U: Pearson = 0")
invisible(dev.off())
archivos <- c("dispersion.png", "distribucion.png", "temperatura.png",
              "histograma-10.png", "histograma-5.png", "residuos.png", "correlacion.png")
stopifnot(all(file.info(file.path(destino, archivos))$size > 1000))
cat("Siete figuras documentales reconstruidas en salidas/figuras-doc.\n")
