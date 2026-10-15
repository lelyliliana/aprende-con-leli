# Unidad 11. Datos largos, anchos y unidad de observación

[Anterior](../unidad10-uniones/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-graficos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Transformar columnas de medición en filas con identidad explícita.
- Comprobar una clave compuesta antes de volver a formato ancho.
- Distinguir número de filas y número de unidades independientes.

## Dos personas no se vuelven cuatro al pivotar

Una tabla ancha puede tener una fila por persona y columnas antes/despues. Una tabla larga representa una fila por persona y momento. Para dos personas con dos momentos hay cuatro filas, pero siguen siendo dos personas con mediciones relacionadas.

La unidad de observación de una fila y la unidad de independencia estadística no siempre coinciden. Tratar todas las mediciones repetidas como personas distintas podría alterar denominadores e inferencia. Identificar ese cambio de forma es parte del análisis, no un trámite previo.

## Leer pivot_longer como una decisión

pivot_longer toma las columnas antes/despues, guarda sus nombres en momento y sus valores en puntaje. ID se conserva para identificar de quién es cada medición. names_to y values_to hacen explícito qué significaban los encabezados de origen.

Una tabla larga facilita agrupar por momento o dibujar mediciones. No es universalmente superior: para calcular una diferencia por persona puede resultar útil una tabla ancha validada. La forma debe responder al cálculo y preservar identidad.

## Volver a ancho necesita una clave

ID/momento debe identificar una sola medición en este ejercicio. Si hay dos filas para la misma combinación, pivot_wider necesita decidir cómo representarlas; puede crear columnas de listas o requerir una agregación explícita. No puedes escoger una media por conveniencia sin justificar por qué esas filas deberían combinarse.

La solución define a_ancho_seguro, que rechaza combinaciones repetidas antes de pivotar. Es una regla añadida por el ejercicio, no una afirmación de que pivot_wider siempre rechace automáticamente cualquier repetición.

## Traza del ejemplo

P1 tiene 50 y 70; P2 tiene 60 y 80. El formato largo contiene P1/antes, P1/despues, P2/antes y P2/despues. Volver a ancho bajo esa clave permite calcular cambio=20 para cada persona. Si la tabla después estuviera reordenada, seguirías necesitando unir por ID; restar dos vectores por posición no demuestra emparejamiento correcto.

## Qué conservar al transformar

Compara cantidad de IDs, combinaciones ID/momento y mediciones, además de las dimensiones. Una transformación reversible para tu caso debe recuperar la información relevante. La coincidencia de cuatro valores impresos no demuestra que pertenezcan a la misma persona o momento que antes.

## Ejemplos completos

Ejecuta uno cada vez desde la raíz del curso. Predice la salida antes de comprobarla. Las condiciones stopifnot comprueban expectativas y detienen el archivo si no se cumplen.

### Ejemplo 1. Pasar mediciones a formato largo

[Archivo R](ejemplos/01.R) · [Salida](ejemplos/01.txt)

```r
# Pasar mediciones a formato largo
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
ancha <- data.frame(id = c("P1", "P2"), antes = c(50, 60), despues = c(70, 80))
larga <- tidyr::pivot_longer(ancha, cols = c(antes, despues), names_to = "momento", values_to = "puntaje")
stopifnot(nrow(larga) == 4, length(unique(larga$id)) == 2)
stopifnot(!anyDuplicated(larga[c("id", "momento")]))
cat("2 personas, 2 momentos: 4 filas; no son 4 personas independientes
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad11-formatos/ejemplos/01.R
```

Salida esperada:

```text
2 personas, 2 momentos: 4 filas; no son 4 personas independientes
```

### Ejemplo 2. Volver a ancho exige una clave

[Archivo R](ejemplos/02.R) · [Salida](ejemplos/02.txt)

```r
# Volver a ancho exige una clave
# Ejecutar desde la raíz del curso, con Rscript --vanilla.
larga <- data.frame(id = c("P1", "P1", "P2", "P2"), momento = rep(c("antes", "despues"), 2), puntaje = c(50, 70, 60, 80))
stopifnot(!anyDuplicated(larga[c("id", "momento")]))
ancha <- tidyr::pivot_wider(larga, names_from = momento, values_from = puntaje)
stopifnot(identical(ancha$despues - ancha$antes, c(20, 20)))
duplicada <- rbind(larga, larga[1, ])
stopifnot(anyDuplicated(duplicada[c("id", "momento")]) > 0)
cat("Diferencia por persona: 20, 20; clave duplicada detectada antes de pivotar
")
```

Desde una terminal del proyecto:

```text
Rscript --vanilla unidad11-formatos/ejemplos/02.R
```

Salida esperada:

```text
Diferencia por persona: 20, 20; clave duplicada detectada antes de pivotar
```

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Anterior](../unidad10-uniones/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-graficos/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2011%20%28Datos%20largos%2C%20anchos%20y%20unidad%20de%20observaci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
