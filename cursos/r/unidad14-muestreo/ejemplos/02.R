# Variabilidad entre medias de muestras
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
poblacion <- rep(0:9, each = 100)
set.seed(23)
medias <- replicate(500, mean(sample(poblacion, 50, replace = FALSE)))
stopifnot(length(medias) == 500, length(unique(medias)) > 1, all(medias >= 0 & medias <= 9))
stopifnot(sd(medias) < sd(poblacion))
cat("Simulación: 500 muestras de 50; las medias varían entre muestras
")
cat("En esta simulación, su dispersión es menor que la de los valores individuales.
")
