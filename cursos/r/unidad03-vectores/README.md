# Unidad 03. Vectores, índices y condiciones lógicas

[Anterior](../unidad02-objetos/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-faltantes-factores/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Seleccionar posiciones y valores sin confundirlos.
- Reconocer reciclaje y longitudes de operaciones.
- Leer el llenado de una matriz por columnas.

## Clase guiada. Seleccionar con una pregunta por posición

Un vector reúne valores de un tipo común. `c(2, 4, 6, 8)` combina cuatro números y length informa su cantidad. Los corchetes seleccionan. En R la primera posición es 1: horas[1] devuelve 2, mientras horas[2] devuelve 4. Esas posiciones no son IDs de personas y pueden cambiar al ordenar el vector.

### 1. Construye la condición sin seleccionar todavía

La comparación horas >= 6 produce FALSE, FALSE, TRUE, TRUE. Cada respuesta corresponde al elemento de la misma posición. Guardar ese resultado como mascara permite inspeccionarlo antes de utilizarlo. Después, horas[mascara] conserva las posiciones verdaderas y devuelve 6, 8.

| Posición | horas | horas >= 6 | ¿Se conserva? |
|---|---|---|---|
| 1 | 2 | FALSE | No |
| 2 | 4 | FALSE | No |
| 3 | 6 | TRUE | Sí |
| 4 | 8 | TRUE | Sí |

### 2. Incluye, excluye o combina condiciones

horas[c(1, 3)] obtiene la primera y la tercera posición. horas[-1] excluye la primera. Ninguna selección modifica horas sin una asignación posterior. Para seleccionar entre 4 y 8, combina horas >= 4 & horas <= 8: & exige que las dos comparaciones sean verdaderas en cada posición. Con | basta que se cumpla una. ! invierte una respuesta lógica.

No uses && para filtrar un vector completo: se reserva para decisiones escalares y puede producir un error cuando recibe varias respuestas. En la siguiente unidad añadirás máscaras para faltantes, porque una pregunta sobre un dato desconocido puede no tener una respuesta TRUE/FALSE conocida.

### 3. Comprueba la correspondencia antes de operar vectores

En 1:4 + c(10, 20), R reutiliza 10, 20 para las cuatro posiciones. El resultado es 11, 22, 13, 24. La ausencia de advertencia solo indica que esa combinación de longitudes encaja con la regla; no demuestra que corresponda a tus observaciones. Si cada número pertenece a una persona, conserva sus IDs en una tabla.

### 4. Lee una matriz en dos dimensiones

matrix(1:6, nrow=2) coloca 1 y 2 en la primera columna, 3 y 4 en la segunda y 5 y 6 en la tercera. `m[1,2]` consulta fila uno y columna dos: 3. La coma divide las dimensiones. Una matriz sirve para magnitudes de tipo común; una encuesta con IDs textuales necesita una tabla.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
horas <- c(2, 4, 6, 8)
mascara <- horas >= 6
print(mascara)
seleccion <- horas[mascara]
print(seleccion)
print(horas[-1])
m <- matrix(1:6, nrow = 2)
print(m)
stopifnot(identical(seleccion, c(6, 8)), m[1, 2] == 3)
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad03-vectores/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] FALSE FALSE  TRUE  TRUE
[1] 6 8
[1] 4 6 8
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

### Lectura del laboratorio

Primero aparece la máscara completa; luego, los dos valores seleccionados. La impresión de horas[-1] muestra 4, 6, 8. La matriz impresa tiene primera fila 1, 3, 5 y segunda 2, 4, 6. Lee las etiquetas de fila y columna que añade R como orientación de la impresión, no como datos adicionales.

## Experimenta

Cambia >= 6 por > 6: quedará solo 8. Después aplica >= 4 & <= 8 escribiendo el nombre horas en ambas comparaciones; obtendrás 4, 6, 8. Finalmente dibuja la matriz creada con byrow=TRUE: ahora las filas son 1, 2, 3 y 4, 5, 6. Explica qué argumento modificó la construcción, sin atribuir el cambio a la impresión.

## Errores frecuentes

