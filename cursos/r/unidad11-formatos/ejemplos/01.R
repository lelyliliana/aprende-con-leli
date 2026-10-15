# Pasar mediciones a formato largo
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
ancha <- data.frame(id = c("P1", "P2"), antes = c(50, 60), despues = c(70, 80))
larga <- tidyr::pivot_longer(ancha, cols = c(antes, despues), names_to = "momento", values_to = "puntaje")
stopifnot(nrow(larga) == 4, length(unique(larga$id)) == 2)
stopifnot(!anyDuplicated(larga[c("id", "momento")]))
cat("2 personas, 2 momentos: 4 filas; no son 4 personas independientes
")
