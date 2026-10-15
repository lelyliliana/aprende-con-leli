# Soluciones razonadas de la Unidad 13

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Media y mediana

n=5, suma=146, media=29.2, mediana=12, mínimo=10, máximo=100. La media incorpora la magnitud del extremo y la mediana depende de la posición central. No se contradicen: describen propiedades diferentes. Comunicar ambas con tamaño y rango evita presentar 29.2 como si fuera un valor observado típico.

## Paso 2. Dominio y procedencia

100 es admisible en 0 a 100. Antes de excluirlo revisa fuente, unidad, procedimiento y posible error de registro. Si fuese 1000, incumpliría ese dominio, pero todavía necesitarías decidir con evidencia cómo corregir o excluir. Ser extremo no equivale a ser imposible.

## Paso 3. Entre respuestas o entre registros

Las categorías conocidas suman 34 y los registros 36, con 2 ausencias. Dividir cada frecuencia por 34 produce la composición de respuestas conocidas y sumará 1. Dividir por 36 expresa fracción de todos los registros y las categorías conocidas sumarán 34/36; la fracción restante corresponde a ausencia de respuesta.

## Reto de transferencia. Comparación de sensibilidad

Sin 100, la media es 11.5 y el tamaño 4. El original conserva cinco datos. La comparación muestra influencia del extremo sobre el resumen; no demuestra que el dato sea erróneo ni autoriza a eliminarlo para obtener una cifra más conveniente.

## Respuestas de autoevaluación

Media y mediana pueden diferir por la distribución y los extremos. Usa 34 para describir respuestas conocidas y 36 para fracciones de todos los registros. Antes de excluir revisa dominio, unidad, fuente y criterio explícito.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
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
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad13-descriptiva/solucion.R
```

Salida esperada:

```text
Paso 1: n=5; media=29.2; mediana=12; mínimo=10; máximo=100.
Paso 2: 100 está dentro del dominio; revisar origen y unidad antes de excluir.
Paso 3: proporciones entre respuestas usan 34; entre registros usan 36.
Reto: media sin 100=11.5; original conservado; no es autorización para eliminarlo.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2013%20%28Distribuciones%20y%20estad%C3%ADstica%20descriptiva%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
