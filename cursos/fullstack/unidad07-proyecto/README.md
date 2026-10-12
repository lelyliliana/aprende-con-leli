# Unidad 07. Proyecto propio y evaluación

[Volver al índice](../README.md)

## Objetivos

- Elegir un problema concreto y convertirlo en criterios verificables.
- Integrar una solución propia sin acumular funciones innecesarias.
- Presentar decisiones, pruebas y límites con evidencia.

## Antes de comenzar

Debes completar el recorrido y comprender el catálogo de referencia. El proyecto final exige transferir lo aprendido a una necesidad propia; cambiar solo el título o los colores no es suficiente.

## 1. Elegir un problema alcanzable

Puedes organizar libros, materiales de un taller, artículos de una tienda o recursos de un equipo. Define una persona usuaria y un flujo principal. Evita empezar con pagos, chat, IA y aplicación móvil si el problema se resuelve con un catálogo bien construido.

Puedes adaptar el catálogo en un repositorio propio o construir una entidad nueva siguiendo los cursos públicos. Si mantienes la API de productos, conserva su contrato: no renombres campos unilateralmente en el cliente.

## 2. Requisitos y aceptación

Completa la [plantilla del proyecto](../docs/PLANTILLA_PROYECTO.md). Redacta al menos un requisito de consulta, uno de escritura, uno de validación y uno de conservación de información.

Ejemplo: “Una persona registra un material con código único”. Criterio válido: entrada correcta devuelve confirmación y el registro puede consultarse. Criterio de rechazo: un código repetido no crea otra fila y conserva la propuesta para corregirla.

## 3. Construir por entregas

| Entrega | Evidencia requerida |
|---|---|
| Problema y contrato | Usuario, alcance, entradas, respuestas y reglas |
| Consulta mínima | Datos reales de tu API; carga, vacío y error |
| Escritura mínima | Confirmación, validación y datos consultables |
| Integración | Edición/eliminación o acciones pertinentes al problema |
| Calidad y entrega | Pruebas, persistencia y guía reproducible |

Termina el flujo mínimo antes de extenderlo. Un proyecto terminado y explicable permite evaluar criterio; una lista de funciones incompletas no lo reemplaza.

## 4. Evidencias mínimas

Demuestra consulta correcta, rechazo de entrada inválida, recuperación tras detener la API y duración de datos al reiniciar el backend. Si hay edición concurrente, demuestra cómo evitas sobrescrituras silenciosas.

Usa datos ficticios. Registra comandos y resultados sin contraseñas ni datos personales. Una captura acompaña la explicación, pero no reemplaza las pruebas de reglas.

## 5. Criterios de autoevaluación

| Criterio | Puntos | Qué se comprueba |
|---|---:|---|
| Problema y contrato | 15 | Alcance concreto, campos/tipos y respuestas coherentes |
| Flujo integrado | 25 | Interfaz opera sobre datos reales de API y base |
| Reglas y errores | 20 | Entradas inválidas, conflictos y fallos reciben tratamiento |
| Persistencia | 15 | Duración demostrada y elección de almacenamiento explicada |
| Pruebas | 15 | Casos válidos, límites y rechazos con alcance identificado |
| Entrega y accesibilidad | 10 | Instrucciones reproducibles, labels, teclado y mensajes claros |
| Total | 100 | Evidencias coherentes con lo afirmado |

No declares terminado el flujo integrado si solo funciona con datos escritos en React, ni persistencia si no hiciste el reinicio. La puntuación ayuda a reconocer faltantes; no acredita por sí sola preparación para producción.

## Ejercicios

1. Escribe tres requisitos con un caso válido y un caso de rechazo cada uno.
2. Selecciona dos decisiones técnicas y explica qué alternativa evaluaste y por qué elegiste tu solución.
3. Pide a otra persona seguir tu README o repítelo en una copia limpia. Registra el punto donde necesitó información adicional y corrígelo.

## Reto

Entrega una demostración de cinco minutos: problema, flujo principal, fallo controlado, recuperación y una decisión técnica. La explicación debe mostrar que comprendes el código y el contrato, no solo que puedes ejecutar comandos.

## Errores frecuentes

- Copiar el catálogo sin adaptar el problema: no demuestra transferencia.
- Cambiar contrato en una sola capa: rompe la integración.
- Prometer despliegue, seguridad o datos reales sin haberlos implementado: declara límites.
- Evaluar solo la apariencia: prueba el recorrido de los datos y los rechazos.

## Comprobación de cierre

Puedes instalar, demostrar y explicar tu proyecto en una copia nueva, y señalar con precisión qué se probó y qué falta. Si un criterio no tiene evidencia, vuelve a su unidad y refuerza ese punto.

## Continuar

- [Unidad anterior: Build, configuración y entrega](../unidad06-entrega/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
