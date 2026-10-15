# Soluciones razonadas de la Unidad 17

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Procedencia con límites

La huella identifica el contenido del archivo para contrastar cambios en este flujo; sessionInfo documenta R, plataforma y paquetes de la sesión. Ninguno valida el diseño, la veracidad de respuestas ni la corrección de toda interpretación. MD5 tampoco se presenta como una garantía de seguridad.

## Paso 2. Renderizado real

El comando ejecuta los bloques R y produce el HTML desde sus fuentes. Deben verse 36 registros, 3 horas faltantes y 17/16 observados por grupo. La solución R comprueba las fuentes y cuentas; la automatización con --quarto sí renderiza. Para completar tu práctica abre además el HTML y contrasta texto, tabla y figura.

## Paso 3. Una modificación rastreable

En la copia, incrementar un puntaje en 1 dentro del dominio cambia la media de su grupo en 1/18. n sigue siendo 18 y los faltantes de horas no cambian. El script verifica ese cálculo con una copia temporal y huellas distintas, conservando el original. En el proyecto duplicado debes confirmar además el nuevo valor en el HTML recién renderizado; el código R solo no acredita esa inspección.

## Reto de transferencia. Mismas fuentes, mismo cálculo observado

Releer la fuente original devuelve el resumen inicial. Un registro de versiones indica qué había instalado, pero no resuelve ni restaura dependencias. El curso declara mínimos y registra el entorno probado; un sistema de bloqueo y restauración sería una herramienta adicional con otro alcance.

## Respuestas de autoevaluación

Renderizar ejecuta fuentes y conserva una representación HTML de esa ejecución. +1/18 corresponde a distribuir una unidad entre 18 registros del grupo. La huella no demuestra validez científica. Registrar describe versiones; bloquear implica un mecanismo adicional para resolver y restaurar un entorno.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
source("src/curso.R", encoding = "UTF-8")
# Paso 1. Registrar procedencia y versiones; no confundirlas con validez.
d <- leer_encuesta()
huella <- unname(tools::md5sum("datos/encuesta.csv"))
dir.create("salidas", showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "salidas/practica-sesion.txt", useBytes = TRUE)
stopifnot(nchar(huella) == 32, file.exists("salidas/practica-sesion.txt"))
cat("Paso 1: huella de datos y sesión registradas; no prueban validez científica.\n")
# Paso 2. Comprobar las fuentes y las cifras que debe mostrar el informe.
stopifnot(file.exists("proyecto/informe.qmd"), file.exists("_quarto.yml"))
stopifnot(nrow(d) == 36, sum(is.na(d$horas_semana)) == 3)
cat("Paso 2: fuentes presentes; el informe debe mostrar 36 registros y 3 horas faltantes.\n")
cat("El renderizado real de Quarto se ejecuta con verificar.R --quarto.\n")
# Paso 3. Escribir y leer una copia temporal antes de comparar.
copia <- d
copia$puntaje[1] <- copia$puntaje[1] + 1
archivo <- tempfile(fileext = ".csv")
write.csv(copia, archivo, row.names = FALSE, na = "", fileEncoding = "UTF-8")
modificada <- leer_encuesta(archivo)
a <- resumir_encuesta(d)
b <- resumir_encuesta(modificada)
g <- d$grupo[1]
stopifnot(abs(b$media_puntaje[b$grupo == g] - a$media_puntaje[a$grupo == g] - 1 / 18) < 1e-10)
stopifnot(huella == unname(tools::md5sum("datos/encuesta.csv")), huella != unname(tools::md5sum(archivo)))
unlink(archivo)
cat("Paso 3: copia válida cambia la media en 1/18; original y su huella intactos.\n")
# Reto. Repetir la lectura y no depender de un objeto modificado.
otra <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, otra))
cat("Reto: releer el original recupera el mismo resumen; registrar versiones no las bloquea.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad17-reproducibilidad/solucion.R
```

Salida esperada:

```text
Paso 1: huella de datos y sesión registradas; no prueban validez científica.
Paso 2: fuentes presentes; el informe debe mostrar 36 registros y 3 horas faltantes.
El renderizado real de Quarto se ejecuta con verificar.R --quarto.
Paso 3: copia válida cambia la media en 1/18; original y su huella intactos.
Reto: releer el original recupera el mismo resumen; registrar versiones no las bloquea.
```

El archivo R comprueba cálculos y archivos. Los pasos que requieren renderizar con Quarto o valorar una interpretación se completan además siguiendo la explicación escrita; no se sustituyen por ejecutar este archivo.

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2017%20%28Proyectos%20e%20informes%20con%20Quarto%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
