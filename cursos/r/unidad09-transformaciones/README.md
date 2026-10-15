# Unidad 09. Transformar y resumir con dplyr

[Anterior](../unidad08-limpieza/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-uniones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Construir una secuencia legible de transformaciones.
- Separar cantidad de registros y cantidad observada.
- Controlar agrupación y estado del resultado.

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
