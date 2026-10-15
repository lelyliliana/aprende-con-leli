# Construir el proyecto una etapa cada vez

[Proyecto](README.md) · [Unidad 18](../unidad18-proyecto/README.md) · [Curso](../README.md)

La pregunta es: **¿cómo se distribuyen los puntajes por grupo en la encuesta ficticia?** Construiremos lectura, resumen, figura y entrega antes de conectar el informe. Las etapas repiten lo anterior para que cada archivo pueda ejecutarse completo en una sesión limpia. No necesitas conservar objetos entre ejecuciones.

Trabaja desde cursos/r, después de estudiar las unidades 01 a 17. Crea la carpeta salidas si todavía no existe. Crea en el editor salidas/mi-analisis.R para escribir tu propia construcción. Empieza con la primera etapa y ejecútala. Solo añade el siguiente bloque cuando hayas explicado y comprobado el anterior. Los archivos enlazados son versiones completas con las que puedes contrastar tu avance.

Los datos son de práctica. Mantén datos/encuesta.csv sin modificaciones y utiliza salidas/construccion para los productos, que pueden reemplazarse al repetir. Si falta un paquete o una biblioteca gráfica, revisa la [guía de entorno](../docs/ENTORNO.md).

## Etapa 1. Leer y validar antes de calcular

Antes de escribir: identifica las seis columnas en el diccionario. id, grupo y satisfaccion se interpretan como texto; edad, horas_semana y puntaje como cantidades numéricas. El vacío está permitido en horas y satisfacción, pero no en ID o puntaje.

source carga las definiciones compartidas; comprobar_raiz evita resolver rutas desde otra carpeta. read.csv interpreta el archivo y validar_encuesta comprueba el contrato. Abre esa función: reconoce controles de columnas, identidad, categorías y dominios. Una lectura sintácticamente exitosa todavía podría contener un puntaje negativo.

Escribe primero hasta validar_encuesta y consulta str(datos) en una exploración. Después añade las condiciones de comprobación. No añadas un resumen hasta que puedas explicar por qué hay 36 registros y solo 33 horas conocidas.

[Versión completa](pasos/01-leer.R) · [Salida comprobada](pasos/01-leer.txt)

```r
# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
cat("Etapa 1: 36 registros validados; 3 horas faltantes.\n")
```

Ejecuta desde la terminal del proyecto:

```text
Rscript --vanilla proyecto/pasos/01-leer.R
```

Salida esperada:

```text
Etapa 1: 36 registros validados; 3 horas faltantes.
```

**Antes de continuar:** Debes obtener el mensaje de 36 registros y 3 horas faltantes. Explica qué comprobación fallaría ante ID duplicado, puntaje negativo o grupo desconocido. No cambies el archivo original para «corregir» una prueba. Si el conteo no coincide, revisa raíz, archivo y reglas de lectura antes de seguir.

## Etapa 2. Añadir un resumen con denominadores

Conserva la lectura validada y añade group_by/summarise. Cada fila del resultado representará un grupo, no una persona. n() cuenta registros y sum(!is.na(horas_semana)) cuenta mediciones conocidas. media_horas omite ausencias solo después de distinguir el caso donde todas faltan. media_puntaje usa las 18 cantidades del grupo porque ese campo es obligatorio.

Antes de ejecutar, escribe qué esperas: dos filas, n=18 por grupo y n_horas=17/16. En una cuenta manual de un grupo pequeño ya sabes por qué el denominador de horas puede diferir del tamaño. .groups="drop" termina la agrupación y hace explícita la forma de salida.

En tu archivo añade ese bloque antes del mensaje final. Contrasta names(resumen), nrow(resumen) y sus denominadores. No cambies una expectativa para ocultar un archivo de entrada distinto: explica primero de dónde procede la diferencia.

[Versión completa](pasos/02-resumir.R) · [Salida comprobada](pasos/02-resumir.txt)

