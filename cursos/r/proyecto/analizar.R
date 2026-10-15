source("src/curso.R", encoding = "UTF-8")

ejecutar_analisis <- function(entrada, carpeta_salida) {
  comprobar_raiz()
  d <- leer_encuesta(entrada)
  resumen <- resumir_encuesta(d)
  dir.create(carpeta_salida, recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(as.data.frame(resumen), file.path(carpeta_salida, "resumen.csv"),
                   row.names = FALSE, fileEncoding = "UTF-8")
  ggplot2::ggsave(file.path(carpeta_salida, "puntajes.svg"), figura_encuesta(d),
                   width = 7, height = 4.5, device = grDevices::svg)
  registro <- list(datos = entrada, md5 = unname(tools::md5sum(entrada)), filas = nrow(d),
                    horas_observadas = sum(!is.na(d$horas_semana)),
                    r = as.character(getRversion()), datos_ficticios = TRUE)
  jsonlite::write_json(registro, file.path(carpeta_salida, "registro.json"), auto_unbox = TRUE, pretty = TRUE)
  writeLines(capture.output(sessionInfo()), file.path(carpeta_salida, "sesion.txt"), useBytes = TRUE)
  invisible(list(datos = d, resumen = resumen))
}

if (sys.nframe() == 0L) {
  ejecutar_analisis("datos/encuesta.csv", "salidas/proyecto")
  cat("Proyecto generado en salidas/proyecto\n")
}
