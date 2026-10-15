# Soluciones desarrolladas de la Unidad 04

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Éxito de transporte y éxito del contrato

El cuerpo debe poder interpretarse como Cotizacion, tener SKU igual al solicitado y precio positivo. El experimento de otro SKU mantiene precio 75 válido para aislar la causa: debe devolver 503 aunque el proveedor haya respondido 200.

## 2. Tabla resuelta de fallos e intentos

404 externo produce 404 local y una llamada. 429 produce 503 local y una llamada. JSON roto u otro SKU producen 503 y una llamada. Un 503 seguido de 200 válido termina en 200 con dos llamadas; un 503 permanente termina en 503 con dos llamadas. Los errores locales exponen code y omiten trace.

La política no es «reintentar cualquier error». El código solo repite respuestas 502/503/504 cuando queda otro intento. Los fallos de transporte siguen otro catch. Con la configuración normal de un intento no habría una segunda llamada.

## 3. Precio persistido y cotización

El producto se crea a 10. La cotización válida devuelve 75. La consulta posterior del producto conserva precio 10 y versión inicial. El experimento compara todo el recurso después de cada escenario: también un rechazo externo debe dejar intacto el catálogo.

## Resolución del reto

El proveedor de prueba devuelve un SKU distinto con precio positivo. La expectativa es 503/PROVIDER_UNAVAILABLE y una llamada. La prueba fallaría si el cliente dejara de comparar el SKU. Aceptar cualquier cuerpo 200 ocultaría el fallo de correspondencia.

Para guardar una cotización sería necesario un comando autorizado con regla de procedencia/fecha y una actualización versionada. El GET actual no implementa ese cambio. Tampoco el resultado del experimento permite afirmar un plazo total de producción ni idempotencia de una operación de pago.
