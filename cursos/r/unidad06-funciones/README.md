# Unidad 06. Funciones, decisiones y repetición

[Anterior](../unidad05-tablas/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Escribir una función con entradas y rechazos definidos.
- Utilizar if con una condición escalar.
- Comparar un ciclo con una operación vectorizada.

## Una función declara qué acepta y qué devuelve

Una función reusable recibe argumentos y devuelve un resultado. media_observada acepta un vector numérico con al menos un valor observado, retira NA para su cálculo y devuelve una media. Ese es un contrato concreto: otra función podría elegir devolver NA si no hay observaciones, pero debe explicarlo.

Validar al comienzo ayuda a distinguir una entrada no admitida de un error posterior. stop interrumpe con un mensaje. En los ejemplos, tryCatch se utiliza para observar un rechazo previsto y comprobar su clase; no para convertir silenciosamente cualquier error en un resultado exitoso.

## if necesita una pregunta que tenga una respuesta

if decide sobre una condición escalar. Si necesitas validar un único número de horas, primero comprueba tipo y longitud. Después puedes revisar ausencia, finitud y rango. Los operadores || y && evalúan condiciones de control de forma escalar y permiten detener una validación cuando una precondición ya falla.

Una máscara de muchas filas se maneja de otra manera: con comparaciones vectorizadas y selección. No pases un vector lógico de toda una tabla a if esperando que filtre automáticamente cada registro.

## Un ciclo conserva estado entre pasos

El ejemplo recorre 3,NA,5,7. Mantiene suma y n de observados. Solo si valor no falta actualiza ambos. Al final suma=15 y n=3, por lo que media=5. Si incrementaras n también para NA, cambiarías el denominador y obtendrías otra cantidad.

mean con na.rm=TRUE expresa el mismo cálculo para ese caso. Comparar ambas implementaciones ayuda a explicar qué hace la operación compacta. No significa que siempre debas sustituir funciones vectorizadas por ciclos ni que un estilo sea automáticamente más rápido para cualquier trabajo.

## Alcance y efectos

Los objetos internos de una función pertenecen a su evaluación. Evita que un resultado dependa de una variable creada antes en otra consola. Pasa entradas explícitas y devuelve objetos que puedan comprobarse. En archivos compartidos usaremos source para cargar funciones; source no instala paquetes.

La práctica valida una cantidad entre 0 y 40. Además del caso normal, incluye límites, NA, texto, vector de dos cantidades y valor fuera del rango. Esos casos explican el contrato mejor que una sola ejecución exitosa.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Una función con contrato

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Una función con contrato
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
media_observada <- function(x) {
  if (!is.numeric(x)) stop("Se requiere un vector numérico")
  observados <- x[!is.na(x)]
  if (!length(observados)) stop("No hay valores observados")
  mean(observados)
}
stopifnot(media_observada(c(0, 10, NA_real_)) == 5)
fallo <- tryCatch(media_observada(c(NA_real_)), error = function(e) e)
stopifnot(inherits(fallo, "error"))
cat("Media:", media_observada(c(0, 10, NA_real_)), "; entrada sin datos rechazada
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad06-funciones/ejemplos/01.R
```

Salida esperada:

```text
Media: 5 ; entrada sin datos rechazada
```

### Ejemplo 2. Repetición y resultado equivalente

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Repetición y resultado equivalente
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(3, NA_real_, 5, 7)
suma <- 0
n <- 0L
for (valor in x) {
  if (!is.na(valor)) { suma <- suma + valor; n <- n + 1L }
}
stopifnot(n == 3L, suma / n == mean(x, na.rm = TRUE))
cat("Observados:", n, "; suma:", suma, "; media:", suma / n, "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad06-funciones/ejemplos/02.R
```

Salida esperada:

```text
Observados: 3 ; suma: 15 ; media: 5
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad05-tablas/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2006%20%28Funciones%2C%20decisiones%20y%20repetici%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
