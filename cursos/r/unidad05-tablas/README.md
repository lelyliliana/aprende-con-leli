# Unidad 05. Listas y tablas de datos

[Anterior](../unidad04-faltantes-factores/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-funciones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Distinguir lista, matriz y data frame.
- Seleccionar columnas conservando su estructura cuando corresponda.
- Definir una clave según la unidad de observación.

## Clase guiada. Elegir una estructura según lo que representa

Una tabla de datos organiza variables en columnas y observaciones en filas. El laboratorio tiene tres personas, identificadas por A, B, C. Dos tienen el mismo número de horas (5), pero siguen siendo registros diferentes. Una tabla permite que id sea texto y horas sea número sin convertir toda la estructura a un tipo común.

### 1. Lee los dos lugares dentro del corchete

En d[filas, columnas], lo que va antes de la coma selecciona filas y lo que va después selecciona columnas. Un lugar vacío conserva todas las posiciones de esa dimensión. d[, "horas", drop=FALSE] selecciona esa columna para las tres filas y conserva una tabla. nrow y ncol deben indicar 3 y 1.

d[["horas"]] extrae el vector almacenado en la columna. Tiene tres elementos, pero ya no es una tabla de una columna. Esta diferencia importa si la siguiente operación espera nombres de columnas o un vector numérico. str y class ayudan a revisar la forma antes de llamar a otra función.

### 2. Selecciona filas sin confundir valor e identidad

La expresión d$horas == 5 produce TRUE, TRUE, FALSE. Usarla en las filas conserva A y B. El operador $ extrae una columna por nombre; la máscara se aplica a toda la tabla para conservar el ID al lado de su medición. Si extraes horas por separado y las reordenas, puedes perder esa correspondencia.

duplicated(d$id) investiga repetición de identificadores; duplicated(d$horas) investiga valores repetidos. Son preguntas diferentes. Un criterio de deduplicación debe partir de la clave prevista y no de que las cantidades se repitan.

### 3. Distingue una lista de su contenido

Una lista puede guardar piezas distintas: un texto id y un vector mediciones. registro["id"] produce otra lista con una pieza; registro[["id"]] extrae esa pieza y devuelve "A". Piensa en la diferencia entre una caja pequeña dentro de otra caja y el objeto que sacas de ella. La analogía ayuda, pero comprueba también is.list e is.character.

### 4. Define una clave para mediciones repetidas

Si una persona tiene dos momentos, el ID por sí solo deja de ser único. La combinación ID/momento puede distinguir cada medición. Comprobar anyDuplicated(d[c("id", "momento")]) revisa esa combinación de columnas. Un cero indica que no encontró combinaciones repetidas en esa tabla; todavía debes revisar claves vacías y coherencia del diseño.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(id = c("A", "B", "C"), horas = c(5, 5, 8))
columna <- d[, "horas", drop = FALSE]
valores <- d[["horas"]]
print(c(nrow(columna), ncol(columna)))
print(valores)
seleccion <- d[d$horas == 5, , drop = FALSE]
print(seleccion$id)
registro <- list(id = "A", mediciones = c(5, 6))
print(is.list(registro["id"]))
print(registro[["id"]])
stopifnot(nrow(seleccion) == 2, !anyDuplicated(d$id))
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad05-tablas/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] 3 1
[1] 5 5 8
[1] "A" "B"
[1] TRUE
[1] "A"
```

### Lectura del laboratorio

La primera impresión muestra 3, 1, dimensiones de la tabla conservada. La siguiente muestra 5, 5, 8, contenido del vector extraído. La consulta devuelve A, B. Finalmente TRUE confirma que [ conserva una lista y "A" muestra el valor extraído con [[. El objetivo es poder anticipar tanto el contenido como la estructura.

## Experimenta

Selecciona solo la fila C conservando las columnas id y horas; comprueba dimensiones 1×2. Después intercambia el orden de esas columnas y verifica que los nombres cambien de posición pero no la relación de C con sus ocho horas. Utiliza nombres explícitos cuando el contrato no deba depender del orden de las columnas.

## Errores frecuentes

| Confusión | Comprobación |
|---|---|
| Dos valores iguales son registros duplicados | Compara la clave que identifica observaciones |
| Una columna siempre conserva forma de tabla | Consulta class y usa drop=FALSE cuando haga falta |
| [ y [[ devuelven lo mismo en una lista | Revisa clase, longitud y contenido del resultado |
| Ordenar solo una columna ordena la tabla | Ordena las filas completas para conservar identidad |

## Autoevaluación

¿Qué significan los dos lugares de d[filas, columnas]? ¿Por qué d[["horas"]] puede enviarse a mean y d[, "horas", drop=FALSE] es otra estructura? ¿Cuándo necesitarías ID y momento como clave?


## Una tabla separa variables de tipos distintos

Un data.frame combina columnas de igual longitud que pueden tener tipos diferentes: id como texto y horas como número. Cada fila representa una observación definida por el análisis. A diferencia de la matriz, no exige convertir todas sus columnas al mismo tipo.

nrow y ncol responden cantidad de registros y variables. str permite revisar tipos. Antes de aplicar una función a una columna, comprueba que realmente sea una medición numérica y no etiquetas de texto que se parecen a números.

## Seleccionar una columna puede cambiar la forma

En R base, d[,"horas"] puede simplificarse a un vector. d[,"horas",drop=FALSE] conserva una tabla de una columna. No es un detalle puramente visual: una función que espera una tabla necesita esa forma para continuar seleccionando por nombres.

Una selección por condición en filas puede conservar varias observaciones con el mismo valor. Dos personas pueden tener cinco horas sin que exista un error de duplicación. La identidad del registro se decide por la clave, no por exigir que todas las columnas sean distintas.

## Una lista puede contener piezas diferentes

Una lista permite guardar id, un vector de mediciones y una marca lógica. registro["id"] conserva una lista de un elemento; registro[["id"]] extrae el valor almacenado. El operador $ accede por un nombre escrito directamente en el código; [[ permite usar un nombre calculado.

Elegir entre lista y tabla depende del contrato. Si cada participante tiene varias mediciones, una lista puede representarlas, pero para analizarlas por momento probablemente convenga otra tabla con ID/momento. La Unidad 11 desarrolla esa transformación.

## Clave y repetición legítima

Para una encuesta de una sola medición, ID debe ser único. En una tabla longitudinal, la clave puede ser ID y fecha. El mismo identificador repetido no basta para declarar duplicado si el diseño incluye mediciones sucesivas.

El primer ejemplo conserva una columna como tabla y selecciona dos registros. El segundo compara [ y [[. En la práctica dos valores iguales con IDs distintos siguen siendo dos observaciones válidas. Explica esa decisión antes de borrar filas con duplicated o distinct.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Una fila, una observación

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Una fila, una observación
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- data.frame(id = c("P1", "P2", "P3"), horas = c(2, 4, 6), stringsAsFactors = FALSE)
columna <- d[, "horas", drop = FALSE]
stopifnot(is.data.frame(columna), ncol(columna) == 1, nrow(d) == 3)
stopifnot(identical(d[d$horas >= 4, "id"], c("P2", "P3")))
cat("Tabla:", nrow(d), "filas y", ncol(d), "columnas
")
cat("Selección conservada como tabla:", is.data.frame(columna), "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad05-tablas/ejemplos/01.R
```

Salida esperada:

```text
Tabla: 3 filas y 2 columnas
Selección conservada como tabla: TRUE
```

### Ejemplo 2. Lista y control de identidad

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Lista y control de identidad
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
registro <- list(id = "P1", mediciones = c(12, 14, 15), observada = TRUE)
stopifnot(is.list(registro), length(registro$mediciones) == 3, is.list(registro["id"]))
stopifnot(identical(registro[["id"]], "P1"))
cat("Con [ se obtiene lista:", is.list(registro["id"]), "
")
cat("Con [[ se obtiene el valor:", registro[["id"]], "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad05-tablas/ejemplos/02.R
```

Salida esperada:

```text
Con [ se obtiene lista: TRUE
Con [[ se obtiene el valor: P1
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad04-faltantes-factores/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-funciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2005%20%28Listas%20y%20tablas%20de%20datos%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
