# Unidad 05. Listas y tablas de datos

[Anterior](../unidad04-faltantes-factores/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-funciones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Distinguir lista, matriz y data frame.
- Seleccionar columnas conservando su estructura cuando corresponda.
- Definir una clave según la unidad de observación.

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
