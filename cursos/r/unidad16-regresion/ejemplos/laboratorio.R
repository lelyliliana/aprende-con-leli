# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(horas = 0:5, puntaje = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
m <- lm(puntaje ~ horas, data = d)
intercepto <- unname(coef(m)["(Intercept)"])
pendiente <- unname(coef(m)["horas"])
predicha <- intercepto + pendiente * 2.5
primera_ajustada <- fitted(m)[1]
primer_residuo <- d$puntaje[1] - primera_ajustada
stopifnot(abs(predicha - 9.5) < 1e-10, abs(primer_residuo - 1) < 1e-10)
cat(sprintf("Recta: puntaje = %.1f + %.1f * horas\n", intercepto, pendiente))
cat(sprintf("Para 2.5 horas: %.1f; primera fila: observado=3, ajustado=%.1f, residuo=%.1f\n", predicha, primera_ajustada, primer_residuo))
