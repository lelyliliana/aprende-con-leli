# Laboratorio guiado. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
original <- leer_encuesta()
copia <- original
copia$puntaje[1] <- copia$puntaje[1] + 1
validar_encuesta(copia)
a <- resumir_encuesta(original)
b <- resumir_encuesta(copia)
grupo_cambiado <- original$grupo[1]
diferencia <- b$media_puntaje[b$grupo == grupo_cambiado] - a$media_puntaje[a$grupo == grupo_cambiado]
stopifnot(abs(diferencia - 1 / 18) < 1e-10, identical(original, leer_encuesta()))
cat("Una modificación de +1 cambia la media de su grupo en 1/18.\n")
cat("La copia cambia; el archivo original y sus 36 registros se conservan.\n")
