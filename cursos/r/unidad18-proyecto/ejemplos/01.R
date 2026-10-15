# Ejecutar la entrega mínima
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("proyecto/analizar.R", encoding = "UTF-8")
r <- ejecutar_analisis("datos/encuesta.csv", "salidas/proyecto")
stopifnot(sum(r$resumen$n) == 36, file.exists("salidas/proyecto/resumen.csv"), file.exists("salidas/proyecto/puntajes.svg"))
cat("Proyecto: resumen, gráfico y registro de ejecución generados con datos ficticios
")
