# Soluciones razonadas de la Unidad 04

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Media de dos conocidos

Hay 3 registros, 2 cantidades observadas y media 10. El cero es una medición conocida y participa en suma y denominador. Reemplazar el NA por cero daría otra media y afirmaría una información no observada. La media de los conocidos no recupera el dato que falta.

## Paso 2. Ausencia de cantidades utilizables

La media resulta NaN. is.nan y is.na devuelven TRUE para ese resultado; no equivale al número 0. Una función puede rechazar el caso o devolver una marca explícita según su contrato. Debe comunicar que n_observados=0 para que esa política sea interpretable.

## Paso 3. Un NA creado por conversión

desconocida no pertenece a los niveles. El original no tiene NA, pero el factor tendrá uno en la cuarta posición. Conservar el texto identifica el origen de esa ausencia nueva. ordered declara baja<media<alta, sin asignar distancias numéricas iguales entre categorías.

## Reto de transferencia. Representaciones controladas

El formato %d/%m/%Y permite obtener 3 días. as.numeric del factor devuelve códigos 1, 2 en este ejemplo; al pasar por as.character recuperas "10", "20" antes de interpretar cantidades 10, 20. Esa estrategia también necesita revisar que las etiquetas sean cantidades válidas.

## Respuestas de autoevaluación

0 es conocido; NA es desconocido. Una categoría incompatible produce un faltante nuevo y necesita auditoría del texto de origen. Un factor ordenado comunica un orden de niveles; no convierte sus códigos en mediciones de intervalo.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
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
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad04-faltantes-factores/solucion.R
```

Salida esperada:

```text
Paso 1: media=10; observados=2; registros=3.
Paso 2: NaN es detectado por is.nan e is.na; no es cero.
Paso 3: un NA nuevo proviene de la etiqueta desconocida.
Reto: diferencia=3 días; etiquetas numéricas=10,20; códigos=1,2.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2004%20%28Datos%20faltantes%2C%20factores%20y%20fechas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
