# Unidad 07. Importación y exportación de CSV y Excel

[Anterior](../unidad06-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-limpieza/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Declarar tipos, codificación y significado de los vacíos.
- Comprobar incidencias de lectura antes de analizar.
- Verificar una exportación sin agregar columnas accidentales.

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
