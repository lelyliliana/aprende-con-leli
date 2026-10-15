# Verificación y alcance

[Curso](../README.md) · [Proyecto](../proyecto/README.md)

La primera revisión utiliza datos ficticios y ejecución desde una sesión limpia. El verificador no modifica las salidas esperadas para obtener un resultado correcto.

## Qué ejecuta

- Los 36 ejemplos en procesos Rscript separados, comparando sus salidas de texto.
- Las 18 soluciones ejecutables y sus condiciones de comprobación.
- Grupos de contratos sobre importación, dominio, identidad, faltantes, limpieza, uniones, pivotes, cálculos y entrega.
- Enlaces locales, bloques de código y marcas de codificación en los documentos.
- Con --quarto, el renderizado real del informe HTML.

La comparación de texto normaliza finales de línea y espacios finales. Los cálculos de punto flotante se comprueban con tolerancias donde corresponde. Las figuras se verifican por generación y propiedades relevantes; la inspección visual complementa los controles.

## Resultado observado el 15 de octubre de 2026

| Comprobación local | Resultado |
|---|---|
| Ejemplos | 36 correctos en procesos nuevos |
| Soluciones | 18 correctas |
| Contratos | 12 grupos, 36 comprobaciones correctas |
| Navegación documental | 461 enlaces locales correctos |
| Revisión de contenido | 699 comprobaciones editoriales y de correspondencia con fuentes; sin incidencias |
| Quarto | Informe HTML renderizado con R 4.3.3 y Quarto 1.10.19 |
| Navegador | Chromium 151; 91 comprobaciones correctas, sin errores JavaScript ni recursos fallidos |

La página se revisó a 320, 375, 768 y 1280 px en claro y oscuro, con 57 enlaces distintos de unidades y tema persistente. El catálogo incluye R en Datos e IA y lo encuentra al buscar Quarto. El informe de muestra se comprobó en móvil y escritorio con sus números calculados, tabla, figura y texto alternativo.

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
