# Unidad 13. Distribuciones y estadística descriptiva

[Anterior](../unidad12-graficos/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-muestreo/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Describir centro, dispersión y forma con medidas complementarias.
- Declarar denominadores para frecuencias y proporciones.
- Investigar extremos antes de excluirlos.

## Clase guiada. Elegir un resumen y explicar qué representa

La estadística descriptiva organiza los valores observados. Una media o una proporción resume una parte de la tabla, pero no reemplaza su distribución, su unidad ni el origen de los registros. Comenzamos con cinco cantidades pequeñas para que puedas reconstruir los cálculos antes de usar el archivo completo.

### 1. Reconstruye la media

Para 10, 11, 12, 13, 100, suma 146 y divide entre cinco: 29.2. La media usa todos los valores y cambia cuando un extremo cambia. Ninguna observación del ejemplo es igual a 29.2: el promedio no tiene que coincidir con un caso real ni representar por sí solo un valor típico.

### 2. Compara con la mediana y la dispersión

Ordenados los cinco datos, la posición central es la tercera: mediana 12. Si hubiera un número par de observaciones, la mediana numérica se obtiene con los dos valores centrales. El mínimo 10 y el máximo 100 describen extremos; la amplitud es 90. La desviación estándar resume variación respecto a la media y conserva la unidad de la variable. No confundas dispersión entre observaciones con incertidumbre de una media.

Los cuartiles describen posiciones de la distribución y el rango intercuartílico resume la separación entre Q1 y Q3. Para conjuntos pequeños hay convenciones de cálculo: si comparas software, declara el método de cuantiles en lugar de asumir que cualquier diferencia es un error. La caja de la unidad anterior utiliza resúmenes de distribución y no marca datos imposibles por sí sola.

### 3. Investiga un extremo sin borrarlo por comodidad

El valor 100 podría ser válido en un puntaje de 0 a 100. Revisa archivo de origen, unidad, captura y contexto. Excluirlo hipotéticamente cambia la media a 11.5, pero esa sensibilidad no justifica una eliminación real. Conserva el original y comunica el criterio si finalmente corriges o excluyes una observación.

### 4. Pon nombre al denominador de un porcentaje

En alta, alta, baja, NA hay cuatro registros, tres respuestas conocidas y dos respuestas altas. Entre las respuestas conocidas, alta representa 2/3 (66.67%); entre todos los registros, representa 2/4 (50%). Ambas cuentas pueden ser correctas si explicas la pregunta. La ausencia no es una cuarta categoría de satisfacción ni autoriza a clasificarla como baja.

| Pregunta | Numerador | Denominador |
|---|---|---|
| ¿Qué fracción de respuestas conocidas es alta? | 2 | 3 |
| ¿Qué fracción de registros tiene respuesta alta? | 2 | 4 |

En la encuesta hay 36 registros y 34 respuestas de satisfacción. table con useNA="ifany" incluye la cuenta de faltantes; con useNA="no" resume solo respuestas. prop.table normaliza la tabla que recibe: si excluiste las ausencias, sus proporciones suman uno entre las respuestas disponibles.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
x <- c(10, 11, 12, 13, 100)
print(sum(x))
print(length(x))
print(sum(x) / length(x))
print(median(x))
respuestas <- c("alta", "alta", "baja", NA_character_)
n_alta <- sum(respuestas == "alta", na.rm = TRUE)
n_observadas <- sum(!is.na(respuestas))
cat(sprintf("Entre respuestas: %.2f%%; entre registros: %.2f%%\n", 100 * n_alta / n_observadas, 100 * n_alta / length(respuestas)))
stopifnot(mean(x) == 29.2, median(x) == 12, n_observadas == 3)
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad13-descriptiva/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] 146
[1] 5
[1] 29.2
[1] 12
Entre respuestas: 66.67%; entre registros: 50.00%
```

### Lectura del laboratorio

Las cuatro primeras impresiones reconstruyen suma 146, tamaño 5, media 29.2 y mediana 12. La última línea calcula dos porcentajes con el mismo numerador. Lee el nombre de cada denominador: cambiarlo altera la pregunta aunque los datos no cambien.

## Experimenta

Reemplaza 100 por 14 en una copia: la media y la mediana serán 12. Después añade una segunda ausencia en las respuestas de satisfacción. Cuenta de nuevo observados y total antes de expresar porcentajes. No omitas esa decisión porque prop.table ejecute sin error.

## Errores frecuentes

| Error | Revisión |
|---|---|
| Informar solo media ante un extremo | Añade mediana, tamaño, dispersión y contexto |
| Excluir 100 porque eleva el promedio | Investiga dominio y procedencia |
| Comparar porcentajes con bases distintas | Explicita numerador y denominador |
| Tratar faltante como insatisfacción | Conserva la ausencia como información desconocida |

## Autoevaluación

¿Por qué media 29.2 y mediana 12 no se contradicen? ¿Cuándo usarías 34 y cuándo 36 en la encuesta? ¿Qué necesitas revisar antes de eliminar un dato extremo?


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
