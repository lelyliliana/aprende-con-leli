# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Estimación e intervalo de una media.
x <- c(8, 9, 10, 11, 12)
una_media <- t.test(x, mu = 10)
stopifnot(mean(x) == 10, abs(una_media$p.value - 1) < 1e-12)
cat(sprintf("Paso 1: media=10; IC95%%=[%.3f, %.3f]; parámetro=media.\n", una_media$conf.int[1], una_media$conf.int[2]))
# Paso 2. Dirección explícita: media de x menos media de y.
x <- c(12, 13, 11, 16, 14)
y <- c(8, 9, 10, 7, 12, 8)
welch <- t.test(x, y, var.equal = FALSE)
diferencia <- mean(x) - mean(y)
stopifnot(abs(diferencia - 4.2) < 1e-12, grepl("Welch", welch$method))
cat(sprintf("Paso 2: n_x=5; n_y=6; diferencia=4.2; IC95%%=[%.3f, %.3f].\n", welch$conf.int[1], welch$conf.int[2]))
# Paso 3. Emparejar por identidad antes de restar.
antes <- data.frame(id = 1:6, puntaje = c(60, 65, 70, 75, 80, 85))
despues <- data.frame(id = 6:1, puntaje = rev(antes$puntaje + c(1, 2, 1, 3, 2, 3)))
pares <- dplyr::inner_join(antes, despues, by = "id", suffix = c("_antes", "_despues"), relationship = "one-to-one")
stopifnot(nrow(pares) == 6, !anyNA(pares))
cambios <- pares$puntaje_despues - pares$puntaje_antes
pareada <- t.test(pares$puntaje_despues, pares$puntaje_antes, paired = TRUE)
stopifnot(identical(cambios, c(1, 2, 1, 3, 2, 3)), abs(unname(pareada$estimate) - 2) < 1e-12)
cat("Paso 3: seis pares; cambios=1,2,1,3,2,3; cambio medio=2.\n")
# Reto. Comprobar el cálculo manual de Welch con las mismas entradas.
error_estandar <- sqrt(var(x) / length(x) + var(y) / length(y))
gl <- (var(x) / length(x) + var(y) / length(y))^2 /
  ((var(x) / length(x))^2 / (length(x) - 1) + (var(y) / length(y))^2 / (length(y) - 1))
manual <- diferencia + c(-1, 1) * qt(0.975, df = gl) * error_estandar
stopifnot(max(abs(manual - unname(welch$conf.int[1:2]))) < 1e-10)
cat("Reto: intervalo de Welch contrastado con error estándar y grados de libertad.\n")