```r
# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
resumen <- datos |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas_semana)),
    media_horas = if (all(is.na(horas_semana))) NA_real_ else mean(horas_semana, na.rm = TRUE),
    media_puntaje = mean(puntaje), .groups = "drop")
stopifnot(nrow(resumen) == 2, sum(resumen$n) == 36, sum(resumen$n_horas) == 33)
cat("Etapa 2: 2 grupos; n=18/18; n_horas=17/16.\n")
```

Ejecuta desde la terminal del proyecto:

```text
Rscript --vanilla proyecto/pasos/02-resumir.R
```

Salida esperada:

```text
Etapa 2: 2 grupos; n=18/18; n_horas=17/16.
```

**Antes de continuar:** La suma de n debe ser 36 y la de n_horas 33. Explica por qué no sería correcto dividir la suma de horas siempre entre 18. Si falta toda la variable de un grupo, debe comunicarse ausencia de media y cero observados, no una media cero.

## Etapa 3. Añadir la figura y abrirla

Mantén los bloques de lectura y resumen. Construye una figura con grupo en x y puntaje en y. La caja resume la distribución y los puntos conservan observaciones individuales. outlier.shape=NA evita dibujar por segunda vez los puntos extremos de la caja; no elimina filas de los datos. El jitter solo desplaza horizontalmente y su semilla hace repetible ese recurso visual.

Añade título, ejes y una leyenda de origen ficticio. La carpeta se crea después de validar y calcular. ggsave escribe SVG con dimensiones declaradas. Esta versión usa los colores predeterminados; la función figura_encuesta de la entrega final añade la paleta del curso, conservando el razonamiento de las capas.

Predice qué necesita cambiar si representaras horas en vez de puntaje: variable, unidad, cantidad observada y declaración de faltantes. No hagas ese cambio sustituyendo solo la etiqueta del eje.

[Versión completa](pasos/03-graficar.R) · [Salida comprobada](pasos/03-graficar.txt)

```r
# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
resumen <- datos |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas_semana)),
    media_horas = if (all(is.na(horas_semana))) NA_real_ else mean(horas_semana, na.rm = TRUE),
    media_puntaje = mean(puntaje), .groups = "drop")
stopifnot(nrow(resumen) == 2, sum(resumen$n) == 36, sum(resumen$n_horas) == 33)
figura <- ggplot2::ggplot(datos, ggplot2::aes(x = grupo, y = puntaje, fill = grupo)) +
  ggplot2::geom_boxplot(width = 0.45, outlier.shape = NA) +
  ggplot2::geom_point(position = ggplot2::position_jitter(width = 0.07, height = 0, seed = 23), alpha = 0.7) +
  ggplot2::labs(title = "Puntajes por grupo: construcción guiada", x = "Grupo", y = "Puntaje (0 a 100)",
    caption = "Datos ficticios. Descripción del archivo; no demuestra una causa.") +
  ggplot2::theme_minimal() + ggplot2::theme(legend.position = "none")
carpeta <- "salidas/construccion"
dir.create(carpeta, recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave(file.path(carpeta, "puntajes.svg"), figura, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(file.path(carpeta, "puntajes.svg"))$size > 1000)
cat("Etapa 3: SVG en salidas/construccion/puntajes.svg.\n")
```

Ejecuta desde la terminal del proyecto:

```text
Rscript --vanilla proyecto/pasos/03-graficar.R
```

Salida esperada:

```text
Etapa 3: SVG en salidas/construccion/puntajes.svg.
```

**Antes de continuar:** Abre salidas/construccion/puntajes.svg. Deben distinguirse dos grupos y sus observaciones, con unidad de puntaje y origen ficticio. Revisa título, cortes y legibilidad. La existencia y el tamaño del archivo son comprobaciones mínimas, no una evaluación visual completa.

## Etapa 4. Escribir y releer los productos

