# Unidad 04. Servicios externos y fallos

[Volver al índice](../README.md)

[Desarrollo del caso](DESARROLLO.md) · [Práctica paso a paso](PRACTICA.md)

## Objetivos

- Consumir un proveedor con contrato y límites temporales.
- Traducir fallos externos al contrato propio.
- Evitar pruebas que dependan de Internet.

## Explicación y práctica guiada

A partir de esta unidad usa la [API integrada](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/ejemplos/api-productos/README.md), después de preparar las claves locales según el entorno público. Lee [ProveedorClient](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/ejemplos/api-productos/src/main/java/com/lelyliliana/productos/ProveedorClient.java).

Spring Boot actúa ahora como cliente frente a otra API. La URL base y los tiempos son configuración. El SKU se valida antes de construir el segmento de la petición. La respuesta debe corresponder al SKU solicitado y contener precio válido: recibir 200 no garantiza datos aceptables.

Ejecuta la prueba de proveedor indicada en el [laboratorio público](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad15-apis-externas/LABORATORIO.md). Un servidor HTTP local controla los escenarios. No necesitas encontrar un proveedor público para que tus pruebas sean reproducibles.

Consulta [APIs externas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad15-apis-externas/README.md) y [resiliencia](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad16-resiliencia/README.md) si necesitas ampliar esas decisiones.

El contrato local traduce proveedor 404 a recurso no encontrado y fallos transitorios/datos inválidos a indisponibilidad. No entrega al cliente cuerpos brutos ni detalles internos del proveedor. La consulta de cotización no cambia el precio que ya guardaste en productos.

Por defecto no se reintenta. El ejemplo permite un número limitado de intentos para algunos rechazos transitorios de este GET. No generalices esa política a crear pedidos o cobrar pagos: repetir una escritura puede duplicar efectos.

## Ejercicios

1. Registra qué valida el cliente incluso después de recibir 200.
2. Clasifica proveedor 404, 503 y JSON incompatible; explica qué devolvería tu contrato.
3. Compara una cotización con el precio persistido para demostrar que consultar no lo actualiza.

## Reto

Diseña una prueba con un proveedor local que devuelve otro SKU y verifica que tu aplicación no lo presenta como una cotización correcta.

## Errores frecuentes

Considerar cualquier 200 como éxito de negocio; no limitar espera; reintentar toda operación automáticamente; exponer el error bruto externo.

## Comprobación para avanzar

Puedes explicar límites, traducción de errores y pruebas locales sin dependencia de una API pública.

## Continuar

- [Unidad anterior](../unidad03-persistencia/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad05-seguridad/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Servicios%20externos%20y%20fallos%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad04-integracion%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
