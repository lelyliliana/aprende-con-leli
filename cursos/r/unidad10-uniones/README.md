# Unidad 10. Unir tablas sin perder el control de las filas

[Anterior](../unidad09-transformaciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-formatos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Definir claves y cardinalidad antes de unir.
- Detectar expansión por duplicados y claves sin correspondencia.
- Distinguir conservación de filas de integridad del resultado.

## Clase guiada. Relacionar tablas por una clave

Una unión añade información relacionando claves. En el laboratorio cada persona tiene un grupo y el catálogo asocia grupo con modalidad. A aparece en dos personas, pero una sola vez en el catálogo. Esa relación es muchos a uno: varias filas de la izquierda pueden encontrar la misma fila de la derecha.

### 1. Dibuja las correspondencias antes de unir

P1/A encuentra A/Guiada; P2/A encuentra la misma modalidad; P3/C no encuentra ninguna fila del catálogo. B/Autónoma existe en el catálogo, pero no tiene personas asociadas en este ejemplo. La correspondencia depende de la clave, no de que las filas ocupen la misma posición.

| Persona | Clave | Resultado de buscar en el catálogo |
|---|---|---|
| P1 | A | Guiada |
| P2 | A | Guiada |
| P3 | C | Sin correspondencia |

### 2. Elige la conservación de filas según la pregunta

left_join conserva las tres personas y añade NA a la modalidad de P3. inner_join conserva solo las dos con coincidencia. anti_join devuelve las personas sin correspondencia y sirve para auditarlas. Una tabla interna más pequeña no demuestra que resolviste C: puede haber ocultado la fila que necesitaba investigación.

### 3. Comprueba la cardinalidad

Si el catálogo contiene dos filas con grupo A, P1 y P2 pueden encontrar dos correspondencias cada una y multiplicarse. relationship="many-to-one" exige que cada fila de la izquierda encuentre como máximo una fila de la derecha. Un rechazo aquí es información sobre un contrato incumplido. No lo «soluciones» retirando relationship sin decidir qué catálogo necesitas.

Ese argumento no exige que todas las claves existan: C puede producir NA en un left_join que cumple muchos a uno. Por eso combinamos dos revisiones, unicidad de catálogo y claves sin correspondencia. También revisamos filas e IDs antes y después.

### 4. Separa el experimento de los datos admitidos

El diccionario de encuesta admite A y B. Introducir C en una copia sirve para estudiar una falta de correspondencia; no convierte C en un grupo válido. Si la fuente real necesita otra categoría, tendrías que revisar diccionario, catálogo, validación e interpretación de manera coherente.

El orden del catálogo se puede invertir sin cambiar las modalidades de las personas. Esa es una comprobación útil de que relacionaste por clave y no por posición. En comparaciones posteriores ordena explícitamente por ID cuando el orden de filas no sea parte del contrato de tu operación.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
personas <- data.frame(id = c("P1", "P2", "P3"), grupo = c("A", "A", "C"))
catalogo <- data.frame(grupo = c("A", "B"), modalidad = c("Guiada", "Autónoma"))
unidas <- dplyr::left_join(personas, catalogo, by = "grupo", relationship = "many-to-one")
print(unidas)
sin_catalogo <- dplyr::anti_join(personas, catalogo, by = "grupo")
print(sin_catalogo$id)
interseccion <- dplyr::inner_join(personas, catalogo, by = "grupo", relationship = "many-to-one")
print(c(izquierda = nrow(unidas), interna = nrow(interseccion)))
stopifnot(nrow(unidas) == 3, is.na(unidas$modalidad[3]), identical(sin_catalogo$id, "P3"))
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad10-uniones/ejemplos/laboratorio.R
```

Salida esperada:

```text
id grupo modalidad
1 P1     A    Guiada
2 P2     A    Guiada
3 P3     C      <NA>
[1] "P3"
izquierda   interna
        3         2
```

### Lectura del laboratorio

La tabla izquierda tiene tres filas y una modalidad ausente. anti_join imprime P3. La última línea compara tamaños: izquierda=3, interna=2. Esas cifras solo tienen sentido junto a la explicación de qué filas se conservaron.

## Experimenta

Agrega una fila C/Otra al catálogo de laboratorio y predice qué cambiará: left seguirá con tres filas, inner pasará a tres y anti quedará vacía. Ese experimento cambia el catálogo artificial, no el diccionario oficial de la encuesta. En otra copia repite A e identifica por qué relationship rechaza la unión.

## Errores frecuentes

| Error | Evidencia para detectarlo |
|---|---|
| Unir por la posición de las filas | Invierte el catálogo y contrasta IDs/modalidad |
| Descartar desconocidos con inner sin auditarlos | Consulta anti_join antes de descartar |
| Aceptar más filas sin investigar | Comprueba unicidad de catálogo y cardinalidad |
| Confundir relación válida con cobertura completa | Revisa también claves sin coincidencia |

## Autoevaluación

¿Qué conserva left_join que puede perder inner_join? ¿Por qué dos personas del grupo A no violan muchos a uno? ¿Qué problema no evita por sí solo relationship?


## Una unión relaciona identidades

La encuesta contiene muchas personas de cada grupo y el catálogo describe una modalidad por grupo. La relación prevista es muchos a uno. Se une por grupo explícitamente; no por posición de fila ni por columnas coincidentes elegidas sin revisar.

left_join conserva los registros de la izquierda, pero puede repetirlos si encuentra varias correspondencias a la derecha. Por eso «usar left_join» no garantiza conservar el número de filas. La cardinalidad declarada y la comprobación posterior son parte del análisis.

## Predice la expansión

Si grupo A aparece dos veces en el catálogo, cada participante de A puede obtener dos filas. Sus puntajes quedarían duplicados para un resumen posterior. Una suma o media podría cambiar sin que se haya recolectado ninguna observación nueva.

El primer ejemplo declara relationship="many-to-one". Con el catálogo válido quedan 36 filas y una modalidad por ID. Al repetir la clave A del catálogo, dplyr rechaza la relación para las filas que encuentran múltiples coincidencias. Esa comprobación no demuestra por sí sola que todo catálogo posible esté completo o libre de claves extra nunca utilizadas; también puedes comprobar su clave única.

## Falta de correspondencia es otro problema

Una clave C en la encuesta no está en grupos.csv. anti_join permite identificar ese registro. left_join lo conserva con modalidad NA; inner_join lo excluiría. Elegir una operación sin auditar podría ocultar el registro en vez de resolver por qué su clave es desconocida.

En el segundo ejemplo se introduce C solo para estudiar auditoría; esa tabla no pasa la validación del diccionario de la encuesta. La práctica separa detección de un problema y aceptación de la tabla para el proyecto.

## Revisa el antes y el después

Registra cantidad de filas, cantidad de IDs distintos, claves duplicadas, claves sin correspondencia y faltantes nuevos en las columnas añadidas. Una coincidencia de n no prueba que se hayan unido los datos correctos; debes comprobar también la clave elegida y valores relevantes.

Una relación muchos a muchos puede ser válida, por ejemplo matrículas con varios cursos y varias personas. Necesita una unidad de resultado definida y no debe declararse aceptable solo para silenciar un error de cardinalidad. En este caso la modalidad es única por grupo y se exige esa relación.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Una unión muchos a uno comprobada

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Una unión muchos a uno comprobada
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
grupos <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
r <- dplyr::left_join(d, grupos, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(r) == nrow(d), !anyNA(r$modalidad), !anyDuplicated(r$id))
fallo <- tryCatch(dplyr::left_join(d, rbind(grupos, grupos[1, ]), by = "grupo", relationship = "many-to-one"), error = function(e) e)
stopifnot(inherits(fallo, "error"))
cat("Unión: 36 filas; clave de catálogo duplicada rechazada
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad10-uniones/ejemplos/01.R
```

Salida esperada:

```text
Unión: 36 filas; clave de catálogo duplicada rechazada
```

### Ejemplo 2. Buscar las claves sin correspondencia

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Buscar las claves sin correspondencia
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
d$grupo[1] <- "C"  # Escenario de auditoría, no pasa la validación del diccionario.
grupos <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
sin <- dplyr::anti_join(d, grupos, by = "grupo")
r <- dplyr::left_join(d, grupos, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(sin) == 1, sum(is.na(r$modalidad)) == 1, nrow(r) == 36)
cat("Sin correspondencia:", nrow(sin), "; left_join conserva las 36 filas
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad10-uniones/ejemplos/02.R
```

Salida esperada:

```text
Sin correspondencia: 1 ; left_join conserva las 36 filas
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad09-transformaciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-formatos/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2010%20%28Unir%20tablas%20sin%20perder%20el%20control%20de%20las%20filas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