Conserva todo lo anterior y añade escritura. write.csv exporta el resumen sin convertir nombres de fila en una columna. El registro JSON identifica archivo, huella, cantidades y versión de R. capture.output(sessionInfo()) obtiene texto de sesión para guardarlo. file.path construye rutas sin depender del separador particular del sistema operativo.

Relee el CSV de salida y contrasta sus cuentas. Conservar el objeto resumen en memoria no demuestra que se haya escrito correctamente. Aplica la misma idea al JSON: ábrelo y comprueba filas=36, horas_observadas=33 y datos_ficticios=true. La huella registra el archivo usado; no certifica su calidad ni autenticidad.

Predice qué archivos se reemplazarán al repetir el mismo programa. Usa esta carpeta para resultados reproducibles de práctica y conserva fuentes y datos originales. La escritura es directa y puede quedar parcial ante una interrupción; este ejemplo no implementa una transacción de archivos.

[Versión completa](pasos/04-entregar.R) · [Salida comprobada](pasos/04-entregar.txt)

```r
# Construcción del proyecto. Ejecutar desde cursos/r.
source("src/curso.R", encoding = "UTF-8")
comprobar_raiz()
datos <- read.csv("datos/encuesta.csv",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "character"),
  na.strings = "", fileEncoding = "UTF-8", check.names = FALSE)
validar_encuesta(datos)
stopifnot(nrow(datos) == 36, sum(is.na(datos$horas_semana)) == 3)
resumen <- datos |>
  dplyr::group_by(grupo) |>
  dplyr::summarise(n = dplyr::n(), n_horas = sum(!is.na(horas_semana)),
    media_horas = if (all(is.na(horas_semana))) NA_real_ else mean(horas_semana, na.rm = TRUE),
    media_puntaje = mean(puntaje), .groups = "drop")
stopifnot(nrow(resumen) == 2, sum(resumen$n) == 36, sum(resumen$n_horas) == 33)
figura <- ggplot2::ggplot(datos, ggplot2::aes(x = grupo, y = puntaje, fill = grupo)) +
  ggplot2::geom_boxplot(width = 0.45, outlier.shape = NA) +
  ggplot2::geom_point(position = ggplot2::position_jitter(width = 0.07, height = 0, seed = 23), alpha = 0.7) +
  ggplot2::labs(title = "Puntajes por grupo: construcción guiada", x = "Grupo", y = "Puntaje (0 a 100)",
    caption = "Datos ficticios. Descripción del archivo; no demuestra una causa.") +
  ggplot2::theme_minimal() + ggplot2::theme(legend.position = "none")
carpeta <- "salidas/construccion"
dir.create(carpeta, recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave(file.path(carpeta, "puntajes.svg"), figura, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(file.path(carpeta, "puntajes.svg"))$size > 1000)
write.csv(as.data.frame(resumen), file.path(carpeta, "resumen.csv"), row.names = FALSE, fileEncoding = "UTF-8")
registro <- list(datos = "datos/encuesta.csv", md5 = unname(tools::md5sum("datos/encuesta.csv")),
                 filas = nrow(datos), horas_observadas = sum(!is.na(datos$horas_semana)),
                 r = as.character(getRversion()), datos_ficticios = TRUE)
jsonlite::write_json(registro, file.path(carpeta, "registro.json"), auto_unbox = TRUE, pretty = TRUE)
writeLines(capture.output(sessionInfo()), file.path(carpeta, "sesion.txt"), useBytes = TRUE)
comprobacion <- read.csv(file.path(carpeta, "resumen.csv"))
stopifnot(sum(comprobacion$n) == 36, sum(comprobacion$n_horas) == 33)
cat("Etapa 4: resumen, figura, registro y sesión en salidas/construccion.\n")
```

Ejecuta desde la terminal del proyecto:

```text
Rscript --vanilla proyecto/pasos/04-entregar.R
```

Salida esperada:

```text
Etapa 4: resumen, figura, registro y sesión en salidas/construccion.
```

