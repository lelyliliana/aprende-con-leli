# Unidad 12. Visualización con ggplot2

[Anterior](../unidad11-formatos/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-descriptiva/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Relacionar tipo de variable, pregunta y geometría.
- Declarar unidades, denominadores y tratamiento de faltantes.
- Guardar figuras que puedan reproducirse desde el código.

## Clase guiada. Construir una figura por capas

Una figura debe responder una pregunta y permitir leer variables y unidades. El laboratorio comienza con cuatro pares de horas y puntaje. Un diagrama de puntos permite ver cada par; una caja de distribución o una media sola respondería otra pregunta y ocultaría parte de esa correspondencia.

### 1. Define datos y estética

ggplot(d, aes(x=horas, y=puntaje)) declara la tabla y asigna columnas a los ejes. aes significa mapeo: relaciona variables con propiedades visuales. geom_point añade una marca por observación. Escribir colour="#235789" fuera de aes fija el mismo color para todos; poner una variable dentro de aes permitiría mapearla a colores según sus categorías.

El signo + añade componentes de la figura. Debe quedar al final de la línea que continúa. No es la tubería |>: ggplot construye un objeto gráfico y cada capa aporta una parte de su representación. Guardar ese objeto como g permite imprimirlo o exportarlo después.

### 2. Pon el significado en las etiquetas

labs declara título y nombres de ejes. «Horas semanales» y «Puntaje (0 a 100)» permiten leer las escalas. «Datos ficticios» delimita el origen. theme_minimal cambia la presentación, no los cálculos. Una figura decorada no es evidencia adicional sobre el estudio.

### 3. Exporta y abre el archivo

ggsave recibe ruta, objeto, ancho, alto y dispositivo SVG. Las dimensiones del ejemplo se expresan en pulgadas porque esa es la unidad predeterminada de ggsave. El dispositivo grDevices::svg usa soporte Cairo; la guía de entorno explica el requisito de XQuartz en macOS. Si falla la biblioteca gráfica, corrige el entorno antes de cambiar las mediciones.

La comprobación de existencia y tamaño detecta una exportación ausente o vacía, pero no demuestra que se lean las etiquetas. Abre el SVG, revisa ejes, unidades, títulos, puntos cortados y superposición. La verificación automática complementa esa inspección.

### 4. Escoge otra geometría con una razón

Para comparar distribución de puntajes por grupo usamos caja más puntos. La caja resume cuartiles y mediana; los puntos conservan observaciones individuales. El jitter desplaza ligeramente en horizontal para distinguir coincidencias; height=0 conserva el puntaje vertical. La semilla fija ese desplazamiento y no modifica las mediciones.

Un histograma agrupa una variable numérica en intervalos. Su aspecto depende del ancho y del origen de los cortes. Declarar binwidth y boundary hace esa elección visible; sumar las frecuencias debe recuperar las observaciones incluidas. Para series temporales, las líneas deben relacionar fechas ordenadas dentro de cada estación, evitando conectar estaciones distintas como una sola trayectoria.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
d <- data.frame(horas = c(1, 2, 3, 4), puntaje = c(50, 60, 65, 80))
g <- ggplot2::ggplot(d, ggplot2::aes(x = horas, y = puntaje)) +
  ggplot2::geom_point(size = 3, colour = "#235789") +
  ggplot2::labs(title = "Cuatro observaciones ficticias", x = "Horas semanales", y = "Puntaje (0 a 100)") +
  ggplot2::theme_minimal()
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
archivo <- "salidas/graficos/laboratorio.svg"
ggplot2::ggsave(archivo, g, width = 7, height = 4, device = grDevices::svg)
stopifnot(nrow(ggplot2::ggplot_build(g)$data[[1]]) == 4, file.info(archivo)$size > 1000)
cat("Figura guardada: salidas/graficos/laboratorio.svg\n")
cat("Cuatro puntos, horas en x y puntaje en y; asociación descriptiva.\n")
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad12-graficos/ejemplos/laboratorio.R
```

Salida esperada:

```text
Figura guardada: salidas/graficos/laboratorio.svg
Cuatro puntos, horas en x y puntaje en y; asociación descriptiva.
```

### Lectura del laboratorio

El archivo guardado contiene cuatro puntos con horas en x y puntaje en y. ggplot_build permite revisar la información utilizada por la capa; no necesitas memorizar su estructura interna para diseñar una figura. Aquí comprueba que existen cuatro observaciones representadas. La inspección visual sigue siendo una parte explícita de la práctica.

## Experimenta

Reemplaza el punto de cuatro horas/80 por cuatro horas/50 en una copia. Predice qué marca se moverá y en qué eje. Después añade una segunda observación idéntica: puede quedar superpuesta aunque existan cinco filas. Justifica cuándo mostrarías transparencia o jitter y qué cantidad no debería desplazarse.

## Errores frecuentes

| Error | Revisión |
|---|---|
| Omitir unidad o faltantes | Etiqueta la magnitud y declara registros excluidos |
| Interpretar una línea como prueba causal | Distingue representación y diseño del estudio |
| Comparar histogramas con cortes ocultos | Declara ancho y límites para la comparación |
| Considerar un archivo existente como figura legible | Ábrelo y revisa el contenido |

## Autoevaluación

¿Qué separa aes de geom_point? ¿Por qué el jitter del ejemplo no debe cambiar el puntaje? ¿Por qué dos histogramas de los mismos datos pueden verse distintos?


## Una figura responde a una pregunta

Para comparar distribuciones de puntajes por grupo, una caja y los puntos individuales muestran aspectos complementarios. La caja resume y los puntos hacen visibles las observaciones. Un gráfico de barras con una media podría ocultar dispersión y tamaño; no es una elección neutral si la pregunta es cómo se distribuyen los valores.

El primer ejemplo usa datos ficticios, eje de puntaje 0 a 100 y una leyenda de alcance. El pequeño desplazamiento horizontal de los puntos evita superposición y usa una semilla; no cambia el puntaje vertical. No representa una nueva medición.

## Capas y mapeos

ggplot recibe datos y aes declara qué variable se asigna a cada propiedad visual. Las geometrías añaden capas. Un color fijo fuera de aes y una variable dentro de aes tienen significados distintos: uno decora una capa y el otro codifica información.

Los títulos y ejes deben decir variable y unidad. Elegir colores distintos ayuda a separar grupos, pero también se puede usar posición, etiquetas y formas para no depender exclusivamente del color. El informe incluye texto alternativo para su figura.

## Fechas y grupos en líneas

Para las estaciones ambientales, cada línea debe unir mediciones de una misma estación ordenadas por fecha. group=estacion hace explícito ese recorrido. Una línea que conecte todas las filas en su orden accidental podría unir estaciones diferentes y sugerir una trayectoria inexistente.

La serie tiene seis fechas por estación y datos de temperatura ficticios. Su gráfico no prueba una tendencia climática. El conjunto pequeño permite aprender a ordenar, agrupar y declarar unidades.

## Histograma y faltantes

Un histograma depende del ancho y límites de sus intervalos. La solución declara binwidth=10 y verifica que las frecuencias sumen 36 para puntajes sin faltantes. Otro ancho puede revelar otra apariencia del mismo archivo; justifica tu elección según escala y pregunta.

Si graficas una variable con faltantes, informa cuántas observaciones se usaron. Que una función omita valores ausentes no convierte ese subconjunto en la población original.

## Figura y archivo

ggsave escribe un SVG en salidas/graficos. Es vectorial y se puede abrir en un navegador. La verificación comprueba que se generó y que las capas contienen las observaciones esperadas; la revisión visual complementa esas comprobaciones. No uses una captura manual como única fuente de una figura que necesitas reconstruir.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Distribución y observaciones visibles

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Distribución y observaciones visibles
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
d <- leer_encuesta()
g <- figura_encuesta(d)
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
archivo <- "salidas/graficos/distribucion.svg"
ggplot2::ggsave(archivo, g, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(file.info(archivo)$size > 1000, nrow(ggplot2::ggplot_build(g)$data[[2]]) == 36)
cat("Gráfico SVG: distribución y 36 observaciones; unidad de puntaje declarada
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad12-graficos/ejemplos/01.R
```

Salida esperada:

```text
Gráfico SVG: distribución y 36 observaciones; unidad de puntaje declarada
```

### Ejemplo 2. Fechas ordenadas y series separadas

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Fechas ordenadas y series separadas
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- read.csv("datos/ambiental.csv", na.strings = "", fileEncoding = "UTF-8")
d$fecha <- as.Date(d$fecha)
d <- d[order(d$estacion, d$fecha), ]
g <- ggplot2::ggplot(d, ggplot2::aes(fecha, temperatura_c, colour = estacion, group = estacion)) +
  ggplot2::geom_line(linewidth = 0.8) + ggplot2::geom_point() +
  ggplot2::labs(title = "Temperaturas ficticias por estación", x = "Fecha", y = "Temperatura (°C)", colour = "Estación") +
  ggplot2::theme_minimal()
dir.create("salidas/graficos", recursive = TRUE, showWarnings = FALSE)
ggplot2::ggsave("salidas/graficos/temperatura.svg", g, width = 7, height = 4.5, device = grDevices::svg)
stopifnot(length(unique(ggplot2::ggplot_build(g)$data[[1]]$group)) == 2)
cat("Serie temporal: dos estaciones separadas; 6 fechas por estación
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad12-graficos/ejemplos/02.R
```

Salida esperada:

```text
Serie temporal: dos estaciones separadas; 6 fechas por estación
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad11-formatos/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-descriptiva/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2012%20%28Visualizaci%C3%B3n%20con%20ggplot2%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
