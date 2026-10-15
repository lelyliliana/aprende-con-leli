# Solución ejecutable. Intentar primero la práctica.
d <- data.frame(horas = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
d$minutos <- d$horas * 60
m <- lm(y ~ minutos, data = d)
p <- predict(m, newdata = data.frame(minutos = 150))
stopifnot(abs(coef(m)[["minutos"]] - 0.05) < 1e-10, abs(unname(p) - 9.5) < 1e-10)
cat("Pendiente por minuto=0.05; 150 minutos predicen 9.5; la unidad cambia el coeficiente\n")
