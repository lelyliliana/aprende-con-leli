# Transferir al caso ambiental
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- read.csv("datos/ambiental.csv", na.strings = "", fileEncoding = "UTF-8")
d$fecha <- as.Date(d$fecha)
r <- d |> dplyr::group_by(estacion) |> dplyr::summarise(registros = dplyr::n(),
  observados = sum(!is.na(conteo)), total_observado = sum(conteo, na.rm = TRUE), .groups = "drop")
stopifnot(nrow(r) == 2, sum(r$registros) == 12, sum(r$observados) == 11)
cat("Caso ambiental ficticio: 12 registros, 11 conteos observados; 2 estaciones
")
cat("Un faltante no es cero y el total observado no mide por sí solo abundancia poblacional.
")
