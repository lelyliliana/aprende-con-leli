# Verificación del laboratorio Frontend 1.1

[Volver al laboratorio](../README.md)

Comprobación del 14 de octubre de 2026 (Colombia), con Linux, Node.js 24.19.0, React 19.3.0 y Vite 8.3.4. El lockfile fija dependencias. El recorrido en navegador usó Chrome Headless Shell 151.0.7922.34.

| Comprobación | Resultado |
|---|---|
| Reglas, Storage, interfaz, transferencia y recursos | 21 pruebas correctas en cuatro archivos |
| Build multipágina | Nueve páginas y assets generados |
| HTTP en dev | Nueve páginas 200; recursos 200, vacío 200, error 503; POST 405 |
| HTTP del build con preview | Mismos resultados correctos |
| Transferencia JavaScript a React | Guardado compartido y operación posterior comprobados en jsdom y navegador; retorno a JavaScript conserva identidad y estado |
| Texto con marcado | Se presenta como texto, sin generar una imagen |
| JSON inválido o IDs duplicados | Rechazados sin sobrescribir el valor al leer |
| Storage bloqueado o escritura fallida | Error informado |
| Pasos 1 a 5 | HTML estático, CSS, memoria, guardado y componente React recorridos en navegador |
| Claves de práctica | Los pasos 4 y 5 comparten su clave; la aplicación principal conserva la suya |
| Teclado | Alta con Enter y recorrido de foco comprobados |
| Pantallas | CSS a 320 y 1280 px; React a 320, 375 y 1280 px sin desbordamiento horizontal, incluso con un título largo |
| Documento inválido | DOM y React bloquean cambios y conservan el dato; recuperan el uso después de restaurar un documento válido y recargar |
| Escritura fallida en navegador | El cambio queda visible en la sesión y aparece el aviso de que no se guardó |
| Recursos en navegador | Normal, vacío, error, reintento y recuperación comprobados sin perder el plan |
| Respuesta anterior de recursos | Una respuesta tardía no reemplaza el error de una petición posterior (prueba automatizada) |
| React empaquetado en preview | Agregar, guardar y recargar comprobados en navegador |

Las pruebas ejecutan el módulo JavaScript real sobre el documento HTML y después montan React leyendo la misma clave. Además se recorrieron las páginas en un navegador real sin interfaz gráfica y se inspeccionaron capturas de escritorio y móvil. No hubo errores JavaScript no controlados durante ese recorrido. Esta comprobación puntual no equivale a una auditoría completa de accesibilidad ni a cobertura de todos los navegadores.

## Límites

Quedan pendientes la ejecución en Windows/macOS y en dispositivos físicos. No se probó despliegue de una API externa ni sincronización entre dispositivos o pestañas. La API de práctica se sirve mediante Vite en dev y preview; no queda incluida como servicio en dist.

## Repetir

Ejecuta `npm test` y `npm run build` desde `laboratorio`. Con dev iniciado, ejecuta `npm run verify:http`. Para comprobar preview, inicia `npm run preview` y ejecuta en otra terminal `npm run verify:http -- http://127.0.0.1:4174`. También puedes configurar `LAB_ORIGIN` con ese origen.

Para repetir el recorrido visual, abre `pasos/index.html` desde el servidor y sigue las comparaciones de [la guía de construcción](../pasos/README.md). Prueba altas, filtros y recarga en memoria; luego transfiere tareas entre los pasos 4 y 5. En `react.html`, cambia los tres modos de recursos y prueba el reintento.

## Antecedente 1.0

El 11 de octubre de 2026 se verificaron las tres páginas originales y 15 pruebas automatizadas. Esa comprobación no incluyó navegador real. La versión 1.1 amplía el recorrido y conserva esas tres páginas.
