# Unidad 16. Correlación y regresión lineal introductoria

[Anterior](../unidad15-inferencia/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-reproducibilidad/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Leer pendiente, intercepto y unidad de predicción.
- Examinar residuos y rango de datos.
- Separar asociación, ajuste, incertidumbre y causalidad.

## Un modelo expresa una relación condicionada

lm(y~x,data=d) ajusta una relación lineal con intercepto. En el caso construido, y contiene 2+3x más desviaciones. El ajuste recupera intercepto 2 y pendiente 3. El intercepto corresponde a la respuesta modelada en x=0 y la pendiente al cambio de respuesta modelada por una unidad de x.

Esa interpretación requiere conservar unidades y contexto. La pendiente puede cambiar numéricamente si pasas de horas a minutos sin cambiar la relación subyacente. La solución obtiene 0.05 por minuto, equivalente a 3 por hora.

## Predicción dentro y fuera del rango

En x=2.5, el valor ajustado es 9.5. x=20 queda fuera del rango observado [0,5]. El programa puede producir una extrapolación, pero la existencia de un resultado no demuestra que el modelo siga siendo adecuado allí.

Una predicción puntual no representa toda la incertidumbre. Para comunicarla, distingue incertidumbre de la media modelada y variación de una observación futura, bajo los supuestos del modelo. La ruta introduce esas preguntas sin convertir un ajuste pequeño en una herramienta de decisión validada.

## Residuos y diagnóstico

El residuo es observado menos ajustado. Con intercepto, los residuos del ajuste de mínimos cuadrados suman aproximadamente cero; eso no significa que todos sean cero ni que el modelo sea correcto.

El gráfico residuos/ajustados permite buscar patrones y cambios de dispersión. El gráfico Q-Q orienta la revisión de una distribución de residuos para el uso inferencial correspondiente. Seis observaciones ofrecen diagnóstico limitado. Una figura o un test no certifican automáticamente linealidad, independencia, varianza o normalidad.

## Correlación y causalidad

La correlación resume asociación lineal y depende de qué unidades, rango y datos estás observando. Una asociación alta no demuestra que intervenir sobre x produzca el cambio de y indicado por la pendiente. Variables omitidas, selección, temporalidad y diseño importan.

El Ejemplo 01 comprueba coeficientes y predicción de un caso construido; el segundo conserva residuos no nulos y señala extrapolación. El proyecto final describe su archivo ficticio sin afirmar efectos causales de la modalidad.

## Qué revisar antes de usar el modelo

Define resultado, predictores, unidad, propósito y población de aplicación. Examina datos y residuos, registra transformaciones y datos excluidos y evalúa el modelo para su finalidad. Si el objetivo es predicción, el desempeño fuera de los datos usados para ajustar requiere evaluación adicional; un buen ajuste dentro de la tabla no la sustituye.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Coeficientes y predicción dentro del rango

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
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
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad16-regresion/ejemplos/01.R
```

Salida esperada:

```text
Ajuste construido: intercepto=2; pendiente=3; predicción en x=2.5: 9.5
La pendiente describe asociación en el modelo, no un efecto causal demostrado.
```

### Ejemplo 2. Residuos y extrapolación

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
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
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad16-regresion/ejemplos/02.R
```

Salida esperada:

```text
Residuos no nulos; x=20 está fuera del rango observado [0,5]
Un gráfico diagnóstico orienta revisión; no certifica por sí solo los supuestos.
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad15-inferencia/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-reproducibilidad/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2016%20%28Correlaci%C3%B3n%20y%20regresi%C3%B3n%20lineal%20introductoria%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
