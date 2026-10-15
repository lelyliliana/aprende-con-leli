# Dos grupos independientes y Welch
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(12, 13, 11, 16, 14)
y <- c(8, 9, 10, 7, 12, 8)
r <- t.test(x, y, var.equal = FALSE)
diferencia <- mean(x) - mean(y)
stopifnot(grepl("Welch", r$method), abs(diferencia - 4.2) < 1e-12)
stopifnot(is.finite(r$p.value), r$conf.int[1] <= diferencia, r$conf.int[2] >= diferencia)
cat("Ejercicio construido: dos grupos independientes; diferencia de medias=4.2
")
cat("Welch no supone varianzas iguales; siguen importando independencia y distribución.
")
