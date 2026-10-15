# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(id = c("A", "B", "C", "D"), grupo = c("X", "X", "Y", "Y"),
                horas = c(2, NA_real_, 4, 6))
observadas <- dplyr::filter(d, !is.na(horas))
transformadas <- dplyr::mutate(observadas, minutos = horas * 60)
print(transformadas[c("id", "minutos")])
resumen <- d |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas)),
                   media = mean(horas, na.rm = TRUE), .groups = "drop")
print(as.data.frame(resumen))
stopifnot(nrow(d) == 4, !"minutos" %in% names(d), identical(resumen$n_horas, c(1L, 2L)))
