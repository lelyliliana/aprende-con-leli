# Unidad 09. Transformar y resumir con dplyr

[Anterior](../unidad08-limpieza/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-uniones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Construir una secuencia legible de transformaciones.
- Separar cantidad de registros y cantidad observada.
- Controlar agrupación y estado del resultado.

## Clase guiada. Una transformación pequeña por verbo

dplyr ofrece operaciones con nombres que expresan qué cambia en una tabla. filter selecciona filas; select elige columnas; mutate crea o transforma columnas; arrange ordena filas; summarise produce resúmenes. group_by indica qué filas deben resumirse juntas. No todos esos verbos conservan la cantidad de registros.

### 1. Empieza por observar cada resultado intermedio

El laboratorio tiene cuatro IDs. X posee dos filas pero una hora conocida; Y posee dos filas y dos horas conocidas. filter(!is.na(horas)) conserva A, C, D. mutate(minutos=horas*60) añade la nueva unidad sin cambiar esas tres filas. El original d conserva sus cuatro registros y no incorpora minutos porque guardamos la transformación en otro nombre.

La expresión paquete::funcion identifica qué paquete aporta una operación. Así dplyr::filter no se confunde con otra función llamada filter. No hace falta cargar todos los paquetes del ecosistema para ejecutar estos ejemplos.

### 2. Lee la tubería de izquierda a derecha

El operador |> pasa el resultado de la izquierda como primer argumento de la llamada siguiente. d |> dplyr::group_by(grupo) se puede leer como «toma d y agrupa por grupo». La llamada posterior summarise recibe esa tabla agrupada. Una tubería no modifica por sí misma el objeto inicial: la asignación exterior determina qué nombre conserva la salida.

Dentro de los verbos escribimos nombres de columnas, como horas, sin d$. Esa forma pertenece a la evaluación de dplyr; fuera de ella, horas no aparece mágicamente como objeto de la consola. Si trabajas en R base, utiliza la selección de columnas que ya aprendiste.

### 3. Separa cantidad de filas y denominador de una media

En summarise, n() cuenta filas del grupo; sum(!is.na(horas)) cuenta cantidades conocidas. Para X se informa n=2, n_horas=1, media=2; para Y, n=2, n_horas=2, media=5. Una media sin denominador oculta esta diferencia de información.

| Operación | Filas del laboratorio | Qué representa la salida |
|---|---|---|
| Entrada | 4 | Personas ficticias |
| filter de horas conocidas | 3 | Personas con medición disponible |
| mutate de minutos | 3 | Las mismas personas, otra variable |
| summarise por grupo sobre la entrada | 2 | Un resumen por grupo |

### 4. Declara el caso sin mediciones

mean de un grupo totalmente faltante con na.rm=TRUE produce NaN. resumir_encuesta elige comunicar NA_real_ y n_horas=0. all(is.na(horas)) identifica ese caso antes de calcular. .groups="drop" devuelve el resumen sin agrupación para que una operación posterior no herede grupos sin que el lector lo advierta.

La selección del caso se explica por la información disponible, no por buscar el promedio que luzca mejor. Si el original tiene 36 participantes y filtras 17 con horas del grupo A, el resumen describe esos 17 observados, no todas las personas que podrían pertenecer al grupo en una población real.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(id = c("A", "B", "C", "D"), grupo = c("X", "X", "Y", "Y"),
                horas = c(2, NA_real_, 4, 6))
observadas <- dplyr::filter(d, !is.na(horas))
transformadas <- dplyr::mutate(observadas, minutos = horas * 60)
print(transformadas[c("id", "minutos")])
resumen <- d |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas)),
                   media = mean(horas, na.rm = TRUE), .groups = "drop")
print(as.data.frame(resumen))
stopifnot(nrow(d) == 4, !"minutos" %in% names(d), identical(resumen$n_horas, c(1L, 2L)))
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad09-transformaciones/ejemplos/laboratorio.R
```

Salida esperada:

```text
id minutos
1  A     120
2  C     240
3  D     360
  grupo n n_horas media
