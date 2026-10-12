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

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Pruebas%20y%20evidencia%20de%20comportamiento%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad06-pruebas%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
