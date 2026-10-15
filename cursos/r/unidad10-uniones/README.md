# Unidad 10. Unir tablas sin perder el control de las filas

[Anterior](../unidad09-transformaciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-formatos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Definir claves y cardinalidad antes de unir.
- Detectar expansión por duplicados y claves sin correspondencia.
- Distinguir conservación de filas de integridad del resultado.

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
