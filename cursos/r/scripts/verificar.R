if (!file.exists("Curso-R.Rproj")) stop("Trabaja desde la raíz del curso: cursos/r")
source("src/curso.R", encoding = "UTF-8")
comprobar_paquetes()
if (getRversion() < "4.3.0") stop("R 4.3 o superior")
args <- commandArgs(trailingOnly = TRUE)
if (any(!args %in% "--quarto")) stop("Uso: Rscript --vanilla scripts/verificar.R [--quarto]")
dir.create("salidas/verificacion", recursive = TRUE, showWarnings = FALSE)
rscript <- Sys.which("Rscript")
if (!nzchar(rscript)) rscript <- file.path(R.home("bin"), if (.Platform$OS.type == "windows") "Rscript.exe" else "Rscript")
normalizar <- function(x) sub("[[:space:]]+$", "", x)
correr <- function(archivo, indice) {
  salida <- file.path("salidas/verificacion", paste0(indice, ".txt"))
  errores <- file.path("salidas/verificacion", paste0(indice, "-stderr.txt"))
  status <- system2(rscript, c("--vanilla", shQuote(archivo)), stdout = salida, stderr = errores)
  if (status != 0) stop("Falló ", archivo, ":\n", paste(readLines(errores, warn = FALSE, encoding = "UTF-8"), collapse = "\n"))
  normalizar(readLines(salida, warn = FALSE, encoding = "UTF-8"))
}
manifest <- jsonlite::read_json("scripts/manifest.json", simplifyVector = TRUE)
stopifnot(nrow(manifest) == 36L)
for (i in seq_len(nrow(manifest))) {
  actual <- correr(manifest$archivo[i], paste0("ejemplo-", i))
  esperado <- normalizar(readLines(manifest$salida[i], warn = FALSE, encoding = "UTF-8"))
  if (!identical(actual, esperado)) stop("Salida distinta: ", manifest$archivo[i])
}
cat("Ejemplos: 36 correctos en procesos limpios\n")
soluciones <- unlist(jsonlite::read_json("scripts/soluciones.json"), use.names = FALSE)
stopifnot(length(soluciones) == 18L)
for (i in seq_along(soluciones)) correr(soluciones[i], paste0("solucion-", i))
cat("Soluciones ejecutables: 18 correctas\n")
contratos <- correr("tests/contratos.R", "contratos")
cat(paste(contratos, collapse = "\n"), "\n")
archivos <- list.files(pattern = "\\.md$", recursive = TRUE, full.names = TRUE)
archivos <- archivos[!grepl("^\\./salidas/", archivos)]
enlaces <- 0L
for (archivo in archivos) {
  texto <- paste(readLines(archivo, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  if (grepl("\uFFFD|Ã[\u0080-\u00bf]|Â[\u0080-\u00bf]|contentReference|oaicite|[\uE200\uE201]", texto, perl = TRUE)) stop("Codificación o marca interna: ", archivo)
  lineas <- strsplit(texto, "\n", fixed = TRUE)[[1]]
  if (sum(grepl("^```", lineas)) %% 2L != 0L) stop("Bloque sin cerrar: ", archivo)
  links <- regmatches(texto, gregexpr("\\]\\([^)]*\\)", texto, perl = TRUE))[[1]]
  for (link in links) {
    destino <- sub("^\\]\\(", "", sub("\\)$", "", link))
    if (grepl("^[A-Za-z][A-Za-z0-9+.-]*:", destino) || startsWith(destino, "#")) next
    destino <- strsplit(destino, "#", fixed = TRUE)[[1]][1]
    if (nzchar(destino) && !file.exists(file.path(dirname(archivo), utils::URLdecode(destino)))) stop("Enlace roto: ", archivo, " -> ", destino)
    enlaces <- enlaces + 1L
  }
}
cat("Enlaces locales:", enlaces, "\n")
renderizado <- FALSE
if ("--quarto" %in% args) {
  quarto <- Sys.which("quarto")
  if (!nzchar(quarto)) stop("Instala Quarto para comprobar el informe.")
  salida <- system2(quarto, c("render", "proyecto/informe.qmd"), stdout = TRUE, stderr = TRUE)
  writeLines(salida, "salidas/verificacion/quarto.txt", useBytes = TRUE)
  status <- attr(salida, "status")
  if (!is.null(status) && status != 0L) stop("Falló Quarto; revisa salidas/verificacion/quarto.txt")
  if (!file.exists("salidas/informe/proyecto/informe.html")) stop("Falta el HTML renderizado")
  renderizado <- TRUE; cat("Informe Quarto renderizado correctamente\n")
}
versiones <- vapply(c("dplyr", "tidyr", "ggplot2", "readr", "readxl", "knitr", "rmarkdown", "jsonlite"), function(p) as.character(utils::packageVersion(p)), character(1))
jsonlite::write_json(list(ejemplos = 36L, soluciones = 18L, contratos = tail(contratos, 1), enlaces = enlaces,
 quarto = renderizado, R = as.character(getRversion()), paquetes = as.list(versiones)),
 "salidas/verificacion/resultado.json", auto_unbox = TRUE, pretty = TRUE)
cat("Verificación completa\n")
