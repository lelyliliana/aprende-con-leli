# Proyecto: encuesta explicada y reproducible

[Curso](../README.md) · [Unidad final](../unidad18-proyecto/README.md) · [Informe de muestra](../muestra/informe.html)

## Paso 1. Definir pregunta y unidad

Describe la distribución de puntajes por grupo en encuesta.csv. Una fila es un participante ficticio y el ID es único. Conserva el [diccionario](../datos/README.md). El objetivo es descriptivo; el archivo no contiene un diseño real para inferir causalidad o generalizar a una población.

## Paso 2. Validar antes de calcular

Lee [analizar.R](analizar.R) y las funciones de src/curso.R. Una entrada fuera del dominio se rechaza antes de generar resultados. Prueba un puntaje negativo en un archivo temporal; no cambies el original para hacerlo pasar.

## Paso 3. Producir la entrega mínima

Desde la raíz del curso:

```text
Rscript --vanilla proyecto/analizar.R
```

Revisa salidas/proyecto: resumen.csv, puntajes.svg, registro.json y sesion.txt. La carpeta puede reemplazar sus resultados de práctica en otra ejecución; no la uses para archivos personales que deban conservarse.

## Paso 4. Renderizar el informe

Con Quarto preparado:

```text
quarto render proyecto/informe.qmd
```

Abre salidas/informe/proyecto/informe.html. Debe comunicar pregunta, calidad, denominadores, distribución y límites. El archivo de muestra es una ejecución publicada para comparar; tu entrega debe volver a generarse desde sus fuentes.

## Paso 5. Explicar y transferir

Usa los cinco criterios de la Unidad 18 (20 puntos cada uno). Para trasladar el flujo a ambiental.csv, redefine unidad y diccionario antes de resumir. Distingue total observado, faltantes y esfuerzo de observación. No atribuyas a un archivo pequeño la información de un estudio que no se realizó.

Guardar archivos usa escritura directa. El proyecto no implementa transacciones, bloqueo concurrente ni recuperación ante corte de escritura. El rechazo previo a calcular es una garantía distinta.
