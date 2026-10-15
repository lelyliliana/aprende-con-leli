# Laboratorio guiado. Ejecutar desde cursos/r.
# El archivo contiene todas las entradas que necesita.
sin_parentesis <- 2 + 3 * 4
con_parentesis <- (2 + 3) * 4
print(sin_parentesis)
print(con_parentesis)
stopifnot(sin_parentesis == 14, con_parentesis == 20)
cat("Las dos expresiones se calcularon desde este archivo.\n")
