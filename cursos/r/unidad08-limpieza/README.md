# Unidad 08. Calidad, limpieza y trazabilidad

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-transformaciones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Conservar la entrada y registrar decisiones por fila.
- Distinguir duplicados equivalentes de contradicciones.
- Separar transformación de validación del dominio.

## Limpiar no significa borrar lo incómodo

Una limpieza debe explicar qué cambió, por qué y qué información quedó excluida. El archivo encuesta_sucia tiene ocho filas construidas para estudiar espacios, etiquetas, coma decimal, faltantes, duplicados y valores fuera del diccionario. El original se conserva separado del candidato transformado.

La función limpiar_entrada normaliza el grupo con trimws y toupper y convierte campos numéricos con una política declarada de coma decimal. Convertir texto a número puede crear NA: una edad "xx" no se transforma en una ausencia aceptable solo porque el programa ya puede continuar.

## Duplicación requiere identidad y comparación

Las filas 2 y 3 representan el mismo ID y, tras normalizar, los mismos valores. Para este caso docente se conserva la primera aparición equivalente. No es una regla de resolver cualquier conflicto por orden del archivo.

Si ambas filas del mismo ID contradicen puntaje u otro dato, la función rechaza el archivo y pide revisión. Elegir sin evidencia la primera o la más reciente cambiaría el análisis. El programa tampoco deduce identidad a partir del nombre de una persona: utiliza la clave del diccionario.

## Tabla de decisiones del caso

| Filas originales | Situación | Resultado |
|---|---|---|
| 1, 2 y 6 | Datos dentro del dominio tras conversión | Se aceptan |
| 3 | Repetición equivalente de S02 | Se marca duplicada |
| 4 | Edad no interpretable | Se registra inválida |
| 5 | Horas negativas | Se registra inválida |
| 7 | Grupo C no admitido | Se registra inválida |
| 8 | Puntaje 105 | Se registra inválida |

El faltante de horas de S05 permanece NA porque ese campo admite ausencia. El resultado contiene tres filas aceptadas, una duplicada y cuatro inválidas. La tabla de incidencias conserva número de fila e ID para rastrear la decisión.

## Validez y plausibilidad

Una medición dentro del rango no está automáticamente libre de errores; solo pasó esa regla. El máximo de 40 horas es una condición del ejercicio y de su diccionario, no una ley universal sobre estudio. La política debe justificarse según la variable y el contexto antes de reutilizarse.

La función rechaza columnas inesperadas e IDs ausentes. No intenta adivinar un esquema o reconstruir identificadores. Una limpieza genérica para cualquier archivo necesitaría otra especificación.

## Qué debes poder explicar

Abre src/curso.R y sigue original, limpio, duplicada, invalida y aceptada. Explica qué información permite comprobar cada vector. La evidencia de cierre incluye el original intacto, el candidato aceptado y la tabla de decisiones, no solo una tabla más pequeña.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Separar aceptados e incidencias

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Separar aceptados e incidencias
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(nrow(r$original) == 8, nrow(r$validas) == 3)
stopifnot(sum(r$incidencias$duplicada) == 1, sum(r$incidencias$invalida) == 4)
stopifnot(identical(r$validas$id, c("S01", "S02", "S05")), r$validas$horas_semana[2] == 7.5)
cat("Originales: 8; aceptados: 3; duplicados: 1; inválidos: 4
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad08-limpieza/ejemplos/01.R
```

Salida esperada:

```text
Originales: 8; aceptados: 3; duplicados: 1; inválidos: 4
```

### Ejemplo 2. Auditar sin reemplazar el original

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Auditar sin reemplazar el original
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
source("src/curso.R", encoding = "UTF-8")
r <- limpiar_entrada()
stopifnot(is.na(r$validas$horas_semana[3]), r$original$horas_semana[2] == "7,5")
stopifnot(sum(!r$incidencias$aceptada) == 5)
cat("Vacío permitido sigue siendo NA; el original conserva 7,5
")
cat("Filas no aceptadas:", paste(r$incidencias$fila[!r$incidencias$aceptada], collapse = ", "), "
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad08-limpieza/ejemplos/02.R
```

Salida esperada:

```text
Vacío permitido sigue siendo NA; el original conserva 7,5
Filas no aceptadas: 3, 4, 5, 7, 8
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-transformaciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2008%20%28Calidad%2C%20limpieza%20y%20trazabilidad%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
