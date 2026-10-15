# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
# Paso 1. La clasificación se puede contrastar fila por fila.
r <- limpiar_entrada()
esperada <- data.frame(fila = 1:8, duplicada = c(FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE),
  invalida = c(FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE, TRUE),
  aceptada = c(TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE))
stopifnot(identical(r$incidencias[c("fila", "duplicada", "invalida", "aceptada")], esperada))
cat("Paso 1: aceptadas=1,2,6; duplicada equivalente=3; inválidas=4,5,7,8.\n")
# Paso 2. La representación original y la cantidad interpretada son diferentes.
stopifnot(r$original$horas_semana[2] == "7,5", r$validas$horas_semana[2] == 7.5)
stopifnot(identical(r$validas$id, c("S01", "S02", "S05")), is.na(r$validas$horas_semana[3]))
cat("Paso 2: original conserva 7,5; candidato=7.5; vacío de S05 sigue NA.\n")
# Paso 3. Un mismo ID con puntajes incompatibles requiere revisión.
archivo <- tempfile(fileext = ".csv")
contradiccion <- r$original
contradiccion$puntaje[3] <- "81"
write.csv(contradiccion, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(limpiar_entrada(archivo), error = function(e) e)
stopifnot(inherits(error, "error"), grepl("contradictorio", conditionMessage(error)))
unlink(archivo)
cat("Paso 3: duplicado contradictorio rechazado.\n")
# Reto. Una incidencia de conversión no es un faltante de origen.
texto <- c(NA_character_, "texto", "0")
candidato <- suppressWarnings(as.numeric(texto))
fallo <- !is.na(texto) & is.na(candidato)
stopifnot(identical(fallo, c(FALSE, TRUE, FALSE)), candidato[3] == 0)
cat("Reto: una ausencia original, una conversión fallida y un cero observado.\n")
