# Unidad 14. Muestreo, simulación y variabilidad

[Anterior](../unidad13-descriptiva/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-inferencia/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Distinguir población, muestra y mecanismo de selección.
- Repetir un cálculo aleatorio con semilla.
- Separar variación muestral, sesgo y tamaño del estudio.

## Clase guiada. El azar del programa y el diseño de selección

Una muestra contiene unidades seleccionadas de una población definida. En los ejemplos la población es artificial y conocida:1000 posiciones con valores de 0 a 9 repetidos 100 veces. La media completa es 4.5. Conocerla nos permite estudiar cómo varían muestras del mismo mecanismo, sin atribuir esa población a personas reales.

### 1. Distingue seleccionar unidades y observar valores

En el laboratorio hay seis IDs y algunos valores repetidos. Seleccionar sin reemplazo impide repetir la misma unidad, pero dos IDs distintos pueden tener valor 2. No uses repetición de valores como evidencia de que el muestreo repitió personas. Para seguir identidad, selecciona IDs o posiciones y después recupera sus valores.

### 2. Interpreta reemplazo y tamaño

Sin reemplazo, cada ID elegido deja de estar disponible para otra selección de esa misma muestra. No puedes obtener 30 IDs distintos de una población de 10. Con reemplazo, cada extracción vuelve a dejar disponible el ID, por lo que 30 extracciones sí son posibles y necesariamente contienen repeticiones.

### 3. Controla una secuencia reproducible

set.seed establece el estado inicial del generador de números seudoaleatorios. Si restableces la misma semilla antes de las mismas operaciones, puedes reproducir la muestra en el entorno correspondiente. No pongas la misma semilla dentro de cada iteración de una simulación si quieres explorar muestras distintas: reiniciarías la secuencia continuamente.

Una semilla no convierte una muestra conveniente en representativa ni elimina un sesgo de cobertura. Si eliges las primeras 100 posiciones de la población ordenada del curso, obtienes solo ceros: media 0 aunque el total tenga media 4.5. El problema está en el mecanismo de selección, no en que olvidaras una semilla.

### 4. Simula una distribución de medias

El código replicate(500, mean(sample(...))) repite la selección 500 veces y conserva una media por muestra. No guarda 500 personas ni 500 valores individuales. En cada iteración se seleccionan 50 unidades y se calcula un único resumen. La distribución de esas 500 medias permite explorar variabilidad del procedimiento.

| Objeto | Cantidad | Qué representa |
|---|---|---|
| poblacion | 1000 | Valores de unidades artificiales |
| Una muestra | 50 | Valores seleccionados en una repetición |
| medias | 500 | Una media de cada muestra |

En esta simulación las medias se dispersan menos que los valores individuales. Eso ilustra por qué la desviación entre personas y el error estándar de una media son cantidades conceptualmente diferentes. La observación depende del mecanismo y del tamaño empleados; no demuestra que toda muestra de 50 de cualquier proceso produzca una inferencia adecuada.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
poblacion <- data.frame(id = 1:6, valor = c(2, 2, 4, 6, 8, 8))
set.seed(17)
ids_a <- sample(poblacion$id, size = 4, replace = FALSE)
set.seed(17)
ids_b <- sample(poblacion$id, size = 4, replace = FALSE)
stopifnot(identical(ids_a, ids_b), !anyDuplicated(ids_a))
set.seed(17)
con_reemplazo <- sample(poblacion$id, size = 20, replace = TRUE)
stopifnot(length(con_reemplazo) == 20, anyDuplicated(con_reemplazo) > 0)
cat("Misma semilla y mismas operaciones: los cuatro IDs se repiten.\n")
cat("Sin reemplazo no se repite ID; valores iguales pueden pertenecer a IDs distintos.\n")
cat("Veinte extracciones de seis IDs con reemplazo contienen repeticiones.\n")
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad14-muestreo/ejemplos/laboratorio.R
```

Salida esperada:

```text
Misma semilla y mismas operaciones: los cuatro IDs se repiten.
Sin reemplazo no se repite ID; valores iguales pueden pertenecer a IDs distintos.
Veinte extracciones de seis IDs con reemplazo contienen repeticiones.
```

### Lectura del laboratorio

Las comprobaciones revisan identidad de las muestras repetidas y límites del muestreo con reemplazo. Los mensajes no publican una lista aleatoria como si fuera una conclusión sobre una población: explican qué regla se verificó. Si comparas secuencias entre versiones de R, registra también versión y configuración del generador.

## Experimenta

Coloca una sola semilla antes de un ciclo de cinco muestras y registra cinco medias. Después, en una copia, reinicia la misma semilla dentro del ciclo y observa la repetición artificial. Explica por qué el segundo procedimiento no explora la variación que buscabas.

## Errores frecuentes

| Error | Cómo reconocerlo |
|---|---|
| Repetir valores significa repetir IDs | Contrasta la identidad de las unidades |
| Una semilla garantiza representatividad | Revisa el marco y el mecanismo de selección |
| 500 medias son 500 personas | Sigue qué conserva cada repetición |
| Reiniciar la semilla en cada vuelta | Revisa si todas las muestras se vuelven idénticas |

## Autoevaluación

¿Qué cambia con replace=TRUE? ¿Por qué pueden repetirse valores sin repetir unidades? ¿Qué controla la semilla y qué no? ¿Cuál es la unidad de cada elemento de medias?


## La población se define antes de seleccionar

Una población es el conjunto sobre el que se plantea una pregunta. Una muestra contiene unidades seleccionadas mediante un procedimiento. El tamaño por sí solo no explica de qué población procede ni si el mecanismo permite generalizar.

El ejemplo usa una población artificial de mil valores: cien repeticiones de cada número 0 a 9. Su media conocida es 4.5. Seleccionar cincuenta sin reemplazo permite estudiar variación sin confundirla con el desconocimiento de una población real. Los valores repetidos no implican que se haya elegido la misma posición dos veces.

## Semilla y mecanismo son controles diferentes

set.seed controla el generador usado por estas operaciones. Reiniciar la misma semilla y ejecutar el mismo código permite repetir la muestra en ese entorno. No hace aleatoria una encuesta de conveniencia, no corrige no respuesta y no garantiza representatividad.

Con reemplazo se pueden seleccionar unidades varias veces. Sin reemplazo, una posición sale como máximo una vez. La práctica utiliza diez IDs y pide treinta selecciones: con reemplazo las repeticiones son inevitables; sin reemplazo esa petición no es posible.

## Variación entre muestras

El segundo ejemplo repite quinientas muestras de tamaño cincuenta y calcula sus medias. Las medias no son idénticas, aunque el mecanismo y el tamaño se conserven. Esa variación introduce la pregunta de cuánta incertidumbre acompaña a una estimación.

En esta simulación, la dispersión de las medias es menor que la de los valores individuales. No son la misma variable: una describe unidades y la otra resultados de un procedimiento de muestreo. Aumentar el tamaño puede reducir variación bajo un diseño apropiado, pero no elimina por sí solo un sesgo sistemático.

## Lo que la simulación demuestra

Una simulación permite observar el comportamiento del modelo que elegiste. Su alcance depende de población artificial, mecanismo y parámetros. No valida automáticamente una estrategia de recolección real ni demuestra que los datos observados hayan surgido de ese modelo.

La siguiente unidad usa intervalos y contrastes bajo supuestos explícitos. Antes de llegar a ellos debes poder decir qué unidades serían independientes, cómo se seleccionaron y qué fuentes de variación quedaron fuera del ejercicio.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Muestreo aleatorio con semilla

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Muestreo aleatorio con semilla
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
poblacion <- rep(0:9, each = 100)
set.seed(20261015)
a <- sample(poblacion, size = 50, replace = FALSE)
set.seed(20261015)
b <- sample(poblacion, size = 50, replace = FALSE)
stopifnot(identical(a, b), length(a) == 50, mean(poblacion) == 4.5)
cat("Población artificial: 1000; muestra: 50; repetición con semilla idéntica
")
cat("Una semilla controla el azar del código, no el sesgo de selección.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad14-muestreo/ejemplos/01.R
```

Salida esperada:

```text
Población artificial: 1000; muestra: 50; repetición con semilla idéntica
Una semilla controla el azar del código, no el sesgo de selección.
```

### Ejemplo 2. Variabilidad entre medias de muestras

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Variabilidad entre medias de muestras
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
poblacion <- rep(0:9, each = 100)
set.seed(23)
medias <- replicate(500, mean(sample(poblacion, 50, replace = FALSE)))
stopifnot(length(medias) == 500, length(unique(medias)) > 1, all(medias >= 0 & medias <= 9))
stopifnot(sd(medias) < sd(poblacion))
cat("Simulación: 500 muestras de 50; las medias varían entre muestras
")
cat("En esta simulación, su dispersión es menor que la de los valores individuales.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad14-muestreo/ejemplos/02.R
```

Salida esperada:

```text
Simulación: 500 muestras de 50; las medias varían entre muestras
En esta simulación, su dispersión es menor que la de los valores individuales.
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad13-descriptiva/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-inferencia/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2014%20%28Muestreo%2C%20simulaci%C3%B3n%20y%20variabilidad%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
