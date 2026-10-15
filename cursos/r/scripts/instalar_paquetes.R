# Ejecuta una vez desde la raíz del curso. Instala solo paquetes faltantes/antiguos.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
if (getRversion() < "4.3.0") stop("El curso requiere R 4.3 o superior.")
minimos <- c(dplyr = "1.1.0", tidyr = "1.3.0", ggplot2 = "3.4.0", readr = "2.1.0",
             readxl = "1.4.0", knitr = "1.40", rmarkdown = "2.20", jsonlite = "1.8.0")
pendientes <- names(minimos)[vapply(names(minimos), function(p) {
  !requireNamespace(p, quietly = TRUE) || utils::packageVersion(p) < package_version(minimos[[p]])
}, logical(1))]
if (length(pendientes)) utils::install.packages(pendientes, repos = "https://cloud.r-project.org")
comprobar_paquetes()
cat("Paquetes preparados. Quarto se instala por separado para la Unidad 17.\n")
