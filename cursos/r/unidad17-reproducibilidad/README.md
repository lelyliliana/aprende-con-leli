# Unidad 17. Proyectos e informes con Quarto

[Anterior](../unidad16-regresion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-proyecto/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Reconstruir resultados desde fuentes y archivos del proyecto.
- Registrar datos, entorno y límites de reproducibilidad.
- Renderizar un informe sin depender de objetos guardados.

## Un proyecto conserva rutas y decisiones

Curso-R.Rproj fija una raíz de trabajo y evita restaurar automáticamente un espacio de objetos. Los datos, funciones, ejemplos e informe tienen rutas relativas a esa raíz. Una entrega no debe depender de que otra persona cree antes una variable en una consola privada.

Rscript --vanilla ejecuta los ejemplos en procesos nuevos. Quarto ejecuta los bloques del informe al renderizar. El documento lee datos y funciones desde el proyecto, con execute-dir configurado para esa raíz. Esto hace explícito de dónde sale cada tabla y figura.

## R, editor y Quarto son herramientas diferentes

Instala Quarto desde su [sitio oficial](https://quarto.org/docs/get-started/). Algunas instalaciones de RStudio incluyen una versión, pero comprueba `quarto --version` en la terminal que usarás. La guía del entorno explica ese paso por separado de instalar paquetes R.

Desde la raíz del curso ejecuta `quarto render proyecto/informe.qmd`. La salida queda en salidas/informe/proyecto/informe.html. Ese HTML se puede abrir en un navegador. La primera entrega usa HTML y no requiere instalar un sistema LaTeX para PDF.

## Código y narración se mantienen relacionados

El archivo .qmd combina texto, cabecera YAML y bloques R. La pregunta, la lectura validada, el resumen y el gráfico forman una secuencia. Las expresiones en línea obtienen cantidad de registros y faltantes del mismo objeto, evitando escribir cifras que puedan quedarse desactualizadas.

Los datos son ficticios y el informe lo declara. La sección de interpretación comunica su alcance. No se agrega una prueba estadística solo porque esté disponible: el propósito de esa entrega es describir el archivo y mostrar un análisis reconstruible.

## Registrar no equivale a congelar

sessionInfo registra R, sistema y paquetes. La huella de datos ayuda a identificar qué archivo se analizó; no certifica calidad ni autoría. El curso registra las versiones comprobadas y mínimos requeridos, pero instalar versiones posteriores de CRAN no crea por sí solo un entorno idéntico.

Para congelar un proyecto que necesite restauración exacta puedes estudiar renv y conservar su lockfile después de comprobarlo. La primera versión de este curso no presenta su registro de sesión como ese bloqueo. Una semilla tampoco congela todas las bibliotecas ni todos los algoritmos futuros.

## Comprobación de cierre

Renderiza desde una sesión limpia y comprueba pregunta, números, figura, unidades, faltantes y límites. Si cambias los datos, revisa que el documento se regenere y que no sobreviva una afirmación escrita manualmente que ya no coincida con el cálculo.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Datos y entorno identificables

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Datos y entorno identificables
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz(); comprobar_paquetes()
d <- leer_encuesta()
identidad <- tools::md5sum("datos/encuesta.csv")
stopifnot(nchar(unname(identidad)) == 32, nrow(d) == 36)
dir.create("salidas", showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "salidas/sesion.txt", useBytes = TRUE)
cat("Datos identificados por huella; sesión y versiones registradas
")
cat("El informe se renderiza desde el proyecto, no desde objetos de una consola anterior.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad17-reproducibilidad/ejemplos/01.R
```

Salida esperada:

```text
Datos identificados por huella; sesión y versiones registradas
El informe se renderiza desde el proyecto, no desde objetos de una consola anterior.
```

### Ejemplo 2. Repetir el cálculo conservando el resultado

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Repetir el cálculo conservando el resultado
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
a <- resumir_encuesta(leer_encuesta())
b <- resumir_encuesta(leer_encuesta())
stopifnot(identical(a, b), sum(a$n) == 36, sum(a$n_horas) == 33)
cat("Dos lecturas y cálculos independientes: mismo resumen; 36 registros, 33 horas observadas
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad17-reproducibilidad/ejemplos/02.R
```

Salida esperada:

```text
Dos lecturas y cálculos independientes: mismo resumen; 36 registros, 33 horas observadas
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad16-regresion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-proyecto/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2017%20%28Proyectos%20e%20informes%20con%20Quarto%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
