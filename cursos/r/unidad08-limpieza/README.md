# Unidad 08. Calidad, limpieza y trazabilidad

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-transformaciones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Conservar la entrada y registrar decisiones por fila.
- Distinguir duplicados equivalentes de contradicciones.
- Separar transformación de validación del dominio.

## Clase guiada. Limpiar conservando la explicación del cambio

Una limpieza transforma representaciones bajo reglas conocidas. No convierte automáticamente todos los registros en datos válidos. El laboratorio separa tres piezas: el texto original, el candidato numérico y una marca que indica si la conversión falló. Esa separación permite explicar de dónde salió un NA.

### 1. Conserva el origen antes de normalizar

original contiene " 7, 5 ", "", "texto" y "0". trimws retira espacios en los extremos de una copia. Después se marca el texto vacío como NA. En este pequeño contrato, una coma dentro de una cantidad es decimal; gsub cambia esa coma por punto. No traslades esa regla a cantidades como "1, 234" sin averiguar si expresan miles o decimales.

as.numeric convierte el candidato. La palabra "texto" no se interpreta como cantidad y produce NA. La máscara !is.na(texto) & is.na(candidato) distingue una conversión fallida de una ausencia que ya habías reconocido. El cero sigue siendo una cantidad válida y no una marca de ausencia.

| Original | Candidato | Decisión explicable |
|---|---|---|
| Espacios y 7, 5 | 7.5 | Normalizar con regla decimal declarada |
| Vacío | NA | Conservar ausencia permitida |
| texto | NA | Revisar conversión fallida |
| 0 | 0 | Conservar medición conocida |

### 2. Aplica el dominio después de convertir

Poder convertir "-2" a número no lo hace válido como horas semanales en este curso. También debes comprobar grupo, edad, puntaje y etiquetas. Una variable puede tener tipo correcto y valor fuera del dominio. La función limpiar_entrada devuelve validas, incidencias y original para comparar esas decisiones sin modificar el archivo docente.

### 3. Decide qué significa un duplicado

La encuesta sucia contiene dos representaciones equivalentes de S02. Después de normalizar grupo y decimal coinciden; la política docente conserva su primera aparición. Si uno de los puntajes cambia, ya no son equivalentes. La función rechaza la contradicción y pide revisión en lugar de elegir una respuesta sin evidencia.

No extrapoles «conservar primero» como política universal. En un registro real podrías necesitar fecha de actualización, fuente original o confirmación. Tampoco basta que dos conversiones fallen igual para concluir que los textos originales significaban lo mismo; la auditoría del origen sigue siendo necesaria.

### 4. Contrasta las ocho filas manualmente

Las aceptadas son 1 (S01), 2 (S02) y 6 (S05). La fila 3 es el duplicado equivalente de S02. Las filas 4, 5, 7, 8 tienen, respectivamente, edad no convertible, horas negativas, grupo desconocido y puntaje mayor de 100. S05 se conserva con horas NA porque ese campo admite ausencia. Escribe la razón de cada fila antes de llamar la función y después compara con incidencias.

## Laboratorio guiado

[Archivo completo](ejemplos/laboratorio.R) · [Salida comprobada](ejemplos/laboratorio.txt)

Predice primero, ejecuta el archivo completo y lee después la explicación.

```r
# Laboratorio guiado. Ejecutar desde cursos/r.
original <- c(" 7,5 ", "", "texto", "0")
texto <- trimws(original)
texto[texto == ""] <- NA_character_
candidato <- suppressWarnings(as.numeric(gsub(",", ".", texto, fixed = TRUE)))
fallo_conversion <- !is.na(texto) & is.na(candidato)
auditoria <- data.frame(original, candidato, fallo_conversion)
print(auditoria)
stopifnot(candidato[1] == 7.5, is.na(candidato[2]), fallo_conversion[3], candidato[4] == 0)
stopifnot(identical(original, c(" 7,5 ", "", "texto", "0")))
```

Desde la terminal del proyecto:

```text
Rscript --vanilla unidad08-limpieza/ejemplos/laboratorio.R
```

Salida esperada:

```text
original candidato fallo_conversion
1     7,5        7.5            FALSE
2                 NA            FALSE
3    texto        NA             TRUE
4        0       0.0            FALSE
```

### Lectura del laboratorio

La tabla de auditoría coloca el original junto al candidato y al indicador de fallo. El NA del vacío tiene FALSE en fallo_conversion; el de "texto" tiene TRUE. No los juntes en una categoría genérica de «datos malos» porque exigen decisiones distintas. La comprobación final asegura que la transformación no cambió original.

## Experimenta

Cambia "texto" por "6" y predice que desaparecerá la incidencia de conversión. Después prueba "-2": se convierte correctamente, pero no sería aceptable bajo el dominio de horas. Explica por qué la máscara de conversión por sí sola no valida una variable.

## Errores frecuentes

| Decisión apresurada | Alternativa razonada |
|---|---|
| Borrar toda fila con NA | Distinguir ausencia permitida, campo obligatorio y fallo |
| Sustituir todas las comas del CSV | Separar sintaxis del archivo y contenido del campo |
| Quedarse con el primer ID repetido siempre | Contrastar equivalencia y contradicción |
| Informar solo el total final | Conservar cantidades y motivos de exclusión |

## Autoevaluación

¿Qué demuestra una conversión exitosa y qué queda por validar? ¿Por qué S05 puede aceptarse y S03 no? ¿Qué evidencia necesitas para decidir entre dos puntajes de un mismo ID?


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
