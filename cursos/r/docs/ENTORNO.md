# Preparar el entorno paso a paso

[Curso](../README.md) · [Primera ejecución](../unidad01-entorno/README.md)

## Paso 1. Instalar R

Abre [CRAN](https://cran.r-project.org/) y elige tu sistema. En Windows usa el instalador de R; en macOS elige el instalador compatible con tu arquitectura; en Linux sigue las instrucciones de la distribución. El mínimo del curso es R 4.3. No copies comandos de instalación de otro sistema como si fueran universales.

En macOS instala también [XQuartz](https://www.xquartz.org/) para exportar los gráficos SVG utilizados en el curso. La distribución de R para macOS requiere sus bibliotecas X11 para esta salida; consulta los requisitos de tu versión en [R para macOS](https://mac.r-project.org/bin/macosx/). Completa el instalador y vuelve a abrir R/RStudio; si el instalador solicita cerrar sesión, hazlo antes de continuar. Si aparece un error sobre R_X11.so o libSM.6.dylib al guardar un SVG, comprueba primero esta instalación. No necesitas este paso en Windows o Linux.

## Paso 2. Elegir editor

[RStudio Desktop](https://posit.co/download/rstudio-desktop/) es una opción gratuita para abrir el proyecto, editar scripts y ver gráficos. Instálalo después de R. También puedes usar R con otro editor. La interfaz puede variar entre versiones; los archivos y comandos del curso permiten comprobar la ejecución independientemente del panel elegido.

## Paso 3. Descargar el proyecto

Puedes descargar Aprende con Leli como ZIP desde [GitHub](https://github.com/lelyliliana/aprende-con-leli) y extraerlo. Si utilizas Git, desde la carpeta donde guardarás tu copia:

```text
git clone https://github.com/lelyliliana/aprende-con-leli.git
```

Abre cursos/r/Curso-R.Rproj. Esa carpeta es la raíz del curso. No trabajes con los archivos dentro de un ZIP sin extraer ni cambies rutas por nombres privados de tu equipo.

## Paso 4. Comprobar R y raíz

En la consola R:

```r
R.version.string
getwd()
file.exists("Curso-R.Rproj")
```

La última expresión debe ser TRUE. La consola R recibe expresiones R; una terminal recibe comandos como Rscript. Si abres una terminal externa, cambia primero a cursos/r. En Windows, si Rscript no está en PATH, utiliza la terminal configurada para R o el ejecutable de tu instalación; desde la consola R puedes ejecutar un archivo con source.

## Paso 5. Preparar paquetes

En la consola del proyecto:

```r
source("scripts/instalar_paquetes.R")
```

Necesita Internet. Revisa errores de instalación antes de continuar. Se declaran mínimos para dplyr, tidyr, ggplot2, readr, readxl, knitr, rmarkdown y jsonlite. El script instala faltantes o versiones anteriores al mínimo; no actualiza todo tu entorno por rutina.

Los paquetes viven en una biblioteca de R. Instalarlos no equivale a cargarlos. El curso usa llamadas como dplyr::filter para señalar el paquete y evitar ambigüedades con funciones del mismo nombre.

## Paso 6. Ejecutar un ejemplo

Desde una terminal situada en cursos/r:

```text
Rscript --vanilla unidad01-entorno/ejemplos/01.R
```

Desde la consola R puedes usar:

```r
source("unidad01-entorno/ejemplos/01.R", encoding = "UTF-8")
```

La primera opción ejecuta un proceso nuevo. source evalúa en la sesión que tengas abierta; conserva esa diferencia al interpretar reproducibilidad. La verificación usa procesos nuevos para cada ejemplo y solución.

## Paso 7. Preparar Quarto al llegar al informe

Instálalo desde [Quarto](https://quarto.org/docs/get-started/), abre una terminal nueva y comprueba:

```text
quarto --version
```

Después, desde cursos/r:

```text
quarto render proyecto/informe.qmd
```

Abre salidas/informe/proyecto/informe.html. La entrega HTML no necesita LaTeX. RStudio puede incluir Quarto, pero comprueba la terminal que realmente utilizarás. Registrar versiones no garantiza un entorno idéntico al de otra persona; consulta [verificación](VERIFICACION.md).
