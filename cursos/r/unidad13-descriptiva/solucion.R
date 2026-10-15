# Solución ejecutable. Intentar primero la práctica.
x <- c(10, 11, 12, 13, 100)
resumen <- c(n = length(x), media = mean(x), mediana = median(x), minimo = min(x), maximo = max(x))
stopifnot(resumen[["media"]] == 29.2, resumen[["mediana"]] == 12)
cat("n=5; media=29.2; mediana=12; mínimo=10; máximo=100\n")
cat("Antes de excluir 100, se revisan origen, unidad y criterio de aceptación.\n")
