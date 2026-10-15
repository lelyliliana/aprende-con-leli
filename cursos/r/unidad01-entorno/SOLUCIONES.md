# Soluciones razonadas de la Unidad 01

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Evidencias diferentes

R.version.string identifica la versión en ejecución. getwd muestra desde dónde se resuelven rutas relativas. file.exists comprueba la presencia del archivo del proyecto en esa ubicación. Necesitas las tres evidencias; una ruta puede existir y ser la carpeta equivocada. La solución revisa R>=4.3 y presencia del archivo, pero debes registrar tu versión y ruta reales.

## Paso 2. Predicción frente a ejecución

El Ejemplo 01 calcula 14; el Ejemplo 02 utiliza 7, 8, 9 y calcula media 8. La solución los ejecuta con source para comprobar ambos archivos, mientras la práctica pide además Rscript --vanilla para observar procesos limpios. Una segunda ejecución debe reproducir los cálculos con todas sus entradas en el archivo.

## Paso 3. Orden de operaciones

En la primera expresión se calcula 3*4=12 y después 2+12=14. En la segunda, 2+3=5 y después 5*4=20. El código R es el contenido; el archivo lo conserva; la consola o Rscript lo evalúan. Guardar una modificación no equivale a haberla ejecutado.

## Reto de transferencia. Expresión autocontenida

(1+0.5)*60 produce 90 minutos. La suma ocurre primero y el resultado se multiplica por los 60 minutos de cada hora. Puedes guardar esa expresión como minutos y mostrarla. La comprobación minutos==90 confirma una expectativa que ya justificaste a mano.

## Respuestas de autoevaluación

Escribir crea instrucciones, guardar conserva su versión en disco y ejecutar las evalúa. getwd informa carpeta, no versión. Una sesión limpia que reproduce las salidas aporta evidencia de que el archivo no necesitó objetos restaurados para esos cálculos.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Versión y raíz son comprobaciones distintas.
stopifnot(getRversion() >= "4.3.0", file.exists("Curso-R.Rproj"))
version <- R.version.string
carpeta <- getwd()
stopifnot(nzchar(version), dir.exists(carpeta))
cat("Paso 1: R compatible y raíz del curso comprobados.\n")
# Paso 2. Ejecutar los archivos, no depender de cálculos anteriores.
source("unidad01-entorno/ejemplos/01.R", encoding = "UTF-8")
source("unidad01-entorno/ejemplos/02.R", encoding = "UTF-8")
cat("Paso 2: ejemplos 01 y 02 ejecutados.\n")
# Paso 3. Precedencia.
a <- 2 + 3 * 4
b <- (2 + 3) * 4
stopifnot(a == 14, b == 20)
cat("Paso 3: sin paréntesis=14; con paréntesis=20.\n")
# Reto. Escribir primero la expresión y después comparar.
minutos <- (1 + 0.5) * 60
stopifnot(minutos == 90)
cat("Reto: una hora y media equivale a 90 minutos.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad01-entorno/solucion.R
```

Salida esperada:

```text
Paso 1: R compatible y raíz del curso comprobados.
R compatible: TRUE
2 + 3 * 4 = 14
Datos: 7, 8, 9
Media: 8
Paso 2: ejemplos 01 y 02 ejecutados.
Paso 3: sin paréntesis=14; con paréntesis=20.
Reto: una hora y media equivale a 90 minutos.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2001%20%28R%2C%20RStudio%20y%20primera%20ejecuci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
