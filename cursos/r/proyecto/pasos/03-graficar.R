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
figura <- ggplot2::ggplot(datos, ggplot2::aes(x = grupo, y = puntaje, fill = grupo)) +
  ggplot2::geom_boxplot(width = 0.45, outlier.shape = NA) +
  ggplot2::geom_point(position = ggplot2::position_jitter(width = 0.07, height = 0, seed = 23), alpha = 0.7) +
  ggplot2::labs(title = "Puntajes por grupo: construcción guiada", x = "Grupo", y = "Puntaje (0 a 100)",
    caption = "Datos ficticios. Descripción del archivo; no demuestra una causa.") +
  ggplot2::theme_minimal() + ggplot2::theme(legend.position = "none")
carpeta <- "salidas/construccion"
dir.create(carpeta, recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave(file.path(carpeta, "puntajes.svg"), figura, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(file.path(carpeta, "puntajes.svg"))$size > 1000)
cat("Etapa 3: SVG en salidas/construccion/puntajes.svg.\n")
