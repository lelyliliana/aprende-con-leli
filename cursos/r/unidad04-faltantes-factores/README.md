# Unidad 04. Datos faltantes, factores y fechas

[Anterior](../unidad03-vectores/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-tablas/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Diferenciar un faltante de una medición cero.
- Declarar niveles y orden de una variable categórica.
- Interpretar fechas con formato explícito.

## Clase guiada. Un faltante tiene consecuencias distintas de un cero

Considera tres registros con horas 0, vacío y 20. La primera persona declaró cero horas; de la segunda no tienes cantidad. En R representamos ese vacío permitido con NA. Si sustituyes NA por cero, introduces una respuesta que nadie registró y la media cambia de 10 (dos conocidos) a 6.67 (tres valores, uno inventado).

### 1. Detecta y cuenta antes de resumir

is.na(horas) produce FALSE, TRUE, FALSE. ! invierte esa máscara, y sum cuenta los TRUE como unos: hay dos valores observados. mean(horas) no resuelve por ti el faltante y devuelve NA en este caso. mean(horas, na.rm=TRUE) calcula solo con los conocidos; acompáñala siempre de n_observados y n_total.

No compares con == NA para buscar ausencias: la comparación con un desconocido sigue siendo desconocida. Usa is.na. Si todos faltan, retirar NA deja cero datos y mean produce NaN. is.nan detecta ese resultado, mientras is.na detecta tanto NA como NaN. Por eso una función puede devolver NA explícito para comunicar «sin observaciones» sin confundirlo con cero.

### 2. Modela categorías con un diccionario

Un factor representa una variable categórica con niveles. Para satisfacción declaramos baja, media, alta. ordered=TRUE comunica ese orden; no afirma que la distancia entre baja y media sea numéricamente igual a la distancia entre media y alta. No calcules la media de sus códigos como si fueran una escala de intervalos validada.

Antes de factorizar, compara las etiquetas con el diccionario. "otra" está fuera de él. Si construyes directamente el factor, esa etiqueta se convierte en NA: debes registrar que el faltante fue creado por la conversión y conservar el texto de origen para investigarlo.

### 3. Convierte fechas con una regla explícita

as.Date interpreta el texto según el formato indicado. %d corresponde al día, %m al mes y %Y al año de cuatro cifras. Entre 15/01/2026 y 18/01/2026 hay tres días. Un orden de día/mes diferente puede cambiar una fecha válida sin que el programa se detenga, de modo que un resultado sin error no reemplaza la revisión del formato.

Las fechas de esta unidad no incluyen hora ni zona. Si una investigación necesita instantes o cambios de zona, Date ya no expresa toda la información. Primero define qué mide tu columna y después selecciona su tipo.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
horas <- c(0, NA_real_, 20)
observado <- !is.na(horas)
print(observado)
print(sum(observado))
print(mean(horas, na.rm = TRUE))
etiquetas <- c("baja", "alta", "otra")
desconocida <- !etiquetas %in% c("baja", "media", "alta")
print(desconocida)
f <- factor(etiquetas, levels = c("baja", "media", "alta"), ordered = TRUE)
print(is.na(f))
fechas <- as.Date(c("15/01/2026", "18/01/2026"), format = "%d/%m/%Y")
print(as.numeric(fechas[2] - fechas[1]))
stopifnot(sum(observado) == 2, sum(is.na(f)) == 1)
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad04-faltantes-factores/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1]  TRUE FALSE  TRUE
[1] 2
[1] 10
[1] FALSE FALSE  TRUE
[1] FALSE FALSE  TRUE
[1] 3
```

### Lectura del laboratorio

La máscara de observados produce dos TRUE y su suma es 2. La media muestra 10 porque incluye el cero real y el veinte. La máscara de categorías desconocidas y la máscara de NA del factor coinciden en la tercera posición: no existía un vacío original allí. La diferencia de fechas se convierte a número solo para mostrar los tres días del ejemplo.

## Experimenta

En una copia, cambia el NA de horas por 10. Ahora hay tres observados y la media sigue siendo 10; el mismo promedio no implica la misma información disponible. Después prueba un vector totalmente faltante y consulta is.nan. Por último sustituye "otra" por "media": el factor tendrá cero faltantes nuevos.

## Errores frecuentes

| Error | Qué comprobar |
|---|---|
| Usar x == NA | Emplea is.na(x) |
| Tratar NaN como media cero | Cuenta los valores disponibles antes de interpretar |
| Convertir factor con as.numeric sin revisar | Obtienes códigos internos, no sus etiquetas |
| Suponer que una fecha válida tiene formato correcto | Contrasta día, mes y diccionario con casos conocidos |

## Autoevaluación

¿Por qué 0 participa en la media y NA no se sustituye automáticamente? ¿Qué diferencia hay entre una ausencia original y una categoría incompatible? ¿Qué información comunica un factor ordenado que no comunica un vector de texto?


## Un dato faltante cambia qué sabes y qué calculas

NA indica un valor no disponible. No es una medición cero. La media de 0,10,NA es NA si no especificas cómo tratar el faltante. Con na.rm=TRUE la media de los dos observados es 5. Debes informar que el denominador fue 2, no 3, y qué observaciones quedaron fuera.

Eliminar faltantes puede alterar la población de registros que describes. No garantiza que los observados representen a quienes faltan. Reemplazar por cero tampoco es una limpieza neutral: añade una medición que no tienes.

Si todos faltan, mean con na.rm=TRUE produce NaN en este ejemplo, porque no hay datos sobre los que dividir. Una función de proyecto puede decidir rechazar ese caso o devolver una marca explícita; no debe presentarlo como media cero.

## Un factor representa categorías con niveles

Un factor conserva niveles y códigos internos. Si ordenas baja,media,alta, el orden responde al diccionario, no al alfabeto. Una etiqueta fuera de esos niveles puede convertirse en NA al construir el factor; comprueba los valores desconocidos antes de asumir que eran faltantes originales.

as.numeric aplicado directamente a un factor devuelve sus códigos, no necesariamente los números escritos en sus etiquetas. Para etiquetas "10" y "20", los códigos pueden ser 1 y 2. La conversión mediante as.character conserva primero el texto que quieres interpretar, pero también necesita comprobar que todas las etiquetas sean cantidades válidas.

## Una fecha necesita un formato conocido

15/01/2026 puede interpretarse con format="%d/%m/%Y". Declarar el formato evita depender de una suposición regional. La resta entre 18 y 15 de enero devuelve tres días. Una fecha y un instante con hora/zona son tipos y preguntas diferentes; aquí trabajamos con Date.

## Traza y caso de borde

En el primer ejemplo hay tres registros, dos observados y un faltante. En el segundo, alta recibe código 3 en un factor ordenado declarado y los textos numéricos se convierten en 10 y 20. La fecha calculada usa el formato explícito.

La práctica agrega una categoría desconocida y un vector totalmente faltante. Describe de dónde salió cada NA: un valor ausente de origen y una conversión fallida no deberían mezclarse sin dejar rastro.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Faltante no equivale a cero

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Faltante no equivale a cero
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
x <- c(0, 10, NA_real_)
stopifnot(is.na(mean(x)), mean(x, na.rm = TRUE) == 5)
validos <- sum(!is.na(x))
cat("Registros:", length(x), "; observados:", validos, "; faltantes:", sum(is.na(x)), "
")
cat("Media observada:", mean(x, na.rm = TRUE), "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad04-faltantes-factores/ejemplos/01.R
```

Salida esperada:

```text
Registros: 3 ; observados: 2 ; faltantes: 1
Media observada: 5
```

### Ejemplo 2. Factor y fecha explícitos

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Factor y fecha explícitos
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
nivel <- factor(c("alta", "baja", "media"), levels = c("baja", "media", "alta"), ordered = TRUE)
codigo <- factor(c("10", "20"))
correcto <- as.numeric(as.character(codigo))
fechas <- as.Date(c("15/01/2026", "18/01/2026"), format = "%d/%m/%Y")
stopifnot(identical(as.integer(nivel), c(3L, 1L, 2L)), identical(correcto, c(10, 20)))
stopifnot(as.numeric(fechas[2] - fechas[1]) == 3)
cat("Factor: códigos", paste(as.integer(codigo), collapse = ","), "; valores", paste(correcto, collapse = ","), "
")
cat("Días transcurridos:", as.numeric(fechas[2] - fechas[1]), "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad04-faltantes-factores/ejemplos/02.R
```

Salida esperada:

```text
Factor: códigos 1,2 ; valores 10,20
Días transcurridos: 3
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad03-vectores/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-tablas/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2004%20%28Datos%20faltantes%2C%20factores%20y%20fechas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
