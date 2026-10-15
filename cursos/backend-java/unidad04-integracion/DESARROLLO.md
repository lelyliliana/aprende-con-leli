# Validar una cotización y observar cada intento del proveedor

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Lee dos contratos, no solo dos códigos HTTP

Tu aplicación sirve /api/cotizaciones/{sku}, pero también es cliente de un proveedor. Un 200 de ese proveedor debe contener el SKU solicitado y precio positivo. Si devuelve otro recurso o JSON incompatible, no tienes una cotización utilizable aunque el transporte haya terminado normalmente.

El [cliente de referencia](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/ejemplos/api-productos/src/main/java/com/lelyliliana/productos/ProveedorClient.java) valida SKU antes de construir la ruta. La URL base se configura por separado. No acepta una URL arbitraria enviada como identificador. La configuración también limita tiempos e intentos.

## 2. Explica la política concreta de esta implementación

| Escenario externo | Respuesta local | Llamadas con app.intentos=2 |
|---|---|---|
| 200, SKU correcto, precio 75 | 200 con cotización | 1 |
| 200, otro SKU | 503 | 1 |
| JSON que no puede interpretarse | 503 | 1 |
| 404 | 404 | 1 |
| 429 | 503 | 1 |
| 503 seguido de 200 válido | 200 | 2 |
| 503 en ambos intentos | 503 | 2 |

Los reintentos cubren 502/503/504 cuando queda un intento. No toda indisponibilidad se reintenta: errores de transporte terminan según el catch de esta referencia. El valor por defecto es un intento. El experimento lo configura explícitamente en dos para hacer visible la política.

## 3. Conserva el significado del dato persistido

El catálogo contiene precio 10. El proveedor responde cotización 75. GET de cotización no escribe ProductoRepository; GET posterior del producto debe seguir devolviendo precio 10 y la misma versión. Mostrar 75 al cliente no equivale a actualizar el catálogo.

Para guardar una cotización haría falta diseñar otro caso de uso: autorización, fecha, procedencia y regla de actualización. No añadas una escritura oculta a GET para que parezca que los dos precios coinciden. El experimento compara el producto completo después de cada escenario externo.

## 4. Mide intentos con un proveedor controlado

El [servidor local de los experimentos](../laboratorio/scripts/recorridos_backend.py) cambia respuestas de manera explícita y cuenta sus llamadas. Eso permite distinguir una respuesta final 200 conseguida al primer intento de otra conseguida después de un 503. No depende de Internet ni de credenciales de terceros.

Conexión, lectura, número de intentos y plazo total son límites diferentes. Esta implementación no añade backoff ni circuit breaker. Repetir un GET de lectura no justifica copiar el mismo bucle a un pago o una creación: podrías repetir efectos si la primera respuesta se perdió.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Servicios%20externos%20y%20fallos%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad04-integracion%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
