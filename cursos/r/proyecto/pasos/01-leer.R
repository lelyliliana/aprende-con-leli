# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
cat("Etapa 1: 36 registros validados; 3 horas faltantes.\n")
