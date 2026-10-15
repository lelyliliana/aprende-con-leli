# Bitácora de decisiones y evidencia

[Curso](../README.md) · [Experimentos](EXPERIMENTOS.md) · [Proyecto propio](PLANTILLA_PROYECTO.md)

Completa una fila antes de ejecutar y otra después de observar. Usa datos ficticios. Registra revisión de tu proyecto y de las fuentes reutilizadas, herramientas, proyecto/JAR y motor con su modo de almacenamiento.

| Campo | Ejemplo de expectativa (no resultado observado) |
|---|---|
| Pregunta | ¿Una versión antigua puede sobrescribir el precio vigente? |
| Preparación | Crear a 10, actualizar válidamente a 15, conservar versión inicial |
| Acción | PUT con precio 99 y versión inicial |
| Respuesta esperada | 409 |
| Dato posterior esperado | GET conserva precio 15 y la versión aceptada |
| Qué refutaría la conclusión | Precio 99 o versión cambiada después del rechazo |
| Límite de la evidencia | No prueba todas las carreras simultáneas ni otros motores |

Después anota respuesta real, comando exacto, hora, dato posterior y explicación. Si diverge, conserva ambos valores y plantea una siguiente observación; no reemplaces la predicción para que coincida con el resultado.

## Registro de decisión

Escribe necesidad, alternativas consideradas, elección, razón y límite. Ejemplo: elegir H2 en archivo permite practicar duración entre procesos sin instalar otro motor; esa elección no demuestra compatibilidad con PostgreSQL ni automatiza copias.

## Cierre de una unidad

Incluye un caso válido, un rechazo, dato posterior y una decisión justificada. Un log o una captura es útil si identifica el escenario y la revisión. Separa mediciones reales de ejemplos calculados y diseños todavía no ejecutados.
