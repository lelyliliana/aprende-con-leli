# Unidad 08. Entrega y proyecto propio

[Volver al índice](../README.md)

## Objetivos

- Generar y verificar artefactos con configuración externa.
- Entregar un proyecto propio con criterios de aceptación.
- Justificar alcance, persistencia y operación.

## Explicación y práctica guiada

El JAR empaquetado no contiene por ello las credenciales de ejecución. Mantén configuración externa y sigue [producción](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad27-produccion/README.md) y [operación](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/OPERACION.md) antes de trasladar el proyecto a otro entorno.

Para el proyecto propio, elige una necesidad pequeña: catálogo de materiales, libros o recursos de un equipo. Define una persona usuaria, entradas, respuestas, validaciones, permisos y duración de datos. Adapta en una copia propia sin cambiar el contrato de una sola capa.

Entrega por tramos: contrato y primer recurso; escrituras y rechazos; persistencia/versiones; pruebas; configuración y diagnóstico. Puedes usar pedidos como ampliación después de comprender el catálogo, pero no agregues pagos o inventario físico sin diseñar sus reglas.

Completa la [plantilla](../docs/PLANTILLA_PROYECTO.md). Una persona debe poder instalar y ejecutar tu entrega desde una copia nueva, con datos ficticios y resultados esperados. Distingue el motor usado, el modo de seguridad y las características pendientes.

Autoevalúa: problema/contrato (15), flujo y capas (20), reglas/errores (20), persistencia/concurrencia (15), pruebas/evidencia (15), seguridad/configuración/entrega (15). Los criterios suman 100; un criterio sin evidencia indica qué falta completar.

No necesitas desplegar un proveedor de pago para terminar la ruta local. Un despliegue real requiere revisar usuarios, permisos, TLS, secretos, base, migraciones, copias y monitoreo en el entorno elegido. Las cuentas educativas no se convierten en identidad de producción por publicar el JAR.

## Ejercicios

1. Escribe tres requisitos con caso válido, límite y rechazo.
2. Reproduce instalación y arranque en una copia nueva y corrige una instrucción ambigua.
3. Explica dos decisiones técnicas y una limitación que no se haya comprobado.

## Reto

Demuestra en cinco minutos un flujo, una entrada rechazada, una actualización concurrente y un diagnóstico, explicando qué evidencia respalda cada resultado.

## Errores frecuentes

Entregar solo captura o JAR; guardar claves en repositorio; prometer seguridad/carga/despliegue no comprobados; acumular funciones sin terminar el flujo mínimo.

## Comprobación para avanzar

Puedes instalar, demostrar y explicar un backend propio y señalar con precisión sus límites.

## Continuar

- [Unidad anterior](../unidad07-operacion/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
