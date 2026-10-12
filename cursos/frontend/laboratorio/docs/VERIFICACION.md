# Verificación del laboratorio Frontend 1.0

[Volver al laboratorio](../README.md)

Comprobación del 11 de octubre de 2026 (Colombia), con Linux, Node.js 24.19.0, React 19.3.0 y Vite 8.3.4. El lockfile fija dependencias.

| Comprobación | Resultado |
|---|---|
| Reglas, Storage, interfaz, transferencia y recursos | 15 pruebas correctas |
| Build multipágina | Tres páginas y assets generados |
| HTTP en dev | Tres páginas 200; recursos 200, vacío 200, error 503; POST 405 |
| HTTP del build con preview | Mismos resultados correctos |
| Transferencia JavaScript a React | Guardado compartido y operación posterior comprobados en jsdom |
| Texto con marcado | Se presenta como texto, sin generar una imagen |
| JSON inválido o IDs duplicados | Rechazados sin sobrescribir el valor al leer |
| Storage bloqueado o escritura fallida | Error informado |

Las pruebas ejecutan el módulo JavaScript real sobre el documento HTML y después montan React leyendo la misma clave. No son una revisión visual en un navegador real.

## Límites

Quedan pendientes la inspección visual y ejecución en Windows/macOS. No se probó despliegue de una API externa ni sincronización entre dispositivos o pestañas. La API de práctica se sirve mediante Vite en dev y preview; no queda incluida como servicio en dist.

## Repetir

Ejecuta npm test y npm run build desde laboratorio. Con dev iniciado, ejecuta npm run verify:http. Para repetir esa comprobación sobre preview, configura LAB_ORIGIN con http://127.0.0.1:4174 en tu terminal o realiza el recorrido manual de sus tres páginas y modos.
