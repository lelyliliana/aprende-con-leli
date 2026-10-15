# Funciones compartidas del caso de encuesta. Se cargan desde la raíz del curso.
comprobar_raiz <- function() {
  if (!file.exists("Curso-R.Rproj")) stop("Abre cursos/r como proyecto o trabaja desde esa carpeta.")
  invisible(TRUE)
}

comprobar_paquetes <- function() {
  minimos <- c(dplyr = "1.1.0", tidyr = "1.3.0", ggplot2 = "3.4.0", readr = "2.1.0",
               readxl = "1.4.0", knitr = "1.40", rmarkdown = "2.20", jsonlite = "1.8.0")
  for (paquete in names(minimos)) {
    if (!requireNamespace(paquete, quietly = TRUE) ||
        utils::packageVersion(paquete) < package_version(minimos[[paquete]])) {
      stop("Falta ", paquete, " >= ", minimos[[paquete]], ". Ejecuta scripts/instalar_paquetes.R.")
    }
  }
  invisible(TRUE)
}

validar_encuesta <- function(d) {
  columnas <- c("id", "grupo", "edad", "horas_semana", "puntaje", "satisfaccion")
  if (!is.data.frame(d) || !identical(names(d), columnas)) stop("Columnas inesperadas")
  if (!nrow(d) || anyNA(d$id) || any(!nzchar(d$id)) || anyDuplicated(d$id)) stop("ID ausente o duplicado")
  if (anyNA(d$grupo) || any(!d$grupo %in% c("A", "B"))) stop("Grupo fuera del diccionario")
  if (!is.numeric(d$edad) || anyNA(d$edad) || any(!is.finite(d$edad) | d$edad < 18 | d$edad > 90)) stop("Edad fuera del dominio")
  if (!is.numeric(d$horas_semana) || any(!is.na(d$horas_semana) &
      (!is.finite(d$horas_semana) | d$horas_semana < 0 | d$horas_semana > 40))) stop("Horas fuera del dominio")
  if (!is.numeric(d$puntaje) || anyNA(d$puntaje) || any(!is.finite(d$puntaje) | d$puntaje < 0 | d$puntaje > 100)) stop("Puntaje fuera del dominio")
  if (any(!is.na(d$satisfaccion) & !d$satisfaccion %in% c("baja", "media", "alta"))) stop("Satisfacción desconocida")
  invisible(d)
}

leer_encuesta <- function(archivo = "datos/encuesta.csv") {
  d <- utils::read.csv(archivo, colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
                       na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
  validar_encuesta(d)
  d
}

limpiar_entrada <- function(archivo = "datos/encuesta_sucia.csv") {
  original <- utils::read.csv(archivo, colClasses = "character", na.strings = "", fileEncoding = "UTF-8")
  if (!identical(names(original), c("id", "grupo", "edad", "horas_semana", "puntaje", "satisfaccion"))) stop("Columnas inesperadas")
  limpio <- original
  limpio$id <- trimws(limpio$id)
  limpio$grupo <- toupper(trimws(limpio$grupo))
  for (columna in c("edad", "horas_semana", "puntaje")) {
    texto <- gsub(",", ".", trimws(limpio[[columna]]), fixed = TRUE)
    limpio[[columna]] <- suppressWarnings(as.numeric(texto))
  }
  if (anyNA(limpio$id) || any(!nzchar(limpio$id))) stop("ID ausente; revisar el archivo")
  for (id in unique(limpio$id[duplicated(limpio$id)])) {
    if (nrow(unique(limpio[limpio$id == id, , drop = FALSE])) > 1L) stop("Duplicado contradictorio; requiere revisión")
  }
  # Política de este archivo docente: conservar la primera aparición equivalente de un ID.
  duplicada <- duplicated(limpio$id)
  invalida <- is.na(limpio$edad) | limpio$edad < 18 | limpio$edad > 90 |
    (!is.na(limpio$horas_semana) & (limpio$horas_semana < 0 | limpio$horas_semana > 40)) |
    is.na(limpio$puntaje) | limpio$puntaje < 0 | limpio$puntaje > 100 |
    is.na(limpio$grupo) | !limpio$grupo %in% c("A", "B")
  # Una conversión fallida de horas no se confunde con el vacío permitido.
  invalida <- invalida | (!is.na(original$horas_semana) & is.na(limpio$horas_semana))
  aceptada <- !duplicada & !invalida
  validas <- limpio[aceptada, , drop = FALSE]
  validar_encuesta(validas)
  incidencias <- data.frame(fila = seq_len(nrow(original)), id = original$id,
                            duplicada = duplicada, invalida = invalida, aceptada = aceptada)
  list(validas = validas, incidencias = incidencias, original = original)
}

resumir_encuesta <- function(d) {
  validar_encuesta(d)
  dplyr::summarise(dplyr::group_by(d, grupo), n = dplyr::n(),
    n_horas = sum(!is.na(horas_semana)), media_horas = if (all(is.na(horas_semana))) NA_real_ else mean(horas_semana, na.rm = TRUE),
    media_puntaje = mean(puntaje), .groups = "drop")
}

figura_encuesta <- function(d) {
  validar_encuesta(d)
  ggplot2::ggplot(d, ggplot2::aes(x = grupo, y = puntaje, fill = grupo)) +
    ggplot2::geom_boxplot(width = 0.45, outlier.shape = NA) +
    ggplot2::geom_point(position = ggplot2::position_jitter(width = 0.07, height = 0, seed = 23),
                        alpha = 0.7, size = 1.8) +
    ggplot2::scale_fill_manual(values = c(A = "#235789", B = "#0a8277")) +
    ggplot2::labs(title = "Distribución de puntajes por grupo", x = "Grupo", y = "Puntaje (0 a 100)",
                   caption = "Datos ficticios del curso. Comparación descriptiva; no prueba un efecto causal.") +
    ggplot2::theme_minimal(base_size = 12) + ggplot2::theme(legend.position = "none")
}
