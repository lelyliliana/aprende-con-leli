# Soluciones razonadas de la Unidad 03

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Una respuesta por posición

La máscara es FALSE, FALSE, TRUE, TRUE, TRUE y la selección 6, 8, 10. Se conserva el ID posicional del vector durante esa operación, pero el valor 6 no es un índice. x[3] selecciona una posición; x[x>=6] aplica una condición a todos los elementos.

## Paso 2. Otro vector de salida

x[-1] devuelve 4, 6, 8, 10. Al guardarlo como sin_primero, x no cambia. La solución contrasta el contenido completo del original, además de su longitud: tener cinco elementos no bastaría para demostrar que conservó los mismos valores.

## Paso 3. Dos reglas explícitas

Las filas de la matriz son 1, 3, 5 y 2, 4, 6; m[1, 2] vale 3. La suma con reciclaje devuelve 11, 22, 13, 24: el segundo vector se repite 10, 20, 10, 20. Las longitudes compatibles permiten esa operación sin justificar el emparejamiento sustantivo de observaciones.

## Reto de transferencia. Intersección de condiciones

x[x>=4 & x<=8] devuelve 4, 6, 8. Cada posición debe cumplir ambos límites. Si usaras |, prácticamente todos estos valores cumplirían al menos una condición y responderías otra pregunta. && no es el operador para filtrar todos los elementos.

## Respuestas de autoevaluación

x[3] usa posición; x[x>=6] usa una máscara. El laboratorio necesita cuatro respuestas porque tiene cuatro cantidades de entrada. En la matriz por columnas, m[2, 3] vale 6.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. La condición tiene una respuesta por posición.
x <- c(2, 4, 6, 8, 10)
mascara <- x >= 6
seleccion <- x[mascara]
stopifnot(identical(mascara, c(FALSE, FALSE, TRUE, TRUE, TRUE)))
stopifnot(identical(seleccion, c(6, 8, 10)))
cat("Paso 1: seleccionados=6,8,10.\n")
# Paso 2. Excluir produce otro resultado.
sin_primero <- x[-1]
stopifnot(identical(sin_primero, c(4, 6, 8, 10)), identical(x, c(2, 4, 6, 8, 10)))
cat("Paso 2: sin primero=4,6,8,10; original=2,4,6,8,10.\n")
# Paso 3. Columnas y reciclaje.
m <- matrix(1:6, nrow = 2)
stopifnot(identical(as.integer(m[1, ]), c(1L, 3L, 5L)))
r <- 1:4 + c(10, 20)
stopifnot(identical(r, c(11, 22, 13, 24)))
cat("Paso 3: filas de matriz=1,3,5 / 2,4,6; suma=11,22,13,24.\n")
# Reto. Combinar límites por elemento.
intermedios <- x[x >= 4 & x <= 8]
stopifnot(identical(intermedios, c(4, 6, 8)))
cat("Reto: intervalo cerrado de 4 a 8=4,6,8.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad03-vectores/solucion.R
```

Salida esperada:

```text
Paso 1: seleccionados=6,8,10.
Paso 2: sin primero=4,6,8,10; original=2,4,6,8,10.
Paso 3: filas de matriz=1,3,5 / 2,4,6; suma=11,22,13,24.
Reto: intervalo cerrado de 4 a 8=4,6,8.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2003%20%28Vectores%2C%20%C3%ADndices%20y%20condiciones%20l%C3%B3gicas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
