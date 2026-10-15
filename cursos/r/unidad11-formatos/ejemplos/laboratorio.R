# Laboratorio guiado. Ejecutar desde cursos/r.
ancha <- data.frame(id = c("A", "B"), antes = c(60, 70), despues = c(72, 75))
larga <- tidyr::pivot_longer(ancha, cols = c(antes, despues), names_to = "momento", values_to = "puntaje")
print(as.data.frame(larga))
print(c(personas = length(unique(larga$id)), mediciones = nrow(larga)))
vuelta <- tidyr::pivot_wider(larga, names_from = momento, values_from = puntaje)
print(vuelta$despues - vuelta$antes)
stopifnot(!anyDuplicated(larga[c("id", "momento")]), nrow(vuelta) == 2)
