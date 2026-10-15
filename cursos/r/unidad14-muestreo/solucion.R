# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Repetir requiere restablecer la semilla antes de la misma operación.
poblacion <- rep(0:9, each = 100)
set.seed(20261015)
a <- sample(poblacion, 50, replace = FALSE)
set.seed(20261015)
b <- sample(poblacion, 50, replace = FALSE)
set.seed(20261016)
copia_otra_semilla <- sample(poblacion, 50, replace = FALSE)
stopifnot(identical(a, b), length(copia_otra_semilla) == 50)
cat("Paso 1: misma semilla reproduce la muestra; otra semilla inicia otra secuencia.\n")
# Paso 2. Guardar una media por muestra.
set.seed(23)
medias <- replicate(500, mean(sample(poblacion, 50, replace = FALSE)))
stopifnot(length(medias) == 500, sd(medias) < sd(poblacion))
cat("Paso 2: 500 medias; su dispersión es menor en esta simulación.\n")
# Paso 3. Imposibilidad de obtener 30 IDs distintos de solo 10.
unidades <- 1:10
set.seed(7)
muestra <- sample(unidades, 30, replace = TRUE)
error <- tryCatch(sample(unidades, 30, replace = FALSE), error = function(e) e)
stopifnot(length(muestra) == 30, anyDuplicated(muestra) > 0, inherits(error, "error"))
cat("Paso 3: con reemplazo se repiten IDs; sin reemplazo la petición es imposible.\n")
# Reto. La media de las primeras 100 unidades muestra un mecanismo sesgado.
sesgada <- poblacion[1:100]
stopifnot(mean(sesgada) == 0, mean(poblacion) == 4.5)
cat("Reto: primeras 100 unidades, media=0; población artificial, media=4.5.\n")
cat("Una semilla no corrige un mecanismo de selección sesgado.\n")
