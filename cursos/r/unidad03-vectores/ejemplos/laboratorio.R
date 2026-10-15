# Laboratorio guiado. Ejecutar desde cursos/r.
horas <- c(2, 4, 6, 8)
mascara <- horas >= 6
print(mascara)
seleccion <- horas[mascara]
print(seleccion)
print(horas[-1])
m <- matrix(1:6, nrow = 2)
print(m)
stopifnot(identical(seleccion, c(6, 8)), m[1, 2] == 3)
