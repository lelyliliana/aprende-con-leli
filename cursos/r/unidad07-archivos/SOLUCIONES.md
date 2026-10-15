# Soluciones razonadas de la Unidad 07

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Estructura y dominio

La encuesta tiene 36 filas, 6 columnas, ID de texto y 3 faltantes en horas. typeof de horas debe ser double con la lectura declarada. Leer sin error no basta: validar_encuesta revisa también esquema, identidad, categorías y dominios. Consulta el diccionario para justificar cada aceptación.

## Paso 2. Ida y vuelta

La copia conserva las seis columnas sin índice artificial. Releer con leer_encuesta permite contrastar tipos, valores y ausencias con identical. El archivo temporal se elimina al finalizar. Convertir "007" a 7 perdería ceros iniciales y no se justificaría solo porque los dígitos parecen un número.

## Paso 3. El problema pertenece a una fila y una columna

readr produce NA para "texto" en una columna numérica y problems identifica una incidencia con ese contenido real. La fila que contiene 3 sigue siendo numérica válida. Suprimir la advertencia en esta prueba es acotado: se inspecciona y se comprueba el fallo conocido, no se acepta silenciosamente la entrada.

## Reto de transferencia. Selección explícita

excel_sheets permite comprobar mtcars antes de leer. n_max=5 limita filas de datos y el resultado tiene 11 columnas. La hoja actual está incluida en la versión local y las versiones recientes probadas. Esa comprobación no garantiza nombres de hojas de otro libro personal.

## Respuestas de autoevaluación

colClasses declara interpretación de columnas; nrow cuenta filas. Escritura y lectura necesitan acordar la representación de ausencias. Antes de leer Excel revisa nombre de hoja, encabezado, región y tipos.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Leer, validar y describir la tabla del curso.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
tipos <- vapply(d, typeof, character(1))
stopifnot(nrow(d) == 36, ncol(d) == 6, sum(is.na(d$horas_semana)) == 3)
stopifnot(tipos[["id"]] == "character", tipos[["horas_semana"]] == "double")
cat("Paso 1: 36 filas, 6 columnas, ID de texto y 3 horas faltantes.\n")
# Paso 2. Exportación temporal sin índice artificial.
archivo <- tempfile(fileext = ".csv")
write.csv(d, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
copia <- leer_encuesta(archivo)
stopifnot(identical(d, copia), identical(names(d), names(copia)))
unlink(archivo)
stopifnot(as.numeric("007") == 7)
cat("Paso 2: ida y vuelta conserva datos, columnas y faltantes.\n")
# Paso 3. Identificar el dato que falló en la conversión.
archivo <- tempfile(fileext = ".csv")
writeLines(c("valor", "3", "texto"), archivo)
r <- suppressWarnings(readr::read_csv(archivo, col_types = readr::cols(valor = readr::col_double())))
problemas <- readr::problems(r)
stopifnot(nrow(problemas) == 1, problemas$actual[1] == "texto", is.na(r$valor[2]))
unlink(archivo)
cat("Paso 3: texto inválido identificado; el NA nuevo requiere revisión.\n")
# Reto. El libro es un recurso del paquete, no un archivo personal.
libro <- readxl::readxl_example("datasets.xlsx")
hojas <- readxl::excel_sheets(libro)
stopifnot("mtcars" %in% hojas)
excel <- readxl::read_excel(libro, sheet = "mtcars", n_max = 5)
stopifnot(nrow(excel) == 5, ncol(excel) == 11)
cat("Reto: hoja mtcars comprobada; 5 filas y 11 columnas leídas.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad07-archivos/solucion.R
```

Salida esperada:

```text
Paso 1: 36 filas, 6 columnas, ID de texto y 3 horas faltantes.
Paso 2: ida y vuelta conserva datos, columnas y faltantes.
Paso 3: texto inválido identificado; el NA nuevo requiere revisión.
Reto: hoja mtcars comprobada; 5 filas y 11 columnas leídas.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2007%20%28Importaci%C3%B3n%20y%20exportaci%C3%B3n%20de%20CSV%20y%20Excel%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
