# Unidad 05. Errores, concurrencia y pruebas

[Volver al índice](../README.md)

## Objetivos

- Diseñar comprobaciones de comportamiento y de integración.
- Distinguir validación, conflicto y fallo de conexión.
- Explicar qué demuestra una prueba y qué queda fuera.

## Antes de comenzar

Debes completar CRUD. Si necesitas aprender las herramientas, consulta [pruebas de componentes React](https://github.com/lelyliliana/Curso-React/blob/main/unidad24-pruebas/README.md) y [MockMvc](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad19-mockmvc/README.md) en el punto donde te haga falta.

## 1. Una prueba expresa una expectativa

Antes de ejecutarla, escribe qué debería suceder. “La aplicación no se cae” no explica qué protege una prueba. “Cancelar eliminación no envía DELETE” y “una versión antigua recibe 409 sin cambiar el registro” sí definen comportamientos observables.

Usa preparar, actuar y comprobar: prepara los datos o la respuesta controlada, ejecuta una acción y compara el resultado con lo esperado. No pruebas que tu código tenga una variable con cierto nombre; pruebas lo que puede observar un usuario o cliente.

## 2. Pruebas rápidas del cliente

Desde laboratorio ejecuta npm test. Abre [Etapas.test.jsx](../laboratorio/src/etapas/Etapas.test.jsx) y busca la prueba que conserva el formulario ante un SKU duplicado.

La respuesta de la API se controla para provocar el rechazo de forma determinista. La prueba abre la interfaz, llena los campos y pulsa el botón; luego comprueba el mensaje y el texto conservado. No demuestra que Spring Boot imponga la unicidad: esa es una comprobación diferente.

En [api.test.js](../laboratorio/src/api.test.js) se comprueba que DELETE 204 no intente analizar JSON y que un PUT conserve version. Son garantías del cliente HTTP.

## 3. Comprobación con la API real

Con Vite y Spring Boot iniciados, ejecuta npm run verify:integration. Lee [verificar-integracion.mjs](../laboratorio/scripts/verificar-integracion.mjs): realiza solicitudes al puerto de Vite para incluir el proxy, crea un registro único, lo actualiza y lo elimina.

La comprobación no usa los mocks de React. Consulta categorías reales y verifica 400, 409, 204 y 404. El bloque finally intenta limpiar el registro si una comprobación intermedia falla. Úsala con datos ficticios de práctica.

## 4. Concurrencia desde dos pestañas

Sigue [el experimento de versiones](../laboratorio/docs/PRUEBAS.md#paso-4-dos-pestañas-y-un-conflicto). Ambas pestañas leen una versión, la primera modifica y la segunda intenta guardar un estado antiguo.

409 no significa que debas reintentar a ciegas. La segunda persona debe comparar su propuesta con el estado actual. Reemplazar automáticamente la versión y enviar otra vez ocultaría una decisión que pertenece a quien trabaja con los datos.

## 5. Límites de las evidencias

Las pruebas en jsdom comprueban comportamientos de componentes sin representar todos los detalles de un navegador. Las peticiones reales prueban API y persistencia, pero no muestran si el diseño cabe en una pantalla estrecha. Una captura visual no prueba unicidad ni concurrencia.

Combina evidencia según el riesgo: prueba automática para una regla repetible, comprobación HTTP para el contrato, recorrido manual para interacción y presentación. Consulta los [resultados registrados](../laboratorio/docs/VERIFICACION.md) sin convertir casos comprobados en promesas sobre todos los escenarios.

## Ejercicios

1. Explica qué prueba corresponde a conservar el formulario y qué prueba corresponde a rechazar un duplicado en la base.
2. Añade una prueba del cliente que compruebe el texto mostrado para un error de la API. Hazla fallar primero con un cambio intencional y restaura después el comportamiento.
3. Clasifica cinco observaciones propias: fallo de red, error HTTP, validación, conflicto o problema de interfaz.

## Reto

Añade una mejora pequeña y su prueba de comportamiento: por ejemplo, indicar el SKU en la consulta inicial. Define primero la expectativa y comprueba que el test detecta la ausencia del texto.

## Errores frecuentes

- Tomar mocks correctos como prueba de la base real: cada prueba tiene su alcance.
- Comprobar detalles internos en vez de un resultado: dificulta refactorizar sin aportar confianza.
- Probar solo el caso válido: incluye límites y rechazos relevantes.
- Confundir fallo de respuesta con escritura deshecha: consulta antes de repetir.

## Comprobación para avanzar

Puedes justificar una prueba, leer su resultado y distinguir evidencia del cliente, del servidor, de la base y de la revisión visual.

## Continuar

- [Unidad anterior: Escrituras, validación y persistencia](../unidad04-escrituras/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Build, configuración y entrega](../unidad06-entrega/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Errores%2C%20concurrencia%20y%20pruebas%20del%20curso%20Desarrollo%20Full%20Stack%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffullstack%2Funidad05-calidad%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
