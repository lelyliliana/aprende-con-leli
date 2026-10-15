# Muestreo aleatorio con semilla
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
poblacion <- rep(0:9, each = 100)
set.seed(20261015)
a <- sample(poblacion, size = 50, replace = FALSE)
set.seed(20261015)
b <- sample(poblacion, size = 50, replace = FALSE)
stopifnot(identical(a, b), length(a) == 50, mean(poblacion) == 4.5)
cat("Población artificial: 1000; muestra: 50; repetición con semilla idéntica
")
cat("Una semilla controla el azar del código, no el sesgo de selección.
")
