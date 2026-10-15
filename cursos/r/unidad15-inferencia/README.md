# Unidad 15. Intervalos, contrastes y diseño de comparación

[Anterior](../unidad14-muestreo/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-regresion/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Expresar parámetro, hipótesis, magnitud e incertidumbre.
- Diferenciar grupos independientes y datos pareados.
- Interpretar resultados sin convertir un p-valor en probabilidad de la hipótesis.

## Clase guiada. De la estimación a una conclusión condicionada

La inferencia requiere conectar un diseño de observación con un modelo y una población o parámetro de interés. No basta que t.test acepte un vector. Los datos de esta unidad son construidos para practicar el cálculo: las conclusiones se refieren al modelo del ejercicio y no demuestran resultados de una investigación real.

### 1. Declara qué cantidad quieres estimar

Para 8, 9, 10, 11, 12 calculamos una media 10. El parámetro del modelo es la media poblacional, que se distingue de esa media observada. n=5 cuenta observaciones; sd(x) describe dispersión muestral; sd(x)/sqrt(n) es el error estándar de la media bajo las condiciones del procedimiento.

El laboratorio calcula primero el error estándar y después el margen. qt(0.975, df=4) proporciona el cuantil de t para un intervalo bilateral de 95%: queda 2.5% en cada extremo del modelo de referencia. Multiplicar ese cuantil por el error estándar produce un margen aproximado 1.963. Restarlo y sumarlo a 10 da[8.037, 11.963].

### 2. Lee los componentes de la respuesta

t.test devuelve una lista con campos. estimate contiene la estimación; conf.int el intervalo; p.value el p-valor; parameter los grados de libertad y method la descripción del procedimiento. El operador $ extrae un campo, como aprendiste con listas. Guardar la respuesta como r permite inspeccionar sus partes sin depender del formato de una impresión completa.

El 95% corresponde a la cobertura nominal del procedimiento en repeticiones bajo sus supuestos. No significa que el 95% de individuos esté dentro del intervalo ni, en la lectura frecuentista, que el parámetro fijo tenga ahora 95% de probabilidad de pertenecer a ese intervalo observado.

### 3. Distingue estimar y contrastar

mu=10 declara la hipótesis nula del ejemplo de una media. Como la media observada es 10, el estadístico es 0 y el p-valor es 1. Eso no prueba igualdad exacta ni equivalencia. El p-valor evalúa extremidad bajo el modelo nulo y sus supuestos; no es la probabilidad de que la hipótesis sea verdadera.

### 4. El diseño decide si las mediciones se emparejan

Para grupos planteados como independientes, Welch estima media de x menos media de y y permite varianzas distintas. Con los vectores del Ejemplo 02 hay 5 y 6 observaciones y diferencia 4.2. Debes registrar esa dirección para interpretar el signo del intervalo. La independencia, el diseño y las condiciones distributivas siguen siendo importantes.

Si son las mismas personas antes y después, las diferencias se calculan dentro de cada ID. Unir por ID antes de restar evita que el orden inverso de un archivo compare personas distintas. El análisis pareado se aplica a las diferencias; no crea 12 unidades independientes al tener 6 personas medidas dos veces.

### 5. Redacta una conclusión que otra persona pueda revisar

Escribe parámetro, diseño, tamaños, estimación con unidad, intervalo, supuestos y límites. Una frase como «p<0.05, por tanto la modalidad causa mejores notas» omite tamaño, diseño y causalidad. Los ejercicios practican cálculo y lectura; elegir una prueba para datos reales exige revisar cómo se generaron y qué pregunta se formuló antes de ver resultados.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
x <- c(8, 9, 10, 11, 12)
n <- length(x)
media <- mean(x)
error_estandar <- sd(x) / sqrt(n)
cuantil <- qt(0.975, df = n - 1)
margen <- cuantil * error_estandar
intervalo <- c(media - margen, media + margen)
r <- t.test(x, mu = 10)
stopifnot(max(abs(intervalo - unname(r$conf.int[1:2]))) < 1e-10)
cat(sprintf("n=%d; media=%.3f; error estándar=%.3f\n", n, media, error_estandar))
cat(sprintf("Cuantil=%.3f; margen=%.3f; intervalo=[%.3f, %.3f]\n", cuantil, margen, intervalo[1], intervalo[2]))
cat("El intervalo corresponde a la media del modelo, no a individuos.\n")
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad15-inferencia/ejemplos/laboratorio.R
```

Salida esperada:

```text
n=5; media=10.000; error estándar=0.707
Cuantil=2.776; margen=1.963; intervalo=[8.037, 11.963]
El intervalo corresponde a la media del modelo, no a individuos.
```

### Lectura del laboratorio

La salida separa error estándar, cuantil, margen e intervalo. La comprobación compara el cálculo reconstruido con conf.int, sin copiar ese campo para construir la supuesta verificación manual. Así detectaría, por ejemplo, un denominador equivocado o un cuantil unilateral aplicado por accidente.

## Experimenta

En una copia cambia conf.level a 0.90 y usa qt(0.95, df=n-1) en el cálculo manual. El intervalo se estrecha con los mismos datos. Explica el cambio en la cobertura elegida; no lo presentes como si hubieras conseguido más observaciones o mejorado el diseño.

## Errores frecuentes

| Error | Pregunta que lo detecta |
|---|---|
| Interpretar IC como rango del 95% de individuos | ¿El parámetro es una media o una observación? |
| Leer p como probabilidad de la hipótesis | ¿Cuál es el modelo condicionado del cálculo? |
| Usar Welch para mediciones de la misma persona sin justificar | ¿Las unidades son independientes o pareadas? |
| Restar antes/después por posición | ¿Coinciden los IDs de cada par? |

## Autoevaluación

¿Qué cantidad representa el error estándar? ¿Por qué p=1 no prueba igualdad? ¿Qué supuesto de varianzas relaja Welch y qué condiciones conserva? ¿Por qué un archivo invertido no debe cambiar los pares?


## Un intervalo acompaña una estimación

Para una media, el ejercicio t utiliza la media observada, la desviación muestral, n y un cuantil de t. Bajo el diseño y supuestos correspondientes, el procedimiento tiene una cobertura nominal. El primer ejemplo construido produce media 10 e intervalo de 95% aproximadamente [8.037,11.963].

El 95% describe el comportamiento del procedimiento en repeticiones apropiadas, no una probabilidad frecuentista asignada después de observar al parámetro fijo. Tampoco es un intervalo que deba contener al 95% de las observaciones individuales. Consulta la explicación de [NIST](https://itl.nist.gov/div898/handbook/eda/section3/eda352.htm).

## Calcula el ejemplo antes de llamar la función

Para 8,9,10,11,12, la media es 10 y la suma de desviaciones cuadradas es 10. La varianza muestral es 10/4=2.5; su raíz es aproximadamente 1.581. El error estándar de la media es 1.581/raíz(5), aproximadamente 0.707.

| Paso | Valor del caso |
|---|---|
| Tamaño analizado | 5 |
| Media | 10 |
| Grados de libertad | 4 |
| Cuantil t para el intervalo bilateral de 95% | Aproximadamente 2.776 |
| Margen | Aproximadamente 1.963 |
| Intervalo | Aproximadamente [8.037, 11.963] |

El intervalo se construye como media ± cuantil × error estándar. En el modelo clásico exacto se consideran observaciones independientes de una población normal con varianza desconocida. El ejemplo permite seguir la cuenta; sus valores construidos no establecen que exista una población real con ese mecanismo. La desviación de los individuos y el error estándar de una media tienen unidades iguales pero significados diferentes.

## Supuestos antes de ejecutar t.test

Para este uso importan independencia de las unidades y condiciones distributivas apropiadas. Con muestras pequeñas, asimetrías y extremos pueden afectar el procedimiento. Ejecutar una prueba automática de normalidad no sustituye revisar diseño, datos y consecuencias de los supuestos.

Los datos de los ejercicios son construidos para practicar; no sostienen una inferencia sobre una población real. En la encuesta ficticia del proyecto se presenta descripción y no se añade un contraste por disponibilidad de la función.

## Qué pregunta un contraste

Una hipótesis nula declara un valor o relación, como media=10. El p-valor evalúa la extremidad de un estadístico observado respecto al modelo nulo y sus supuestos. No es la probabilidad de que la hipótesis sea verdadera ni una medida de tamaño o importancia del efecto. Un umbral aislado no reemplaza interpretación, magnitud e incertidumbre; revisa la [declaración de ASA](https://www.amstat.org/asa/files/pdfs/p-valuestatement.pdf).

En el primer ejemplo la media coincide con el valor nulo y p=1. Esto no demuestra que la media poblacional sea exactamente 10. Un resultado no incompatible con una hipótesis no la prueba ni establece equivalencia.

## Independientes y pareados son diseños distintos

El segundo ejemplo plantea dos grupos independientes y usa Welch, que no exige igualdad de varianzas. Todavía necesita independencia y condiciones para su aproximación. La diferencia construida es 4.2; acompáñala de su intervalo, tamaños y unidad.

Si mides antes/después a las mismas personas, analiza el emparejamiento. La solución une por ID aunque el archivo de después venga al revés y contrasta las diferencias dentro de seis pares. Restar vectores por posición podría comparar personas diferentes.

## Una conclusión completa

Declara pregunta, parámetro, diseño, tamaño analizado, estimación, intervalo, supuestos y límites. Si escoges muchas pruebas después de explorar resultados, considera ese proceso y la multiplicidad; no informes solo el resultado conveniente. Este curso introduce el razonamiento, no una receta universal para seleccionar pruebas.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Intervalo de una media y contraste declarado

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Intervalo de una media y contraste declarado
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(8, 9, 10, 11, 12)  # Datos construidos para practicar el cálculo.
r <- t.test(x, mu = 10, conf.level = 0.95)
stopifnot(unname(r$estimate) == 10, abs(r$p.value - 1) < 1e-12)
stopifnot(r$conf.int[1] < 10, r$conf.int[2] > 10)
cat(sprintf("n=5; media=10; IC95%%=[%.3f, %.3f]; p=%.3f
", r$conf.int[1], r$conf.int[2], r$p.value))
cat("Interpretación condicionada al diseño y supuestos; no prueba que la media sea exactamente 10.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad15-inferencia/ejemplos/01.R
```

Salida esperada:

```text
n=5; media=10; IC95%=[8.037, 11.963]; p=1.000
Interpretación condicionada al diseño y supuestos; no prueba que la media sea exactamente 10.
```

### Ejemplo 2. Dos grupos independientes y Welch

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Dos grupos independientes y Welch
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(12, 13, 11, 16, 14)
y <- c(8, 9, 10, 7, 12, 8)
r <- t.test(x, y, var.equal = FALSE)
diferencia <- mean(x) - mean(y)
stopifnot(grepl("Welch", r$method), abs(diferencia - 4.2) < 1e-12)
stopifnot(is.finite(r$p.value), r$conf.int[1] <= diferencia, r$conf.int[2] >= diferencia)
cat("Ejercicio construido: dos grupos independientes; diferencia de medias=4.2
")
cat("Welch no supone varianzas iguales; siguen importando independencia y distribución.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad15-inferencia/ejemplos/02.R
```

Salida esperada:

```text
Ejercicio construido: dos grupos independientes; diferencia de medias=4.2
Welch no supone varianzas iguales; siguen importando independencia y distribución.
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad14-muestreo/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-regresion/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2015%20%28Intervalos%2C%20contrastes%20y%20dise%C3%B1o%20de%20comparaci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
