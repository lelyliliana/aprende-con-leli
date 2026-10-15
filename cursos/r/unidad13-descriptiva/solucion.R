# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Resumen que no oculta el extremo.
x <- c(10, 11, 12, 13, 100)
r <- c(n = length(x), media = mean(x), mediana = median(x), minimo = min(x), maximo = max(x))
stopifnot(r[["media"]] == 29.2, r[["mediana"]] == 12, sum(x) == 146)
cat("Paso 1: n=5; media=29.2; mediana=12; mínimo=10; máximo=100.\n")
# Paso 2. El dominio del puntaje permite 100; extremo no implica imposible.
stopifnot(all(x >= 0 & x <= 100))
cat("Paso 2: 100 está dentro del dominio; revisar origen y unidad antes de excluir.\n")
# Paso 3. Categorías y faltantes son cuentas distintas.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
con_faltantes <- table(d$satisfaccion, useNA = "ifany")
observadas <- table(d$satisfaccion, useNA = "no")
stopifnot(sum(con_faltantes) == 36, sum(observadas) == 34, sum(is.na(d$satisfaccion)) == 2)
por_respuesta <- as.numeric(observadas) / 34
por_registro <- as.numeric(observadas) / 36
stopifnot(abs(sum(por_respuesta) - 1) < 1e-12, abs(sum(por_registro) - 34 / 36) < 1e-12)
cat("Paso 3: proporciones entre respuestas usan 34; entre registros usan 36.\n")
# Reto. Sensibilidad a una exclusión hipotética, sin borrar el original.
sin_extremo <- x[x != 100]
stopifnot(mean(sin_extremo) == 11.5, length(x) == 5)
cat("Reto: media sin 100=11.5; original conservado; no es autorización para eliminarlo.\n")
