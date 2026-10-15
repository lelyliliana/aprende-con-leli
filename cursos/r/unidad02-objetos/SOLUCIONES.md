# Soluciones razonadas de la Unidad 02

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. La conversión conserva significado

1.75*60 produce 105 minutos. La entrada está en horas y el factor expresa minutos por hora. El nombre minutos ayuda a recordar el resultado, pero R no comprueba físicamente la unidad; mezclar cantidades con unidades incompatibles sigue siendo responsabilidad del análisis.

## Paso 2. Texto y copia numérica

codigo conserva "007", tipo character y tres caracteres. numero contiene 7 como cantidad numérica y no conserva esos ceros iniciales. Una conversión puede ser válida en sintaxis y perder representación que identificaba un registro. Por eso la copia convertida no sustituye al ID sin una razón.

## Paso 3. Tres preguntas compatibles

3L==3 es TRUE por igualdad de valor; identical es FALSE porque los tipos son integer y double; typeof muestra esos tipos. Ninguno implica por sí mismo un dato incorrecto. La comprobación adecuada depende de si necesitas igualdad numérica o una representación exacta.

## Reto de transferencia. Traza de estados

Después de cambiar horas a 4, minutos aún vale 120. Al repetir minutos<-horas*60 pasa a 240. La primera asignación no conserva una dependencia reactiva; para actualizar debes recalcular. Consultar los dos valores antes y después permite detectar esa suposición equivocada.

## Respuestas de autoevaluación

Sí, un cálculo puede mezclar unidades aunque su sintaxis sea válida. "007" conserva una representación de tres caracteres. == compara el valor numérico del caso; identical distingue también los tipos integer y double.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. La entrada se expresa en horas; la salida, en minutos.
horas <- 1.75
minutos <- horas * 60
stopifnot(minutos == 105)
cat("Paso 1: 1.75 horas = 105 minutos.\n")
# Paso 2. Conservar el identificador y convertir solo una copia.
codigo <- "007"
numero <- as.numeric(codigo)
stopifnot(identical(codigo, "007"), numero == 7, nchar(codigo) == 3)
cat("Paso 2: texto 007 conservado; copia numérica=7.\n")
# Paso 3. Igualdad de valor e identidad de tipo.
entero <- 3L
real <- 3
stopifnot(entero == real, !identical(entero, real))
cat("Paso 3:", typeof(entero), "y", typeof(real), "; igual valor, tipos distintos.\n")
# Reto. Un cambio no recalcula las asignaciones anteriores.
horas <- 2
minutos <- horas * 60
horas <- 4
stopifnot(minutos == 120)
minutos <- horas * 60
stopifnot(minutos == 240)
cat("Reto: antes de recalcular=120; después=240 minutos.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad02-objetos/solucion.R
```

Salida esperada:

```text
Paso 1: 1.75 horas = 105 minutos.
Paso 2: texto 007 conservado; copia numérica=7.
Paso 3: integer y double ; igual valor, tipos distintos.
Reto: antes de recalcular=120; después=240 minutos.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2002%20%28Objetos%2C%20tipos%20y%20operaciones%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
