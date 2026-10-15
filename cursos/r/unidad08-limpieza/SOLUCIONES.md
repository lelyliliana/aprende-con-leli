# Soluciones razonadas de la Unidad 08

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Clasificación fila por fila

Se aceptan 1(S01), 2(S02) y 6(S05). La fila 3 repite S02 de forma equivalente tras normalizar. La 4 tiene edadxx, la 5 horas-2, la 7 grupoC y la 8 puntaje 105. No se acepta el tipo correcto como sustituto de dominio válido. S05 se conserva porque horas admite vacío.

## Paso 2. Misma información, dos representaciones

El original de la fila 2 conserva "7, 5"; en la segunda fila aceptada, horas vale 7.5. El resultado tiene IDs S01, S02, S05 y la última cantidad sigue NA. Las incidencias cuentan 8 originales, 3 aceptadas, 1 repetida y 4 inválidas bajo estas reglas.

## Paso 3. Rechazo con motivo

La copia da a S02 puntajes 80 y 81 después de normalizar las demás columnas. limpiar_entrada rechaza un duplicado contradictorio antes de producir válidas. La solución comprueba la clase y el motivo del error y elimina su archivo temporal. Decidir cuál respuesta conservar exigiría evidencia externa.

## Reto de transferencia. Origen del NA

La máscara !is.na(texto)&is.na(candidato) produce FALSE, TRUE, FALSE. El primer NA ya era ausencia; "texto" genera una ausencia por conversión; "0" se transforma en una medición cero. Agrupar los tres como faltantes perdería información para decidir.

## Respuestas de autoevaluación

Una conversión exitosa informa compatibilidad con un tipo, no con el dominio ni el estudio. S05 admite horas ausentes; S03 incumple edad obligatoria. Dos puntajes contradictorios requieren revisar fuente, registro y reglas, no una elección automática.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
# Paso 1. La clasificación se puede contrastar fila por fila.
r <- limpiar_entrada()
esperada <- data.frame(fila = 1:8, duplicada = c(FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE),
  invalida = c(FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE, TRUE),
  aceptada = c(TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE))
stopifnot(identical(r$incidencias[c("fila", "duplicada", "invalida", "aceptada")], esperada))
cat("Paso 1: aceptadas=1,2,6; duplicada equivalente=3; inválidas=4,5,7,8.\n")
# Paso 2. La representación original y la cantidad interpretada son diferentes.
stopifnot(r$original$horas_semana[2] == "7,5", r$validas$horas_semana[2] == 7.5)
stopifnot(identical(r$validas$id, c("S01", "S02", "S05")), is.na(r$validas$horas_semana[3]))
cat("Paso 2: original conserva 7,5; candidato=7.5; vacío de S05 sigue NA.\n")
# Paso 3. Un mismo ID con puntajes incompatibles requiere revisión.
archivo <- tempfile(fileext = ".csv")
contradiccion <- r$original
contradiccion$puntaje[3] <- "81"
write.csv(contradiccion, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
error <- tryCatch(limpiar_entrada(archivo), error = function(e) e)
stopifnot(inherits(error, "error"), grepl("contradictorio", conditionMessage(error)))
unlink(archivo)
cat("Paso 3: duplicado contradictorio rechazado.\n")
# Reto. Una incidencia de conversión no es un faltante de origen.
texto <- c(NA_character_, "texto", "0")
candidato <- suppressWarnings(as.numeric(texto))
fallo <- !is.na(texto) & is.na(candidato)
stopifnot(identical(fallo, c(FALSE, TRUE, FALSE)), candidato[3] == 0)
cat("Reto: una ausencia original, una conversión fallida y un cero observado.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad08-limpieza/solucion.R
```

Salida esperada:

```text
Paso 1: aceptadas=1,2,6; duplicada equivalente=3; inválidas=4,5,7,8.
Paso 2: original conserva 7,5; candidato=7.5; vacío de S05 sigue NA.
Paso 3: duplicado contradictorio rechazado.
Reto: una ausencia original, una conversión fallida y un cero observado.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2008%20%28Calidad%2C%20limpieza%20y%20trazabilidad%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
