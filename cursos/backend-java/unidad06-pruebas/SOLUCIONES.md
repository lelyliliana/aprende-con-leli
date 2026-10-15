# Soluciones desarrolladas de la Unidad 06

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Fronteras complementarias

Una prueba unitaria puede demostrar que un servicio no intenta guardar después de un rechazo. No ejecuta UNIQUE ni una FK. Una prueba de repositorio con flush observa restricciones del motor usado. Una prueba web observa status, headers y JSON; si sustituye el servicio, no demuestra persistencia real. El JAR añade empaquetado, arranque y HTTP/TCP.

## 2. Recuento y alcance

La ejecución aplicada registra 15 casos, 45 peticiones explícitas y 80 comprobaciones. Las 77 pruebas Maven pertenecen a la revisión de Spring Boot utilizada. No se suman como si fueran la misma clase de prueba. Los GET automáticos para esperar el servidor y obtener CSRF se excluyen de las 45 peticiones explícitas.

## 3. Dato conservado y precio histórico

Tras versión vieja, GET debe devolver precio 15 y versión 1, no precio 99. Tras cotizar a 75, el producto sigue en 10. En pedidos, dos unidades confirmadas después de subir catálogo a 15 totalizan 30; una subida posterior a 99 no cambia el historial. Cancelar conserva ese total si ya estaba confirmado.

## Resolución del reto

La regla propia de máximo 500 requiere casos 500 permitido y 500.01 rechazado. Al principio el segundo puede mostrar que la regla falta. Diseña validación HTTP y dominio según los caminos desde los que puedas crear el dato; actualiza contrato y tests de creación/actualización. No declares la regla implementada solo porque escribiste el test o anotaste un DTO.

Una prueba útil fallaría si quitaras la condición relevante y expresaría un resultado observable. Repetir la estructura de métodos internos sin comprobar consecuencias puede conservar un test verde ante un comportamiento incorrecto.
