# Unidad 18. Proyecto integrador y transferencia

[Anterior](../unidad17-reproducibilidad/README.md) · [Índice](../README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Entregar un análisis descriptivo reconstruible.
- Rechazar datos fuera del contrato antes de generar resultados.
- Transferir el razonamiento a otra unidad de observación.

## Define una entrega pequeña y completa

El proyecto responde cómo se distribuyen puntajes por grupo en una encuesta ficticia. Entrega entrada, diccionario, código, resumen CSV, figura SVG, registro de ejecución e informe HTML. Otra persona debe poder reconstruirlo desde la raíz del curso.

El flujo de analizar.R valida primero, calcula después y escribe al final. Si un puntaje es negativo, el contrato de este archivo se incumple antes de crear la carpeta de salida. Ese orden evita presentar un resultado generado a partir de una entrada rechazada. No es una garantía transaccional ante fallos de escritura de disco: los archivos se escriben directamente.

## Qué debe explicar el informe

Registra pregunta, unidad, origen ficticio, reglas de calidad, cantidad de registros y denominadores. Describe distribución sin convertir la modalidad en una causa del puntaje. Señala faltantes y la ausencia de un muestreo real que permita generalizar a estudiantes de una población.

La gráfica complementa el resumen. Un promedio de grupo no muestra por sí solo dispersión, y una imagen atractiva no justifica las reglas de limpieza. El registro de versiones y huella documenta cómo se produjo esa salida, con el alcance explicado en la Unidad 17.

## Evaluación con evidencia

| Criterio | Puntos | Evidencia |
|---|---|---|
| Pregunta, unidad y diccionario | 20 | Definiciones y datos identificables |
| Calidad y decisiones | 20 | Validación, faltantes e incidencias |
| Transformación y resúmenes | 20 | Código, denominadores y comprobaciones |
| Visualización e interpretación | 20 | Figura legible, unidades y alcance |
| Reproducción y entrega | 20 | Comandos, entorno e informe generado |

Los cien puntos orientan autoevaluación. Una cifra o captura sin el código que la reconstruye deja evidencia incompleta. No se obtiene una conclusión estadística más fuerte por acumular herramientas.

## Transferir al caso ambiental

ambiental.csv tiene doce registros por estación/fecha, con once conteos observados. Un faltante no es cero. La suma observada por estación no mide automáticamente abundancia de fauna: esa conclusión requeriría diseño, esfuerzo de observación, detección, definición de población y otros elementos que no están en el archivo docente.

La transferencia consiste en volver a definir unidad, diccionario, faltantes y pregunta antes de reutilizar un resumen. No basta cambiar el nombre del CSV. Las mediciones repetidas de una estación tampoco se vuelven independientes por estar en filas distintas.

## Cierre del curso

Repite todos los ejemplos y soluciones con el verificador. Renderiza tu informe y entrega una explicación que otra persona pueda revisar. Una ampliación útil incorpora una nueva regla o pregunta con evidencia, sin ocultar límites del diseño original.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Ejecutar la entrega mínima

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Ejecutar la entrega mínima
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("proyecto/analizar.R", encoding = "UTF-8")
r <- ejecutar_analisis("datos/encuesta.csv", "salidas/proyecto")
stopifnot(sum(r$resumen$n) == 36, file.exists("salidas/proyecto/resumen.csv"), file.exists("salidas/proyecto/puntajes.svg"))
cat("Proyecto: resumen, gráfico y registro de ejecución generados con datos ficticios
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad18-proyecto/ejemplos/01.R
```

Salida esperada:

```text
Proyecto: resumen, gráfico y registro de ejecución generados con datos ficticios
```

### Ejemplo 2. Transferir al caso ambiental

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Transferir al caso ambiental
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
d <- read.csv("datos/ambiental.csv", na.strings = "", fileEncoding = "UTF-8")
d$fecha <- as.Date(d$fecha)
r <- d |> dplyr::group_by(estacion) |> dplyr::summarise(registros = dplyr::n(),
  observados = sum(!is.na(conteo)), total_observado = sum(conteo, na.rm = TRUE), .groups = "drop")
stopifnot(nrow(r) == 2, sum(r$registros) == 12, sum(r$observados) == 11)
cat("Caso ambiental ficticio: 12 registros, 11 conteos observados; 2 estaciones
")
cat("Un faltante no es cero y el total observado no mide por sí solo abundancia poblacional.
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad18-proyecto/ejemplos/02.R
```

Salida esperada:

```text
Caso ambiental ficticio: 12 registros, 11 conteos observados; 2 estaciones
Un faltante no es cero y el total observado no mide por sí solo abundancia poblacional.
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad17-reproducibilidad/README.md) · [Índice](../README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2018%20%28Proyecto%20integrador%20y%20transferencia%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
