# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. La condición tiene una respuesta por posición.
x <- c(2, 4, 6, 8, 10)
mascara <- x >= 6
seleccion <- x[mascara]
stopifnot(identical(mascara, c(FALSE, FALSE, TRUE, TRUE, TRUE)))
stopifnot(identical(seleccion, c(6, 8, 10)))
cat("Paso 1: seleccionados=6,8,10.\n")
# Paso 2. Excluir produce otro resultado.
sin_primero <- x[-1]
stopifnot(identical(sin_primero, c(4, 6, 8, 10)), identical(x, c(2, 4, 6, 8, 10)))
cat("Paso 2: sin primero=4,6,8,10; original=2,4,6,8,10.\n")
# Paso 3. Columnas y reciclaje.
m <- matrix(1:6, nrow = 2)
stopifnot(identical(as.integer(m[1, ]), c(1L, 3L, 5L)))
r <- 1:4 + c(10, 20)
stopifnot(identical(r, c(11, 22, 13, 24)))
cat("Paso 3: filas de matriz=1,3,5 / 2,4,6; suma=11,22,13,24.\n")
# Reto. Combinar límites por elemento.
intermedios <- x[x >= 4 & x <= 8]
stopifnot(identical(intermedios, c(4, 6, 8)))
cat("Reto: intervalo cerrado de 4 a 8=4,6,8.\n")
