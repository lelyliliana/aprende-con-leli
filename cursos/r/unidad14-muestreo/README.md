# Unidad 14. Muestreo, simulación y variabilidad

[Anterior](../unidad13-descriptiva/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-inferencia/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Distinguir población, muestra y mecanismo de selección.
- Repetir un cálculo aleatorio con semilla.
- Separar variación muestral, sesgo y tamaño del estudio.

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
