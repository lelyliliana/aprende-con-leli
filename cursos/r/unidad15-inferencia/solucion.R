# Solución ejecutable. Intentar primero la práctica.
antes <- data.frame(id = 1:6, puntaje = c(60, 65, 70, 75, 80, 85))
despues <- data.frame(id = 6:1, puntaje = rev(antes$puntaje + c(1, 2, 1, 3, 2, 3)))
pares <- dplyr::inner_join(antes, despues, by = "id", suffix = c("_antes", "_despues"), relationship = "one-to-one")
stopifnot(nrow(pares) == 6, !anyNA(pares))
cambios <- pares$puntaje_despues - pares$puntaje_antes
r <- t.test(pares$puntaje_despues, pares$puntaje_antes, paired = TRUE)
stopifnot(mean(cambios) == 2, abs(unname(r$estimate) - 2) < 1e-12)
cat("Seis pares unidos por ID; cambio medio=2; se analiza la diferencia dentro de cada persona\n")
