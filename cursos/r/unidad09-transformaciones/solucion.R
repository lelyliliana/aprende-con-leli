# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
# Paso 1. Filtrar no significa sobrescribir el original.
a <- d |> dplyr::filter(puntaje >= 80) |> dplyr::arrange(id)
stopifnot(all(a$puntaje >= 80), nrow(d) == 36, !anyDuplicated(a$id))
cat("Paso 1: filtro de puntajes aplicado; el original conserva 36 filas.\n")
# Paso 2. Implementación independiente y orden comparable.
b <- d[d$puntaje >= 80, , drop = FALSE]
b <- b[order(b$id), , drop = FALSE]
stopifnot(identical(a$id, b$id))
cat("Paso 2: los mismos IDs con dplyr y R base.\n")
# Paso 3. Mostrar el denominador y comprobar el grupo sin observaciones.
resumen <- resumir_encuesta(d)
stopifnot(identical(resumen$n, c(18L, 18L)), identical(resumen$n_horas, c(17L, 16L)))
sin_horas_a <- d
sin_horas_a$horas_semana[sin_horas_a$grupo == "A"] <- NA_real_
r <- resumir_encuesta(sin_horas_a)
stopifnot(r$n_horas[r$grupo == "A"] == 0L, is.na(r$media_horas[r$grupo == "A"]))
stopifnot(!is.nan(r$media_horas[r$grupo == "A"]), !dplyr::is_grouped_df(r))
cat("Paso 3: n=18/18; n_horas=17/16; un grupo sin horas devuelve NA y n_horas=0.\n")
# Reto. Mutate conserva filas y transforma la unidad.
con_minutos <- d |> dplyr::mutate(minutos_semana = horas_semana * 60)
stopifnot(nrow(con_minutos) == 36, sum(is.na(con_minutos$minutos_semana)) == 3)
stopifnot(all(con_minutos$minutos_semana == con_minutos$horas_semana * 60, na.rm = TRUE))
cat("Reto: minutos calculados, 36 filas y 3 faltantes conservados.\n")
