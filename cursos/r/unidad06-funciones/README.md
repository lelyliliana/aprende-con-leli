# Unidad 06. Funciones, decisiones y repetición

[Anterior](../unidad05-tablas/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Escribir una función con entradas y rechazos definidos.
- Utilizar if con una condición escalar.
- Comparar un ciclo con una operación vectorizada.

## Clase guiada. Construir una función antes de exigirle validaciones

Una función reúne instrucciones y les da un nombre. La primera del laboratorio convierte horas a minutos. Comienza con una sola entrada y una sola salida para que puedas reconocer cada pieza antes de añadir decisiones, rechazos o repetición.

### 1. Define y luego llama

En minutos_desde_horas <- function(horas), el nombre de la izquierda guardará la función. function anuncia su definición y horas es el parámetro. Las llaves delimitan el cuerpo. La asignación interna calcula minutos y return entrega ese valor al lugar de la llamada. Definir no ejecuta todavía ese cálculo.

En resultado <- minutos_desde_horas(1.5), 1.5 es el argumento concreto que recibe horas. La función multiplica y devuelve 90; la asignación exterior conserva ese 90 como resultado. El objeto minutos pertenece a la evaluación de la función y no necesitas crearlo antes en la consola.

| Momento | Qué ocurre |
|---|---|
| Definición | Se guarda cómo convertir una entrada futura |
| Llamada con 1.5 | El parámetro horas recibe 1.5 |
| Cálculo interno | minutos toma el valor 90 |
| return | Entrega 90 y termina esa llamada |
| Asignación exterior | resultado conserva el valor entregado |

### 2. Mostrar y devolver cumplen propósitos diferentes

print muestra un valor y puede servir para explorar; return declara de forma explícita qué valor entrega la función y termina esa ejecución. R también devuelve el resultado de la última expresión evaluada si no escribes return. Además, print devuelve invisiblemente el objeto mostrado. Por eso no conviene trasladar sin revisión reglas de otros lenguajes: aquí usamos return explícito para que la intención de cálculo sea clara y print fuera para presentar la salida.

### 3. Decide con una condición escalar

clasificar recibe una cantidad. Si horas >= 5 es TRUE, entrega «cinco o más»; si es FALSE, entra en else y entrega «menos de cinco». El límite 5 pertenece al primer caso por usar >=. Antes de añadir validación, esta versión supone una entrada numérica única y conocida: es un ejemplo de flujo, no una función preparada para datos externos.

if requiere una respuesta única que pueda interpretarse. Un vector de varias respuestas o NA no expresa esa decisión. La solución construye validar_horas de manera gradual: primero tipo, después longitud, ausencia, finitud y rango. El orden evita intentar operar con una entrada que ya falló una precondición.

### 4. Repite y sigue el estado

El ciclo for recorre 2, 4, 6. suma comienza en 0. En cada vuelta, valor recibe el siguiente elemento y suma conserva el acumulado anterior más ese elemento. Las impresiones serán 2, 6, 12. El nombre suma mantiene estado entre vueltas; inicializarlo dentro del ciclo borraría el acumulado en cada paso.

| Vuelta | valor | suma anterior | suma nueva |
|---|---|---|---|
| 1 | 2 | 0 | 2 |
| 2 | 4 | 2 | 6 |
| 3 | 6 | 6 | 12 |

### 5. Añade faltantes y rechazos solo después

Para la media de 3, NA, 5, 7, necesitas dos acumuladores: suma y cantidad conocida. El NA no incrementa ninguno; al final divides 15 entre 3. Si no hubo valores conocidos, decides cómo comunicarlo antes de dividir. mean(x, na.rm=TRUE) expresa el cálculo compacto, mientras la traza te permite explicar su denominador.

stop interrumpe una entrada no admitida con un mensaje. tryCatch permite observar ese rechazo en una prueba: su manejador error recibe la condición. inherits(resultado, "error") comprueba qué ocurrió. Se utiliza para los casos que deliberadamente deben fallar; no para ocultar cualquier problema y seguir como si los datos fueran correctos.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
minutos_desde_horas <- function(horas) {
  minutos <- horas * 60
  return(minutos)
}
resultado <- minutos_desde_horas(1.5)
print(resultado)
clasificar <- function(horas) {
  if (horas >= 5) {
    return("cinco o más")
  } else {
    return("menos de cinco")
  }
}
print(clasificar(3))
print(clasificar(5))
suma <- 0
for (valor in c(2, 4, 6)) {
  suma <- suma + valor
  print(suma)
}
stopifnot(resultado == 90, suma == 12)
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad06-funciones/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] 90
[1] "menos de cinco"
[1] "cinco o más"
[1] 2
[1] 6
[1] 12
```

### Lectura del laboratorio

El primer print muestra 90, entregado por la función. Después aparecen las clasificaciones de 3 y 5. Las tres impresiones del ciclo muestran sus estados, no tres resultados finales de funciones distintas. Distingue el recorrido del programa del valor que una llamada devuelve.

Una función puede recibir argumentos por nombre, como minutos_desde_horas(horas=1.5). Si más adelante añades un valor predeterminado, se usará cuando la llamada omita ese argumento; conviene reservarlo para una elección que tenga sentido en el problema. Las funciones del proyecto reciben archivo y carpeta para hacer visibles sus entradas y sus efectos de escritura.

## Experimenta

Cambia el argumento de conversión a 2 y predice 120. Después cambia la clasificación de >=5 a >5: explica por qué el caso exactamente 5 cambia de rama. Por último mueve suma <- 0 dentro del ciclo en una copia: las impresiones pasarán a 2, 4, 6. Recupera el acumulador fuera y escribe qué estado necesita conservarse.

## Errores frecuentes

| Error | Causa y corrección |
|---|---|
| Definir una función y esperar que ya haya convertido | Falta la llamada con un argumento |
| Depender de un objeto de otra consola | Recibe la entrada mediante un parámetro |
| Usar if con toda una columna | Decide sobre un escalar o construye una máscara vectorial |
| Aumentar el denominador al pasar por NA | Actualiza suma y cantidad solo para observados |
| Capturar cualquier error y devolver cero | Conserva el rechazo y explica la entrada que lo causó |

## Autoevaluación

¿Qué diferencia hay entre parámetro y argumento? ¿Qué devuelve la función de conversión y cuándo se ejecuta? ¿Por qué una media necesita cantidad además de suma? ¿Por qué una función que rechaza ausencia no debería comenzar comparando x < 0 sin revisar tipo y longitud?


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
