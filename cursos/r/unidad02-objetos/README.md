# Unidad 02. Objetos, tipos y operaciones

[Anterior](../unidad01-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-vectores/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Asignar resultados a objetos con nombres claros.
- Distinguir texto, número entero, número real y lógico.
- Conservar unidades e identificadores durante una transformación.

## Asignar conserva un resultado para usarlo después

En R, `<-` asocia un nombre con un valor. Si horas vale 2.5, minutos puede calcularse como horas*60. El nombre no añade una unidad física al objeto: documentar horas y minutos sigue siendo responsabilidad de quien analiza. Mezclar mediciones en unidades distintas puede producir un cálculo válido en sintaxis e incorrecto en significado.

Los nombres distinguen mayúsculas. Usa nombres como horas_semana que indiquen variable y unidad. Evita reutilizar mean como nombre de un objeto porque dificultaría leer las funciones del análisis. Un objeto puede reasignarse: al cambiar horas, una variable minutos ya calculada no se actualiza automáticamente como una fórmula de hoja de cálculo.

## Tipo, valor y apariencia son preguntas distintas

3L es un entero, 3 es normalmente double y "3" es texto. Los dos números pueden comparar iguales con == aunque identical distinga sus tipos. El texto no se vuelve una cantidad por verse como dígitos.

Un código "007" puede ser una etiqueta y debe conservar sus ceros. Convertirlo a número devuelve 7. Si su propósito es identificar un registro, esa conversión podría perder información. En cambio, una columna de horas escrita como texto sí necesitaría una conversión controlada antes de promediar.

## Operadores y resultados

Los operadores aritméticos calculan valores y los comparativos producen lógicos como TRUE o FALSE. Los paréntesis hacen explícita la intención. Usa typeof o str para investigar qué tienes; no deduzcas el tipo solo de cómo se imprime.

La coerción automática puede cambiar un contenedor a un tipo común: al combinar números y texto en un vector, puedes obtener todo como texto. En las siguientes unidades usarás ese hecho para revisar columnas importadas. Una conversión fallida puede producir un dato faltante y una advertencia; no se resuelve borrando la advertencia sin investigar la causa.

## Traza del ejemplo

horas=2.5 se transforma en minutos=150. El objeto etiqueta conserva texto. En el segundo ejemplo entero y real tienen igual valor pero tipos distintos. Esas observaciones separan igualdad de valor, identidad exacta y significado de la variable.

No se requiere memorizar todos los tipos internos para avanzar. Sí debes poder justificar por qué un identificador se conserva como texto y una medición se trata como número, y comprobar la unidad después de transformar.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Asignación y unidades

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Asignación y unidades
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
horas <- 2.5
minutos <- horas * 60
etiqueta <- "Tiempo de estudio"
stopifnot(minutos == 150, is.character(etiqueta))
cat(etiqueta, ": ", minutos, " minutos
", sep = "")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad02-objetos/ejemplos/01.R
```

Salida esperada:

```text
Tiempo de estudio: 150 minutos
```

### Ejemplo 2. Distinguir tipo y apariencia

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Distinguir tipo y apariencia
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
entero <- 3L
real <- 3
texto <- "3"
stopifnot(typeof(entero) == "integer", typeof(real) == "double", typeof(texto) == "character")
stopifnot(entero == real, !identical(entero, real))
cat("Tipos:", typeof(entero), typeof(real), typeof(texto), "
")
cat("Igual valor:", entero == real, "; idénticos:", identical(entero, real), "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad02-objetos/ejemplos/02.R
```

Salida esperada:

```text
Tipos: integer double character
Igual valor: TRUE ; idénticos: FALSE
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad01-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-vectores/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2002%20%28Objetos%2C%20tipos%20y%20operaciones%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
