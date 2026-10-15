# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
catalogo <- read.csv("datos/grupos.csv", fileEncoding = "UTF-8")
# Paso 1. Catálogo único por grupo.
stopifnot(!anyNA(catalogo$grupo), !anyDuplicated(catalogo$grupo))
r <- dplyr::left_join(d, catalogo, by = "grupo", relationship = "many-to-one")
cat("Paso 1: catálogo con clave única; unión muchos a uno.\n")
# Paso 2. Conservar identidad y rechazar multiplicación de filas.
stopifnot(nrow(r) == nrow(d), identical(r$id, d$id), !anyNA(r$modalidad))
duplicado <- rbind(catalogo, catalogo[1, ])
error <- tryCatch(dplyr::left_join(d, duplicado, by = "grupo", relationship = "many-to-one"), error = function(e) e)
stopifnot(inherits(error, "error"))
cat("Paso 2: 36 filas e IDs conservados; catálogo duplicado rechazado.\n")
# Paso 3. Auditar el escenario inválido sin aceptarlo como encuesta válida.
con_c <- d
con_c$grupo[1] <- "C"
sin <- dplyr::anti_join(con_c, catalogo, by = "grupo")
interna <- dplyr::inner_join(con_c, catalogo, by = "grupo", relationship = "many-to-one")
izquierda <- dplyr::left_join(con_c, catalogo, by = "grupo", relationship = "many-to-one")
stopifnot(nrow(sin) == 1, sin$id == d$id[1], nrow(interna) == 35, nrow(izquierda) == 36)
stopifnot(sum(is.na(izquierda$modalidad)) == 1)
cat("Paso 3: anti_join identifica 1 fila; inner conserva 35 y left conserva 36.\n")
# Reto. El orden del catálogo no debe decidir la correspondencia.
invertido <- dplyr::left_join(d, catalogo[2:1, ], by = "grupo", relationship = "many-to-one")
stopifnot(identical(invertido$id, r$id), identical(invertido$modalidad, r$modalidad))
cat("Reto: invertir el catálogo conserva modalidades e identidad.\n")
