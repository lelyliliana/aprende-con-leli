# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Dos valores iguales pueden pertenecer a personas distintas.
d <- data.frame(id = c("A", "B", "C"), valor = c(5, 5, 8))
r <- d[d$valor == 5, , drop = FALSE]
stopifnot(!anyDuplicated(d$id), nrow(r) == 2, identical(r$id, c("A", "B")))
cat("Paso 1: los IDs A y B comparten valor 5; ambos se conservan.\n")
# Paso 2. Forma explícita de tabla de una columna.
columna <- d[, "valor", drop = FALSE]
stopifnot(is.data.frame(columna), nrow(columna) == 3, ncol(columna) == 1)
cat("Paso 2: tabla de 3 filas y 1 columna.\n")
# Paso 3. Contenedor y contenido.
lista <- list(id = "A", valores = c(5, 8))
stopifnot(is.list(lista["id"]), identical(lista[["id"]], "A"))
mediciones <- data.frame(id = c("A", "A", "B", "B"), momento = c(1, 2, 1, 2))
stopifnot(anyDuplicated(mediciones$id) > 0, !anyDuplicated(mediciones[c("id", "momento")]))
cat("Paso 3: [ conserva lista; [[ extrae texto; la clave repetida es ID y momento.\n")
# Reto. Detectar repetición de una medición, no de una persona.
con_error <- rbind(mediciones, mediciones[1, ])
stopifnot(anyDuplicated(con_error[c("id", "momento")]) == 5L)
cat("Reto: la quinta fila repite la clave de la primera.\n")
