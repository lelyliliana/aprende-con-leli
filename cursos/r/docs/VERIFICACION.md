# Verificación y alcance

[Curso](../README.md) · [Proyecto](../proyecto/README.md)

La revisión utiliza datos ficticios y ejecución desde una sesión limpia. El verificador no modifica las salidas esperadas para obtener un resultado correcto.

## Qué ejecuta

- Los 54 ejemplos y las cuatro etapas ejecutables del proyecto en procesos Rscript separados, comparando sus salidas de texto.
- Las 18 soluciones completas, sus condiciones de comprobación y la correspondencia de su salida con el texto publicado.
- Grupos de contratos sobre importación, dominio, identidad, faltantes, limpieza, uniones, pivotes, cálculos y entrega.
- Enlaces locales, bloques de código y marcas de codificación en los documentos.
- Con --quarto, el renderizado real del informe HTML.

La comparación de texto normaliza finales de línea y espacios finales. Los cálculos de punto flotante se comprueban con tolerancias donde corresponde. Las figuras se verifican por generación y propiedades relevantes; la inspección visual complementa los controles.

## Resultado observado el 15 de octubre de 2026

| Comprobación local | Resultado |
|---|---|
| Ejemplos | 54 correctos en procesos nuevos |
| Construcción del proyecto | 4 etapas correctas en procesos nuevos |
| Soluciones | 18 correctas |
| Contratos | 12 grupos, 36 comprobaciones correctas |
| Navegación documental | 522 enlaces locales correctos |
| Correspondencia de código | 76 bloques R publicados coinciden con sus archivos ejecutables |
| Revisión didáctica | 19 clases, 57 pasos de práctica y 19 retos con sus respuestas; 18 laboratorios guiados y construcción progresiva del proyecto |
| Quarto | Informe HTML renderizado con R 4.3.3 y Quarto 1.10.19 |
| Navegador | Chromium 151; 91 comprobaciones correctas, sin errores JavaScript ni recursos fallidos |

La página se revisó a 320, 375, 768 y 1280 px en claro y oscuro, con 57 enlaces distintos de unidades y tema persistente. El catálogo incluye R en Datos e IA y lo encuentra al buscar Quarto. El informe de muestra se comprobó en móvil y escritorio con sus números calculados, tabla, figura y texto alternativo.

La ampliación desarrolla explicación del código, trazas cuando aportan claridad, experimentos, errores frecuentes y autoevaluación. Cada práctica mantiene tres pasos y añade un reto de transferencia. Sus soluciones responden tanto tareas de código como interpretación; el renderizado y la inspección de figuras/HTML se distinguen de las comprobaciones de los scripts.

## Repetir paso a paso

Prepara paquetes con la guía de entorno. Desde cursos/r:

```text
Rscript --vanilla scripts/verificar.R
```

Revisa salidas/verificacion/resultado.json y los archivos stdout/stderr si algo falla. Después, con Quarto instalado:

```text
Rscript --vanilla scripts/verificar.R --quarto
```

El informe resultante queda en salidas/informe/proyecto/informe.html.

## Entorno y límites

Se registra el entorno comprobado en [entorno-comprobado.json](entorno-comprobado.json). Ese archivo documenta versiones observadas, no fija todas las instalaciones futuras. El instalador declara mínimos y puede obtener versiones posteriores de CRAN.

Las condiciones y datos de ejemplo aportan evidencia sobre lo ejecutado. No demuestran ausencia de errores para toda entrada, validez de cualquier diseño estadístico ni compatibilidad de todos los paquetes futuros. Los ejemplos de inferencia son construidos y el proyecto es descriptivo.

La automatización del repositorio permite comprobar el curso en Windows, macOS y Ubuntu con R y Quarto. Consulta el resultado de cada ejecución antes de declarar una plataforma comprobada.