| Confusión | Revisión |
|---|---|
| x[0] obtiene el primer dato | Los índices positivos comienzan en 1 |
| El valor 6 siempre está en la posición 3 | La posición depende del contenido y su orden |
| Seleccionar modifica el original | Comprueba si hubo reasignación |
| Reciclar confirma el emparejamiento | Revisa longitud, unidad e identidad de cada entrada |

## Autoevaluación

¿Qué diferencia hay entre x[3] y x[x>=6]? ¿Por qué seleccionar 6 y 8 necesita cuatro respuestas lógicas en el laboratorio? ¿Qué contiene m[2, 3] en la matriz por columnas? Dibuja antes de ejecutar.


## Un vector contiene varios valores de un tipo común

c(4,7,10) construye un vector numérico. length informa cuántos elementos contiene. La posición inicial es 1: x[1] obtiene 4. x[0] no obtiene el primer elemento, sino una selección vacía. Pedir una posición positiva fuera del vector devuelve NA en este caso; no equivale a un valor cero.

Un índice negativo excluye posiciones. x[-1] produce un resultado sin el primero y no cambia x hasta que lo asignes. Mezclar índices positivos y negativos en la misma selección no es una forma de combinar inclusión y exclusión; debes expresar una política de selección coherente.

## Una condición puede ser un vector

x>5 compara cada elemento y produce FALSE,TRUE,TRUE. x[x>5] conserva los valores cuyas posiciones cumplen la condición. En las unidades de faltantes aprenderás por qué una máscara con NA también necesita atención.

Para combinar condiciones por elemento se usan & y |. Los operadores && y || se usan cuando se necesita una condición escalar, por ejemplo en una decisión if. No sustituyas uno por otro esperando que siempre conserven todas las filas.

## El reciclaje no comprueba tu intención

Sumar c(1,2,3,4) y c(10,20) reutiliza el segundo vector y devuelve 11,22,13,24. Las longitudes son múltiplos y esa repetición no necesita una advertencia. Puede ser exactamente lo que buscabas o un error de diseño; el lenguaje no conoce cuál era tu intención.

Si las longitudes no encajan, puede aparecer una advertencia, pero tampoco debes usar su ausencia como prueba de correspondencia entre personas o registros. Las tablas se unirán después por claves, no por asumir que sus filas ya están alineadas.

## Matriz y orden de llenado

matrix(1:6,nrow=2) llena primero una columna y luego la siguiente. La posición fila 1/columna 2 contiene 3. Una matriz tiene un tipo común; una tabla de datos puede tener columnas de tipos diferentes.

Antes de ejecutar el segundo ejemplo, dibuja dos filas y tres columnas y coloca 1,2 en la primera columna. La comprobación de esa posición te permite detectar un supuesto incorrecto sobre el orden, aunque al imprimir veas todos los números esperados.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Seleccionar sin cambiar el original

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Seleccionar sin cambiar el original
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(4, 7, 10)
seleccion <- x[x > 5]
stopifnot(identical(seleccion, c(7, 10)), length(x[0]) == 0, is.na(x[4]))
cat("Mayores que 5:", paste(seleccion, collapse = ", "), "
")
cat("Índice 0: longitud", length(x[0]), "; índice 4: NA
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad03-vectores/ejemplos/01.R
```

Salida esperada:

```text
Mayores que 5: 7, 10
Índice 0: longitud 0 ; índice 4: NA
```

### Ejemplo 2. Reciclaje y orden por columnas

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Reciclaje y orden por columnas
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(1, 2, 3, 4)
r <- x + c(10, 20)
stopifnot(identical(r, c(11, 22, 13, 24)))
m <- matrix(1:6, nrow = 2)
stopifnot(m[1, 2] == 3, m[2, 3] == 6)
cat("Reciclaje:", paste(r, collapse = ", "), "
")
cat("Matriz: fila 1, columna 2 =", m[1, 2], "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad03-vectores/ejemplos/02.R
```

Salida esperada:

```text
Reciclaje: 11, 22, 13, 24
Matriz: fila 1, columna 2 = 3
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad02-objetos/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-faltantes-factores/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2003%20%28Vectores%2C%20%C3%ADndices%20y%20condiciones%20l%C3%B3gicas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
