# La media no describe sola la distribución
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(10, 11, 12, 13, 100)
stopifnot(mean(x) == 29.2, median(x) == 12, min(x) == 10, max(x) == 100)
cat("Media:", mean(x), "; mediana:", median(x), "; rango:", min(x), "a", max(x), "
")
cat("La observación 100 se investiga; no se elimina solo por ser extrema.
")
