# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Declarar exactamente qué columnas son momentos.
ancha <- data.frame(id = c("A", "B"), antes = c(60, 70), despues = c(72, 75))
larga <- tidyr::pivot_longer(ancha, cols = c(antes, despues), names_to = "momento", values_to = "puntaje")
stopifnot(identical(names(larga), c("id", "momento", "puntaje")))
cat("Paso 1: clave de una fila larga=ID y momento.\n")
# Paso 2. No confundir mediciones con personas.
stopifnot(nrow(larga) == 4, length(unique(larga$id)) == 2)
stopifnot(nrow(unique(larga[c("id", "momento")])) == 4)
cat("Paso 2: 4 mediciones, 2 personas y 4 claves distintas.\n")
# Paso 3. Rechazar la ambigüedad antes de construir columnas.
a_ancho_seguro <- function(d) {
  if (anyNA(d$id) || anyNA(d$momento)) stop("Clave ausente")
  if (anyDuplicated(d[c("id", "momento")])) stop("Clave ID-momento duplicada")
  tidyr::pivot_wider(d, names_from = momento, values_from = puntaje)
}
vuelta <- a_ancho_seguro(larga)
cambios <- vuelta$despues - vuelta$antes
stopifnot(identical(cambios, c(12, 5)))
error <- tryCatch(a_ancho_seguro(rbind(larga, larga[1, ])), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 3: cambios A=12 y B=5; duplicado rechazado.\n")
# Reto. El orden puede variar; la clave y los valores deben conservarse.
invertida <- a_ancho_seguro(larga[4:1, ])
invertida <- invertida[order(invertida$id), ]
stopifnot(identical(invertida$id, vuelta$id), identical(invertida$despues - invertida$antes, cambios))
cat("Reto: invertir filas no altera los cambios después de ordenar por ID.\n")
