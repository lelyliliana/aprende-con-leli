# Soluciones desarrolladas de la Unidad 07

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Salud y operación

Health público informa un resumen sin components. Métricas se protege porque expone información operativa. Lector recibe 403 aunque la aplicación funcione; editor recibe 200 por OPS_READ. El permiso y la disponibilidad son preguntas diferentes.

## 2. Correlación comprobable

guia-123 válido debe volver en X-Request-Id y aparecer en el log de esa petición. Un valor de 80 caracteres se reemplaza por UUID. El filtro limpia MDC en finally. Esta evidencia cubre correlación del proceso, no identidad ni tracing distribuido completo.

## 3. Cálculo resuelto

Para 10, 20, 30, 40 y 900 ms, suma 1000 y divide entre 5: media 200 ms. Mediana es el tercer valor: 30 ms. Rango más cercano para p95: techo de 0.95 × 5 = 5; resultado 900 ms. Son números inventados para aprender la diferencia. Cinco observaciones no justifican una afirmación estable sobre el p95 de producción.

## Resolución del reto

Una hipótesis posible: «Con población fija y la misma concurrencia, cambiar solo fetch reduce consultas manteniendo respuesta, errores y orden». Registra antes/después con condiciones idénticas. Si comparas catálogo con proveedor, separa estados HTTP y reconoce trabajo diferente en cada ruta.

La duración específica del proveedor necesita un instrumento en esa frontera; no se supone que exista automáticamente. Mantén etiquetas acotadas y no uses cada SKU como dimensión. No se ejecutó un benchmark en la verificación de esta ruta; los experimentos disponibles comprueban comportamiento funcional e intentos.