**Antes de continuar:** Debes encontrar resumen.csv, puntajes.svg, registro.json y sesion.txt. Lee los dos primeros productos tabulares/estructurados y abre la figura y la sesión. Explica a otra persona cómo reconstruirlos desde la raíz sin utilizar tu consola anterior.

## Etapa 5. Conectar el informe sin copiar cifras a mano

Abre [informe.qmd](informe.qmd). Lee una parte cada vez:

1. El encabezado declara título, subtítulo y autor. No contiene los resultados del análisis.
2. El bloque preparar carga funciones, lee datos y crea resumen en la sesión del renderizado.
3. Las expresiones R en línea calculan cantidad de registros y faltantes dentro de las oraciones.
4. tabla-grupos presenta el resumen; fig-puntajes construye la figura con título, explicación y texto alternativo.
5. Los párrafos de interpretación declaran el alcance descriptivo. El bloque entorno registra versiones y huella.

Completa esa lectura antes de ejecutar, desde cursos/r:

```text
quarto render proyecto/informe.qmd
```

Abre salidas/informe/proyecto/informe.html y compara la tabla con resumen.csv. No tienen que ser el mismo formato, pero deben comunicar los mismos tamaños y medias. El HTML debe mostrar 36 registros, 3 horas faltantes y denominadores 17/16. La figura final usa la misma entrada, aunque su estilo se define en figura_encuesta.

Para construir tu propia variante, duplica todo el proyecto siguiendo la Unidad 17. En esa copia cambia título, pregunta y redacción manteniendo explícito el origen ficticio. Si cambias datos o cálculos, vuelve a comprobar cifras y límites. Un párrafo fijo puede quedar desactualizado aunque una cifra en línea se recalcule correctamente.

## De las etapas a una función reutilizable

Compara tus bloques con [analizar.R](analizar.R). Su función ejecutar_analisis recibe entrada y carpeta_salida para no ocultar esas decisiones. leer_encuesta concentra lectura y validación; resumir_encuesta concentra el bloque de resumen; figura_encuesta concentra la figura. Cada función tiene un propósito que ya construiste por separado.

El condicional sys.nframe()==0L permite que el archivo ejecute su llamada principal cuando se usa Rscript, mientras source carga la función sin lanzar automáticamente la entrega. Es un detalle de organización de este proyecto; no necesitas modificarlo para cambiar el argumento de una llamada. Comprueba qué ocurre antes de añadir efectos de escritura a un archivo que también se importa.

## Evaluar con evidencias

| Criterio | Producto verificable (10 puntos) | Explicación (10 puntos) |
|---|---|---|
| Pregunta y diccionario | Pregunta, variables y clave identificadas | Alcance descriptivo y origen ficticio justificados |
| Calidad | Validación y prueba de rechazo previo | Ausencias, dominios y decisiones explicados |
| Transformaciones | Resumen reproducible con tamaños correctos | Denominadores y cambio de unidad por fila defendidos |
| Visualización e interpretación | Figura legible e informe coherente | Distribución, unidad y límites interpretados |
| Reproducción | Fuentes, comandos, entorno y productos completos | Otra persona puede reconstruir y revisar el proceso |

Para autoevaluarte, asigna los puntos de cada mitad según la evidencia que puedas mostrar. Si falta un producto o una explicación, registra qué debes completar. No se concede una nota automática por obtener el mensaje de cierre del programa.

## Cierre y transferencia

Vuelve a la práctica de la Unidad 18 para probar el rechazo de una entrada inválida en una carpeta nueva. Después redefine pregunta, unidad y diccionario para ambiental.csv. No reutilices el validador de encuesta con columnas distintas. El aprendizaje transferible es revisar identidad, cantidades conocidas y alcance antes de calcular.

[Volver al proyecto](README.md) · [Práctica final](../unidad18-proyecto/PRACTICA.md) · [Soluciones](../unidad18-proyecto/SOLUCIONES.md)
