# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. El cero observado participa; NA no es cero.
x <- c(0, NA_real_, 20)
n <- sum(!is.na(x))
media <- mean(x, na.rm = TRUE)
stopifnot(n == 2, media == 10)
cat("Paso 1: media=10; observados=2; registros=3.\n")
# Paso 2. Retirar todos los faltantes deja cero observaciones.
vacio <- mean(c(NA_real_, NA_real_), na.rm = TRUE)
stopifnot(is.nan(vacio), is.na(vacio), !identical(vacio, 0))
cat("Paso 2: NaN es detectado por is.nan e is.na; no es cero.\n")
# Paso 3. La etiqueta original permite auditar el NA creado.
etiquetas <- c("baja", "media", "alta", "desconocida")
niveles <- c("baja", "media", "alta")
desconocidas <- etiquetas[!etiquetas %in% niveles]
f <- factor(etiquetas, levels = niveles, ordered = TRUE)
stopifnot(identical(desconocidas, "desconocida"), is.na(f[4]), !anyNA(etiquetas))
cat("Paso 3: un NA nuevo proviene de la etiqueta desconocida.\n")
# Reto. Fecha con formato y factor numérico.
fechas <- as.Date(c("15/01/2026", "18/01/2026"), format = "%d/%m/%Y")
f_numero <- factor(c("10", "20"))
cantidades <- as.numeric(as.character(f_numero))
stopifnot(as.numeric(fechas[2] - fechas[1]) == 3, identical(cantidades, c(10, 20)))
stopifnot(identical(as.numeric(f_numero), c(1, 2)))
cat("Reto: diferencia=3 días; etiquetas numéricas=10,20; códigos=1,2.\n")
