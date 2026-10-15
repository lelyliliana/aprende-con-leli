# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
resumen <- datos |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas_semana)),
    media_horas = if (all(is.na(horas_semana))) NA_real_ else mean(horas_semana, na.rm = TRUE),
    media_puntaje = mean(puntaje), .groups = "drop")
stopifnot(nrow(resumen) == 2, sum(resumen$n) == 36, sum(resumen$n_horas) == 33)
cat("Etapa 2: 2 grupos; n=18/18; n_horas=17/16.\n")
