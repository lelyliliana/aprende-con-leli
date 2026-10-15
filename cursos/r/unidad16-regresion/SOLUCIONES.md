# Soluciones de la Unidad 16

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El ajuste tiene intercepto 2, pendiente 3 por hora y predicción 9.5 en 2.5 horas. Convertir a minutos divide la pendiente entre 60: 0.05 por minuto. La solución comprueba que 150 minutos produzca nuevamente 9.5.

Los residuos suman aproximadamente cero por las propiedades de ese ajuste con intercepto, pero siguen siendo no nulos. Esa suma no valida todos los supuestos ni demuestra calidad predictiva fuera de la tabla.

x=20 excede [0,5]. Antes de usar una predicción allí necesitarías justificar el rango y propósito. La pendiente describe una asociación modelada; un efecto causal requiere un diseño y argumentos que el ajuste por sí solo no aporta.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
d <- data.frame(horas = 0:5, y = 2 + 3 * (0:5) + c(1, -1, 0, 0, -1, 1))
d$minutos <- d$horas * 60
m <- lm(y ~ minutos, data = d)
p <- predict(m, newdata = data.frame(minutos = 150))
stopifnot(abs(coef(m)[["minutos"]] - 0.05) < 1e-10, abs(unname(p) - 9.5) < 1e-10)
cat("Pendiente por minuto=0.05; 150 minutos predicen 9.5; la unidad cambia el coeficiente\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad16-regresion/solucion.R
```
