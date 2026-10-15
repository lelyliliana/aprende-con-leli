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
