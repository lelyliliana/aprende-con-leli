# Volver a ancho exige una clave
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
larga <- data.frame(id = c("P1", "P1", "P2", "P2"), momento = rep(c("antes", "despues"), 2), puntaje = c(50, 70, 60, 80))
stopifnot(!anyDuplicated(larga[c("id", "momento")]))
ancha <- tidyr::pivot_wider(larga, names_from = momento, values_from = puntaje)
stopifnot(identical(ancha$despues - ancha$antes, c(20, 20)))
duplicada <- rbind(larga, larga[1, ])
stopifnot(anyDuplicated(duplicada[c("id", "momento")]) > 0)
cat("Diferencia por persona: 20, 20; clave duplicada detectada antes de pivotar
")
