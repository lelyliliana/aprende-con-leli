# Soluciones de la Unidad 17

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

El primer ejemplo registra una huella del archivo y la sesión. Eso permite identificar una entrada y un entorno observados, pero no demuestra que los datos sean correctos ni fija versiones para siempre.

Quarto ejecuta la lectura y el cálculo del informe. El original contiene 36 registros y tres horas faltantes, con denominadores 17 y 16 por grupo. El HTML debe comunicar esos resultados de forma coherente con su descripción.

Al cambiar una entrada válida, el resumen y la figura deben reconstruirse desde el archivo. Los límites de datos ficticios y del diseño no desaparecen por renderizar. Registrar versiones, usar una semilla y bloquear dependencias son controles diferentes.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
source("src/curso.R", encoding = "UTF-8")
a <- resumir_encuesta(leer_encuesta())
b <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, b), file.exists("proyecto/informe.qmd"), file.exists("_quarto.yml"))
cat("Fuentes, datos y cálculo identificados; renderizar Quarto ejecuta el informe aparte\n")
cat("Registrar versiones no equivale a congelarlas; la guía distingue ambos alcances.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad17-reproducibilidad/solucion.R
```
