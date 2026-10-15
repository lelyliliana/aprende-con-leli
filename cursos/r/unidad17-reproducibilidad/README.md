# Unidad 17. Proyectos e informes con Quarto

[Anterior](../unidad16-regresion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-proyecto/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Reconstruir resultados desde fuentes y archivos del proyecto.
- Registrar datos, entorno y límites de reproducibilidad.
- Renderizar un informe sin depender de objetos guardados.

## Clase guiada. Construir un informe que vuelva a calcular sus números

Un análisis reproducible conserva entradas, instrucciones y condiciones de ejecución identificables. Un documento que copia a mano una media puede quedar desactualizado cuando cambia el CSV. Quarto permite escribir texto junto a código R que se ejecuta al renderizar, de modo que las cifras calculadas y la figura proceden de las fuentes del proyecto.

### 1. Reconoce las tres piezas de un archivo qmd

El encabezado YAML, entre líneas de tres guiones, contiene título y opciones. El cuerpo tiene texto Markdown. Los bloques marcados como código R ejecutable producen objetos, tablas o figuras. Una expresión R en línea inserta un número dentro de una oración. No pegues un resultado fijo donde esperas que se recalcule.

En proyecto/informe.qmd, el bloque preparar carga funciones, lee la encuesta y construye resumen. El bloque tabla-grupos recibe ese resumen y lo presenta con knitr::kable. El de figura llama figura_encuesta. Lee primero los objetos que cada bloque crea y después los que consume; el orden de ejecución sigue siendo parte del programa.

### 2. Fija desde dónde se interpretan las rutas

El proyecto declara execute-dir:project en _quarto.y ml. Por eso datos/encuesta.csv se busca desde cursos/r aunque el documento viva dentro de proyecto. No dependas de haber creado datos manualmente en la consola antes de renderizar. El informe prepara su propia sesión de cálculo.

### 3. Comprueba que las cifras son calculadas

El HTML debe mostrar 36 registros y 3 horas faltantes porque se obtienen de los datos. La tabla utiliza 18 registros por grupo y 17/16 horas conocidas. Primero contrasta con leer_encuesta; después revisa las frases, títulos y límites del documento. Un renderizado exitoso puede producir un informe mal interpretado si el texto afirma más de lo que el diseño sostiene.

### 4. Haz un experimento en una copia completa

Cierra el proyecto, duplica cursos/r como r-practica-repro y abre el Curso-R.Rproj de esa copia. Verifica getwd antes de editar. Cambia en su CSV el puntaje de la primera fila en+1, conservando el dominio 0 a 100; guarda y renderiza allí. La media del grupo de esa fila debe aumentar 1/18. Reabre después el proyecto original y confirma que no lo modificaste.

El laboratorio prepara esa comparación en memoria, sin tocar el archivo original. La práctica añade el renderizado de la copia para comprobar que el documento consume la entrada cambiada. Son evidencias distintas: repetir una función no demuestra por sí solo que se reconstruyó el HTML.

### 5. Identifica entorno y datos con límites claros

sessionInfo registra versiones y plataforma. tools::md5 sum aporta una huella útil para detectar cambios de archivo en este flujo docente; no prueba autenticidad, calidad de datos ni integridad frente a ataques. Registrar versiones no las instala ni las congela. Un entorno bloqueado necesitaría un mecanismo adicional de resolución y restauración de dependencias, fuera de esta primera ruta.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
original <- leer_encuesta()
copia <- original
copia$puntaje[1] <- copia$puntaje[1] + 1
validar_encuesta(copia)
a <- resumir_encuesta(original)
b <- resumir_encuesta(copia)
grupo_cambiado <- original$grupo[1]
diferencia <- b$media_puntaje[b$grupo == grupo_cambiado] - a$media_puntaje[a$grupo == grupo_cambiado]
stopifnot(abs(diferencia - 1 / 18) < 1e-10, identical(original, leer_encuesta()))
cat("Una modificación de +1 cambia la media de su grupo en 1/18.\n")
cat("La copia cambia; el archivo original y sus 36 registros se conservan.\n")
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad17-reproducibilidad/ejemplos/laboratorio.R
```

Salida esperada:

```text
Una modificación de +1 cambia la media de su grupo en 1/18.
La copia cambia; el archivo original y sus 36 registros se conservan.
```

### Lectura del laboratorio

El código crea original y copia, cambia solo un puntaje, valida y calcula dos resúmenes. El grupo afectado se identifica desde la fila original, evitando asumir su etiqueta. La diferencia debe ser 1/18 porque se sumó una unidad entre 18 registros. La última comprobación vuelve a leer el archivo para demostrar que no se editó durante el experimento.

## Experimenta

Antes de ejecutar, predice el cambio que produciría sumar 2 a un puntaje:2/18 en la media de su grupo. Comprueba primero que el valor siga siendo admisible. Luego cambia una hora en vez del puntaje y explica por qué su denominador puede ser 17 o16 en lugar de 18.

## Errores frecuentes

| Error | Revisión |
|---|---|
| El informe funciona solo después de preparar la consola | Haz que su bloque inicial lea y calcule entradas |
| Editar el original para un experimento | Abre y comprueba la ruta de una copia completa |
| Un número fijo queda igual tras cambiar datos | Revisa si está calculado o escrito a mano |
| Afirmar entorno congelado por guardar sessionInfo | Distingue registro, resolución e instalación |

## Autoevaluación

¿Qué ejecuta renderizar y qué conserva el HTML? ¿Por qué cambiar un puntaje en+1 afecta la media en 1/18? ¿Qué no demuestra una huella del CSV? ¿Qué diferencia hay entre registrar y bloquear versiones?


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
