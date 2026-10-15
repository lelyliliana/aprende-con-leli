# Laboratorio guiado. Ejecutar desde cursos/r.
original <- c(" 7,5 ", "", "texto", "0")
texto <- trimws(original)
texto[texto == ""] <- NA_character_
candidato <- suppressWarnings(as.numeric(gsub(",", ".", texto, fixed = TRUE)))
fallo_conversion <- !is.na(texto) & is.na(candidato)
auditoria <- data.frame(original, candidato, fallo_conversion)
print(auditoria)
stopifnot(candidato[1] == 7.5, is.na(candidato[2]), fallo_conversion[3], candidato[4] == 0)
stopifnot(identical(original, c(" 7,5 ", "", "texto", "0")))
