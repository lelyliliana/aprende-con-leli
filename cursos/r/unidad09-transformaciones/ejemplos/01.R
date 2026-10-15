# Filtrar, crear y ordenar
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
r <- d |> dplyr::filter(grupo == "A", !is.na(horas_semana)) |>
  dplyr::mutate(minutos_semana = horas_semana * 60) |> dplyr::arrange(id)
stopifnot(nrow(r) == 17, all(r$minutos_semana == r$horas_semana * 60))
stopifnot(nrow(d) == 36, !"minutos_semana" %in% names(d))
cat("A con horas observadas:", nrow(r), "; el original conserva 36 filas
")
