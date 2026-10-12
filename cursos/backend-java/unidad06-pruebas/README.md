# Unidad 06. Pruebas y evidencia de comportamiento

[Volver al índice](../README.md)

## Objetivos

- Elegir pruebas según la frontera y el riesgo.
- Verificar contratos completos sobre JAR ejecutado.
- Distinguir mocks, base real de prueba y operación.

## Explicación y práctica guiada

Una prueba describe comportamiento, no solo que el programa compile. Antes de ejecutarla escribe el resultado esperado y qué fallo detectaría. Usa preparar, actuar y comprobar para separar escenario, acción y evidencia.

Cada uno de los cuatro proyectos públicos se comprueba con mvn verify. Consulta [pruebas de servicios](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad18-pruebas-unitarias/README.md), [MockMvc](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad19-mockmvc/README.md), [JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad20-pruebas-jpa/README.md) e [integración](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad21-integracion-tests/README.md) cuando necesites comprender una frontera.

Un mock permite controlar una dependencia; no demuestra por sí solo una restricción en la base. Un test de Repository puede probar UNIQUE/FK sobre el motor utilizado. MockMvc prueba el comportamiento web con su configuración; un JAR real añade evidencia de arranque, puerto y cliente HTTP.

Ejecuta el [verificador público](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/VERIFICACION.md) siguiendo el recorrido. Compila los proyectos, lee informes y arranca los JAR con claves ficticias generadas para las pruebas. No requiere tus credenciales reales.

La comprobación estándar usa H2. PostgreSQL y Docker son variantes adicionales con sus requisitos; no declares comprobados esos escenarios si solo ejecutaste la opción estándar. Un resultado verde cubre lo diseñado, no todos los casos futuros.

Los pedidos de referencia permiten examinar estado, precio histórico y versiones. Lee [pedidos](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/PEDIDOS.md) antes de interpretar su total: un borrador y un pedido confirmado no representan el mismo momento del precio.

## Ejercicios

1. Relaciona una regla de Service, una restricción UNIQUE y un estado HTTP con la prueba que corresponde.
2. Ejecuta la comprobación y registra número de pruebas, resultado y motores realmente usados.
3. Provoca un conflicto de versión y verifica el dato final, además del estado 409.

## Reto

Añade en tu copia una regla propia y una prueba que falle antes de implementarla. No uses nombres internos de variables como única expectativa.

## Errores frecuentes

Tomar un mock por evidencia de base real; probar solo casos válidos; saltar pruebas con -DskipTests para declarar un cambio verificado.

## Comprobación para avanzar

Puedes explicar qué evidencia aporta cada prueba y repetir la comprobación del contrato real.

## Continuar

- [Unidad anterior](../unidad05-seguridad/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad07-operacion/README.md)
