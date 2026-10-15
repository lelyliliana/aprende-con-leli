# Unidad 01. R, RStudio y primera ejecución

[Anterior](../unidad00-ruta/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-objetos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Distinguir el lenguaje R, el editor y Quarto.
- Abrir un proyecto y ejecutar desde su raíz.
- Comparar una predicción con una salida real.

## Paso 1. Instalar R

Instala R desde [CRAN](https://cran.r-project.org/). Elige el instalador de Windows, macOS o las instrucciones de tu distribución Linux. El curso requiere R 4.3 o superior; la guía de entorno registra la versión utilizada al verificarlo. R es el lenguaje y su entorno de ejecución.

## Paso 2. Elegir un editor

Puedes instalar [RStudio Desktop](https://posit.co/download/rstudio-desktop/) o utilizar un editor que ya permita ejecutar R. RStudio ofrece consola, editor, archivos y gráficos en paneles. Instalar RStudio no reemplaza la instalación de R. Quarto se usará para el informe de la Unidad 17; no necesitas renderizar documentos para comenzar a calcular.

## Paso 3. Obtener y abrir el proyecto

Descarga o clona Aprende con Leli siguiendo [el entorno](../docs/ENTORNO.md). Abre cursos/r/Curso-R.Rproj. La raíz de este proyecto es la carpeta cursos/r, donde están datos, scripts y las unidades. Desde ese punto se interpretan las rutas relativas de los ejemplos.

En la consola R ejecuta primero `R.version.string`. Después ejecuta `getwd()` y comprueba que la carpeta contenga Curso-R.Rproj. Si no lo contiene, abre el proyecto correcto antes de continuar. No sustituyas rutas por carpetas personales dentro del código compartido.

## Paso 4. Preparar paquetes

Desde la consola de ese proyecto ejecuta `source("scripts/instalar_paquetes.R")`. Este paso necesita Internet y prepara los paquetes declarados. Se realiza al preparar el entorno, no en cada ejemplo. Usaremos primero R base y después paquetes específicos para tablas, archivos, gráficos y documentos. Instalar un paquete y cargarlo en una sesión son acciones distintas.

## Paso 5. Ejecutar un archivo completo

La terminal del proyecto puede ejecutar `Rscript --vanilla unidad01-entorno/ejemplos/01.R`. Rscript ejecuta un archivo; la consola de R acepta expresiones R y no interpreta ese comando de terminal como código del lenguaje. --vanilla evita restaurar objetos y perfiles de una sesión anterior.

Predice 2+3×4 antes de ejecutar: multiplicar tiene prioridad sobre sumar. El segundo ejemplo calcula la media de tres valores y no necesita que hayas creado antes un objeto en la consola. Si falta una herramienta, corrige el entorno antes de alterar el ejercicio.

[Apoyo de consulta: cómo leer el código](../docs/LECTURA-DE-CODIGO.md). Busca una expresión cuando la necesites y vuelve a esta lección.

## Clase guiada. Tu primer archivo, desde una sesión vacía

R interpreta instrucciones y calcula. RStudio es una aplicación que facilita escribirlas y ejecutarlas. Un archivo terminado en .R conserva las instrucciones como texto; un resultado que apareció en una consola no queda automáticamente guardado como programa. Quarto combinará texto y cálculo en un informe, pero todavía no es necesario para esta primera clase.

### 1. Reconoce dónde estás escribiendo

En la consola de R suele aparecer el indicador `>`. Es una señal de que espera una expresión, no algo que debas copiar al archivo. Si queda un paréntesis o una comilla sin cerrar puede aparecer `+`: R espera el resto de esa misma expresión. Completa el cierre o cancela la instrucción antes de comenzar otra. No copies los indicadores como parte del código.

La terminal del sistema recibe comandos como Rscript. La consola recibe expresiones como `2 + 3`. RStudio puede mostrar ambos paneles; el nombre del panel y el tipo de instrucción importan más que su posición exacta en la pantalla.

### 2. Comprueba primero la carpeta

Abre Curso-R.Rproj y consulta getwd(). Una ruta como datos/encuesta.csv significa «entra en datos desde la carpeta de trabajo». No significa «busca el archivo en todo el computador». El proyecto debe situarte en cursos/r. file.exists("Curso-R.Rproj") comprueba que allí esté el archivo esperado; si devuelve FALSE, corrige la carpeta antes de modificar el código.

### 3. Predice dos expresiones

En `2 + 3 * 4`, primero se multiplica 3 por 4 y luego se suma 2: resultado 14. En `(2 + 3) * 4`, el paréntesis obliga a sumar antes: resultado 20. Escribe ambas predicciones antes de ejecutar. Esto permite distinguir una sorpresa del lenguaje de un error al copiar.

### 4. Guarda y ejecuta un archivo completo

El laboratorio guarda cada resultado con `<-`, que significa asignar un nombre a un valor. print muestra el contenido de ese nombre. stopifnot revisa que las condiciones escritas sean verdaderas; si no lo son, detiene el archivo. No calcula una respuesta correcta por ti: convierte una expectativa explícita en una comprobación. cat escribe un mensaje de cierre y `\n` añade un salto de línea.

Ejecuta el archivo completo desde la raíz. Si modificas una expresión, guarda antes de volver a usar Rscript: la terminal lee la versión del disco. Ejecutar una línea seleccionada del editor no necesariamente ejecuta las instrucciones anteriores que necesita.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
# El archivo contiene todas las entradas que necesita.
sin_parentesis <- 2 + 3 * 4
con_parentesis <- (2 + 3) * 4
print(sin_parentesis)
print(con_parentesis)
stopifnot(sin_parentesis == 14, con_parentesis == 20)
cat("Las dos expresiones se calcularon desde este archivo.\n")
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad01-entorno/ejemplos/laboratorio.R
```

Salida esperada:

```text
[1] 14
[1] 20
Las dos expresiones se calcularon desde este archivo.
```

### Lectura del laboratorio

Las dos primeras asignaciones son las entradas del cálculo. Después, print muestra 14 y 20 en ese orden. R añade `[1]` al imprimir un vector: indica que el primer elemento mostrado ocupa la posición uno; no es parte del resultado numérico. La línea stopifnot confirma las dos predicciones y no imprime nada cuando se cumplen. Un archivo silencioso no necesariamente está detenido.

Ejecuta de nuevo desde otra sesión limpia. Debes obtener lo mismo porque todas las entradas están en el archivo. Con source desde una consola puedes obtener el mismo resultado, pero esa consola también puede contener objetos anteriores; la sesión limpia ayuda a detectar dependencias accidentales.

## Experimenta

Cambia únicamente 4 por 5 en las dos expresiones y predice 17 y 25. Ajusta también las expectativas del laboratorio de tu copia, explicando primero la cuenta. Después vuelve al ejemplo original. Cambiar una comprobación sin entender por qué fallaba elimina evidencia útil.

## Errores frecuentes

| Señal | Revisión concreta |
|---|---|
| Rscript no se reconoce en la consola R | Usa la terminal o source con la ruta del archivo |
| No se puede abrir el archivo | Comprueba getwd, nombre y proyecto extraído del ZIP |
| Sigue apareciendo el resultado antiguo | Guarda el archivo antes de ejecutarlo |
| Aparece el indicador + | Revisa comillas y paréntesis sin cerrar |

## Autoevaluación

¿Qué diferencia hay entre escribir código, guardarlo y ejecutarlo? ¿Por qué getwd no informa la versión de R? ¿Qué demuestra que una sesión limpia obtenga 14 y 20? Responde antes de mirar las soluciones.


## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Primera sesión comprobable

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Primera sesión comprobable
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
compatible <- getRversion() >= "4.3.0"
stopifnot(compatible)
resultado <- 2 + 3 * 4
stopifnot(resultado == 14)
cat("R compatible:", compatible, "
")
cat("2 + 3 * 4 =", resultado, "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad01-entorno/ejemplos/01.R
```

Salida esperada:

```text
R compatible: TRUE
2 + 3 * 4 = 14
```

### Ejemplo 2. Consultar un resultado sin objetos previos

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Consultar un resultado sin objetos previos
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
puntajes <- c(7, 8, 9)
resultado <- mean(puntajes)
stopifnot(resultado == 8, length(puntajes) == 3)
cat("Datos:", paste(puntajes, collapse = ", "), "
")
cat("Media:", resultado, "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad01-entorno/ejemplos/02.R
```

Salida esperada:

```text
Datos: 7, 8, 9
Media: 8
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad00-ruta/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-objetos/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2001%20%28R%2C%20RStudio%20y%20primera%20ejecuci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
