# Unidad 07. Importación y exportación de CSV y Excel

[Anterior](../unidad06-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-limpieza/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Declarar tipos, codificación y significado de los vacíos.
- Comprobar incidencias de lectura antes de analizar.
- Verificar una exportación sin agregar columnas accidentales.

## Clase guiada. Importar es interpretar una representación

Un CSV es texto organizado con un separador. No guarda por sí mismo todos los tipos y reglas de la tabla que representa. La primera línea suele contener nombres de columnas; cada línea posterior aporta campos. Una coma dentro de un campo puede estar protegida por comillas. No conviene abrir el archivo y reemplazar todas las comas sin conocer su función.

### 1. Reconoce encabezado, separador y ausencia

El laboratorio construye un archivo pequeño con encabezado id, horas. La fila 007, 2.5 contiene un identificador textual y una cantidad; 008, deja vacío el segundo campo. na.strings="" declara que ese vacío significa ausencia. colClasses fija texto para la primera columna y número para la segunda: así 007 conserva sus tres caracteres.

tempfile propone una ruta temporal y writeLines escribe allí las líneas. Ese recurso permite experimentar sin alterar la encuesta del curso. unlink elimina el archivo temporal cuando termina la comprobación. No uses esa instrucción con una carpeta personal que quieras conservar.

### 2. Verifica estructura antes de calcular

Después de read.csv, consulta names, nrow, ncol y str. Si esperabas dos columnas y aparece una, revisa el separador; si una medición aparece como texto, busca formatos mezclados. La importación no termina cuando ves una tabla: contrasta nombres, tipos, filas, faltantes y dominio con el diccionario.

| Elemento del archivo | Interpretación declarada | Comprobación |
|---|---|---|
| 007 | Identificador textual | Conserva ceros iniciales |
| 2.5 | Horas numéricas | Puede participar en un cálculo |
| Campo vacío | NA permitido | Se cuenta como ausencia, no como cero |

La función leer_encuesta del curso concentra estas decisiones para el archivo de 36 filas. source carga su definición desde src/curso.R; leer_encuesta() la llama. Abre su implementación para reconocer read.csv y validar_encuesta. Usar una función compartida evita copiar reglas distintas en cada unidad, pero debes saber qué verifica.

### 3. Exporta una copia y vuelve a leerla

write.csv puede escribir nombres de fila como columna adicional. row.names=FALSE evita ese índice artificial. na="" mantiene la convención del archivo docente, y fileEncoding="UTF-8" declara la codificación de texto. Ninguna de estas opciones sustituye el diccionario. Una ida y vuelta comprueba que tu escritura y tu lectura acuerdan una representación.

### 4. Investiga las conversiones fallidas

readr permite declarar cada columna con col_types. Si esperaba número y encuentra "texto", puede producir NA y registrar el problema. problems devuelve las incidencias para inspeccionar fila, columna y contenido real. La solución captura esa advertencia únicamente porque después comprueba la incidencia prevista; no recomienda ocultar advertencias de archivos desconocidos.

Excel añade hojas y regiones. Primero consulta excel_sheets y elige sheet por nombre. El ejemplo utiliza mtcars del libro incluido en readxl. No hace falta un archivo personal ni instalar Excel para leerlo con este paquete.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
archivo <- tempfile(fileext = ".csv")
writeLines(c("id,horas", "007,2.5", "008,"), archivo)
d <- read.csv(archivo, colClasses = c("character", "numeric"), na.strings = "")
print(names(d))
print(d$id)
print(d$horas)
print(c(filas = nrow(d), columnas = ncol(d), faltantes = sum(is.na(d$horas))))
stopifnot(identical(d$id, c("007", "008")), sum(is.na(d$horas)) == 1)
unlink(archivo)
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad07-archivos/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] "id"    "horas"
[1] "007" "008"
[1] 2.5  NA
    filas  columnas faltantes
        2         2         1
