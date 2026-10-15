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
