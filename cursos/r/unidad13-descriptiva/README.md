# Unidad 13. Distribuciones y estadística descriptiva

[Anterior](../unidad12-graficos/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-muestreo/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Describir centro, dispersión y forma con medidas complementarias.
- Declarar denominadores para frecuencias y proporciones.
- Investigar extremos antes de excluirlos.

## Una medida resume una pregunta, no toda la distribución

La media de 10,11,12,13,100 es 29.2 y la mediana es 12. Ninguna es un error: responden a definiciones distintas. La media utiliza magnitudes de todos los valores; la mediana ubica el centro del orden. La observación 100 tiene gran influencia en la media.

Antes de llamar atípico a un valor para eliminarlo, revisa su origen, unidad y dominio. Puede ser un error, una observación válida poco frecuente o una señal que responde a otra pregunta. No decidas su exclusión solo porque modifica el resumen que preferías.

## Dispersión y forma

El mínimo y máximo describen extremos; los cuantiles ubican partes de la distribución; la desviación estándar resume dispersión alrededor de la media en la misma unidad. sd en R calcula la desviación estándar muestral con su convención habitual de denominador n-1. No equivale a error estándar de una media.

Las medidas necesitan contexto de tamaño y faltantes. Una dispersión calculada con muy pocos datos no describe de forma estable cualquier población. El rango es sensible a extremos y al tamaño de muestra. Un gráfico complementa la tabla al mostrar forma y observaciones que el resumen oculta.

## Proporciones y categorías

En la encuesta hay 36 registros y dos satisfacciones faltantes. table con useNA="ifany" permite incluir una categoría de ausencia y contar los 36. Si describes proporciones entre quienes respondieron, el denominador es 34; si describes sobre todos los participantes, es 36 y debes tratar los faltantes explícitamente.

Cambiar denominador cambia la pregunta. No presentes ambos porcentajes con la misma etiqueta. Las respuestas baja/media/alta son categorías ordenadas; su código interno no vuelve a la distancia entre categorías una cantidad automáticamente promediable.

## Resumir por grupo no explica una causa

Dos grupos pueden diferir en media por muchas características. Una tabla descriptiva comunica qué hay en el archivo. No demuestra que la modalidad provocó el puntaje. La ruta separa descripción, diseño de muestreo y análisis inferencial antes de elegir una prueba.

## Traza del caso

El primer ejemplo conserva los cinco valores y muestra media, mediana y rango. El segundo construye frecuencias con y sin ausencia y comprueba sus denominadores. La solución vuelve a explicar por qué investigar 100 precede a una decisión de excluirlo. Una buena entrega conserva tanto el resultado como su alcance.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. La media no describe sola la distribución

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# La media no describe sola la distribución
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(10, 11, 12, 13, 100)
stopifnot(mean(x) == 29.2, median(x) == 12, min(x) == 10, max(x) == 100)
cat("Media:", mean(x), "; mediana:", median(x), "; rango:", min(x), "a", max(x), "
")
cat("La observación 100 se investiga; no se elimina solo por ser extrema.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad13-descriptiva/ejemplos/01.R
```

Salida esperada:

```text
Media: 29.2 ; mediana: 12 ; rango: 10 a 100
La observación 100 se investiga; no se elimina solo por ser extrema.
```

### Ejemplo 2. Proporciones con denominador conocido

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Proporciones con denominador conocido
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
frecuencias <- table(d$satisfaccion, useNA = "ifany")
observadas <- table(d$satisfaccion, useNA = "no")
stopifnot(sum(frecuencias) == 36, sum(observadas) == 34)
p <- prop.table(observadas)
stopifnot(abs(sum(p) - 1) < 1e-12)
cat("Total: 36; satisfacción observada: 34; faltantes: 2
")
cat("Las proporciones de respuestas usan denominador 34, no 36.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad13-descriptiva/ejemplos/02.R
```

Salida esperada:

```text
Total: 36; satisfacción observada: 34; faltantes: 2
Las proporciones de respuestas usan denominador 34, no 36.
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad12-graficos/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-muestreo/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2013%20%28Distribuciones%20y%20estad%C3%ADstica%20descriptiva%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