```

### Lectura del laboratorio

Las impresiones muestran los nombres id, horas, los textos "007", "008", las cantidades 2.5 y NA, y el resumen 2 filas, 2 columnas, 1 faltante. Cada salida responde una pregunta diferente. Comprobar solo nrow no detectaría una conversión indebida del identificador.

## Experimenta

En una copia del laboratorio, cambia el segundo campo vacío por 0. Predice que el número de filas seguirá siendo dos y los faltantes bajarán a cero. Después vuelve a dejarlo vacío. Así puedes explicar por qué el tamaño de la tabla no informa cuántas mediciones están disponibles.

## Errores frecuentes

| Señal | Qué revisar |
|---|---|
| Tabla con una sola columna inesperada | Separador real del archivo |
| Ceros iniciales perdidos | Tipo declarado para el identificador |
| Aparece una columna X al releer | Se exportaron nombres de fila |
| Aumentaron los NA | Problemas de conversión frente a ausencias de origen |

## Autoevaluación

¿Qué aporta colClasses que no aporta nrow? ¿Por qué exportar y releer necesita las mismas reglas de ausencia? ¿Qué revisarías antes de elegir una hoja Excel?


## Un archivo no es todavía una tabla validada

CSV almacena texto separado por delimitadores. La extensión no declara tipos ni unidades. Una lectura puede parecer correcta y conservar horas como texto por una coma decimal o una etiqueta inesperada. Antes de analizar, revisa nombres, dimensiones, tipos y problemas de conversión.

El archivo del curso usa coma como separador, punto decimal, UTF-8 y campos vacíos para faltantes permitidos. El diccionario indica cuáles pueden faltar. Esa convención no es universal: otra exportación puede usar punto y coma, coma decimal o códigos como -99 que requieren una política explícita.

## Leer con un contrato

leer_encuesta declara seis columnas y valida ID único, grupos A/B, edades, horas y puntajes. El proyecto rechaza una entrada fuera del contrato antes de generar resultados. En esta unidad puedes leer su implementación como una función de apoyo; la siguiente estudia cómo auditar una entrada sucia.

El primer ejemplo lee 36 filas y tres faltantes de horas. Después escribe una copia temporal con row.names=FALSE. Omitir esa opción puede agregar índices de fila como una columna extra al exportar. La lectura de vuelta se compara con el objeto original, incluyendo los faltantes.

## readr y las conversiones fallidas

readr permite declarar col_types y consultar problems. Un texto dentro de una columna declarada numérica puede convertirse en NA y registrar una incidencia. Si ignoras esa incidencia, mezclarás un fallo de conversión con un faltante legítimo. Suprimir una advertencia para revisar problems en una práctica controlada no significa aceptar silenciosamente la pérdida de información.

El segundo ejemplo comprueba que no existan problemas en el CSV correcto. En la solución se provoca una conversión fallida y se verifica que quede registrada. La lectura exitosa del archivo no sustituye las reglas de su diccionario.

## Excel se interpreta por hoja y región

Un libro puede contener varias hojas y encabezados que no empiezan en la primera fila. Consulta excel_sheets antes de elegir sheet. El ejemplo usa datasets.xlsx incluido en readxl y lee cinco filas de la hoja mtcars; el estudiante no necesita aportar un archivo propio. La hoja mtcars está incluida tanto en la versión comprobada de readxl como en las versiones recientes del paquete; consulta siempre los nombres reales antes de leer un libro.

Si un identificador tiene ceros iniciales, revisa su tipo de origen y lectura. Los formatos visuales de una celda no necesariamente representan el valor subyacente como texto. Evita concluir que una conversión conserva información solo porque se ve igual en pantalla.

## Exportar y volver a comprobar

Una entrega debe poder leerse de nuevo con el mismo contrato. Usa codificación declarada, conserva faltantes y registra delimitador/unidades. Los archivos temporales de los ejemplos se eliminan al terminar; no reemplazan un archivo personal.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. CSV con tipos y faltantes declarados

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# CSV con tipos y faltantes declarados
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
stopifnot(nrow(d) == 36, sum(is.na(d$horas_semana)) == 3)
carpeta <- tempfile("csv-")
dir.create(carpeta)
archivo <- file.path(carpeta, "copia.csv")
write.csv(d, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
copia <- leer_encuesta(archivo)
stopifnot(isTRUE(all.equal(d, copia)))
unlink(carpeta, recursive = TRUE)
cat("CSV: 36 filas, 3 faltantes en horas; ida y vuelta conservada
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad07-archivos/ejemplos/01.R
```

Salida esperada:

```text
CSV: 36 filas, 3 faltantes en horas; ida y vuelta conservada
```

### Ejemplo 2. readr y un libro Excel de ejemplo

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# readr y un libro Excel de ejemplo
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- readr::read_csv("datos/encuesta.csv", na = "", show_col_types = FALSE,
  col_types = readr::cols(id = readr::col_character(), grupo = readr::col_character(), edad = readr::col_double(),
    horas_semana = readr::col_double(), puntaje = readr::col_double(), satisfaccion = readr::col_character()))
stopifnot(nrow(readr::problems(d)) == 0, nrow(d) == 36)
libro <- readxl::readxl_example("datasets.xlsx")
hojas <- readxl::excel_sheets(libro)
excel <- readxl::read_excel(libro, sheet = "mtcars", n_max = 5)
stopifnot("mtcars" %in% hojas, nrow(excel) == 5, ncol(excel) == 11)
cat("readr: sin problemas de lectura; Excel mtcars: 5 filas y 11 columnas
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad07-archivos/ejemplos/02.R
```

Salida esperada:

```text
readr: sin problemas de lectura; Excel mtcars: 5 filas y 11 columnas
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad06-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-limpieza/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2007%20%28Importaci%C3%B3n%20y%20exportaci%C3%B3n%20de%20CSV%20y%20Excel%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