1     X 2       1     2
2     Y 2       2     5
```

### Lectura del laboratorio

La primera tabla muestra IDs A, C, D y minutos 120, 240, 360. La segunda resume la entrada completa, no esa selección: X conserva n=2 aunque solo se use una hora conocida. Se convierte a data.frame al imprimir para que la salida muestre la tabla completa sin abreviaturas de impresión de tibbles.

## Experimenta

Cambia la hora faltante de B por 6. Predice n=2, n_horas=2, media=4 para X. Después deja todas las horas de X como NA en una copia y revisa la política de resumir_encuesta con la encuesta del curso. El tamaño del grupo no cambia por dejar de conocer su medición.

## Errores frecuentes

| Error | Revisión |
|---|---|
| Tratar n() como observados de cualquier variable | Cuenta ausencias de la variable analizada |
| Usar summarise esperando conservar cada persona | Comprueba el cambio de unidad de salida |
| Promediar antes de revisar tipo | Inspecciona la columna y su diccionario |
| Ignorar grupos heredados | Consulta is_grouped_df y declara .groups |

## Autoevaluación

¿Qué diferencia hay entre mutate y summarise? ¿Por qué X tiene dos filas pero media basada en una sola cantidad? ¿Qué significa devolver NA y n_horas=0?


## Cada verbo responde a una operación

filter selecciona filas, select columnas, mutate crea o transforma columnas y arrange ordena. El operador |> pasa el resultado a la siguiente función. La secuencia hace visible qué cambia primero; no reemplaza la necesidad de revisar tipos y unidades.

El primer ejemplo conserva grupo A con horas observadas y calcula minutos_semana. El resultado tiene 17 filas. La tabla original sigue con 36 registros y no adquiere esa columna mientras no reasignes el resultado sobre ella. Esto permite conservar un punto de comparación.

## Agrupar cambia la unidad del cálculo

group_by define grupos y summarise produce resúmenes por grupo. Después de resumir por grupo, cada fila ya no representa una persona: representa un conjunto. Comparar tamaños antes/después requiere reconocer ese cambio de unidad.

En el archivo hay 18 participantes por grupo, pero A tiene 17 respuestas de horas y B tiene 16. n cuenta registros; sum(!is.na(horas_semana)) cuenta valores disponibles. La media de horas utiliza estos últimos. Una etiqueta n=18 junto a una media con 16 valores sería ambigua sin ambos denominadores.

## Faltantes y agrupación explícitos

El resumen del curso utiliza na.rm en la media de horas y conserva n_horas. Si un grupo no tiene ninguna hora observada, la función comunica NA y n_horas=0; no inventa una media cero. La ausencia puede reflejar un proceso de respuesta diferente que debe investigarse.

El argumento .groups="drop" devuelve un resultado sin agrupación residual. Dejar agrupación puede cambiar cómo actúe un cálculo posterior. No todo objeto impreso como tabla tiene el mismo estado: comprueba si sigue siendo grouped_df cuando eso importe.

## Orden y comparación

arrange(id) declara el orden que esperas. No dependas de una coincidencia con el archivo original si el flujo debería funcionar después de reordenar entradas. Para contrastar un filtro, puedes comparar sus IDs con una selección equivalente de R base.

## Traza del caso

36 registros entran al flujo. Filtrar grupo A deja 18; retirar horas ausentes deja 17; mutate agrega minutos; arrange ordena esos IDs. Un resumen de toda la encuesta por grupo produce dos filas, con n y n_horas diferentes. No debes combinar ambas salidas como si tuvieran la misma unidad.

La claridad de una tubería se evalúa por si puedes explicar entrada, resultado y precondición de cada paso, no por cuántos verbos caben en una sola línea.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Filtrar, crear y ordenar

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Filtrar, crear y ordenar
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
r <- d |> dplyr::filter(grupo == "A", !is.na(horas_semana)) |>
  dplyr::mutate(minutos_semana = horas_semana * 60) |> dplyr::arrange(id)
stopifnot(nrow(r) == 17, all(r$minutos_semana == r$horas_semana * 60))
stopifnot(nrow(d) == 36, !"minutos_semana" %in% names(d))
cat("A con horas observadas:", nrow(r), "; el original conserva 36 filas
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad09-transformaciones/ejemplos/01.R
```

Salida esperada:

```text
A con horas observadas: 17 ; el original conserva 36 filas
```

### Ejemplo 2. Resumen y denominador explícito

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Resumen y denominador explícito
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- resumir_encuesta(leer_encuesta())
stopifnot(identical(r$n, c(18L, 18L)), identical(r$n_horas, c(17L, 16L)))
stopifnot(!dplyr::is_grouped_df(r))
cat("Grupo A: n=18, horas observadas=17
Grupo B: n=18, horas observadas=16
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad09-transformaciones/ejemplos/02.R
```

Salida esperada:

```text
Grupo A: n=18, horas observadas=17
Grupo B: n=18, horas observadas=16
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad08-limpieza/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-uniones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2009%20%28Transformar%20y%20resumir%20con%20dplyr%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
