# Soluciones razonadas de la Unidad 16

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Recta con unidades

El ajuste devuelve intercepto 2 y pendiente 3 por hora. La predicción en 2.5 es 2+3×2.5=9.5. El intercepto se refiere a horas 0 dentro del caso construido; la pendiente describe asociación ajustada, no un efecto causal demostrado.

## Paso 2. Coeficiente por minuto

La pendiente pasa a 0.05 por minuto y 150 minutos producen 9.5. Multiplicar la escala del predictor por 60 divide la pendiente entre 60 en este caso. Cambiar la unidad sin cambiar el valor ni el modelo enviaría una entrada con significado distinto.

## Paso 3. Diagnóstico acotado

El script guarda practica-residuos.svg. Debes abrirlo y revisar patrón, residuos y referencia horizontal. Con seis casos construidos esa vista no certifica supuestos. El rango es [0, 5] y 20 queda fuera: extrapolación. La asociación observada tampoco establece qué ocurriría al intervenir sobre horas.

## Reto de transferencia. Una identidad del ajuste

observado=ajustado+residuo porque residuo se define como observado-ajustado. La tolerancia contempla aritmética flotante. Que haya desviaciones es compatible con un ajuste no perfecto; excluir observaciones necesita razones sobre datos y diseño, no el deseo de hacer que todas caigan en la recta.

## Ampliación. Una curva creciente distinta

El script guarda `salidas/graficos/practica-correlacion.svg`; abre la figura y observa cómo aumentan los saltos entre puntos. Pearson es aproximadamente 0.906 y Spearman es 1. El crecimiento conserva el orden, pero sus saltos se amplían; no es una recta. La fila añadida no forma un par completo: quedan seis pares de siete filas. Negar y invierte ambos signos y conserva sus magnitudes. El script verifica esas relaciones; ningún cálculo demuestra causalidad.

## Respuestas de autoevaluación

Spearman es 1 porque los rangos coinciden en la curva creciente. En la curva en U, las contribuciones al numerador de Pearson se compensan; existe una relación curva aunque r sea cero. Se excluyen filas con ausencia en cualquiera de las dos variables, conservando los pares.

~ declara respuesta en función de predictor. La pendiente cambia porque cambia la unidad por la que se expresa. Un residuo positivo indica observado por encima del ajustado. Causalidad necesitaría un diseño y argumentación adicionales sobre asignación, confusión y contexto.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
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
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad16-regresion/solucion.R
```

Salida esperada:

```text
Paso 1: intercepto=2; pendiente=3 por hora; predicción=9.5.
Paso 2: pendiente=0.05 por minuto; misma predicción en 150 minutos.
Paso 3: diagnóstico generado; rango=[0,5]; 20 horas es extrapolación.
Reto: observados reconstruidos; residuos no nulos; asociación no demuestra causa.
Ampliación: Pearson=0.906; Spearman=1.000; 6 pares; al negar y cambia el signo.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2016%20%28Correlaci%C3%B3n%20y%20regresi%C3%B3n%20lineal%20introductoria%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
