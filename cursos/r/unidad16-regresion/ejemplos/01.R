# Coeficientes y predicción dentro del rango
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- data.frame(x = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
m <- lm(y ~ x, data = d)
p <- predict(m, newdata = data.frame(x = 2.5))
stopifnot(isTRUE(all.equal(unname(coef(m)), c(2, 3), tolerance = 1e-10)))
stopifnot(abs(unname(p) - 9.5) < 1e-10)
cat("Ajuste construido: intercepto=2; pendiente=3; predicción en x=2.5: 9.5
")
cat("La pendiente describe asociación en el modelo, no un efecto causal demostrado.
")
