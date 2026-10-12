# Unidad 03. Persistencia y concurrencia

[Volver al índice](../README.md)

## Objetivos

- Relacionar entidades, repositorios, restricciones y migraciones.
- Explicar qué cambia en el contrato al añadir JPA.
- Defender actualizaciones frente a versiones antiguas.

## Explicación y práctica guiada

Detén REST e inicia [JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/laboratorios/jpa-productos/README.md). Esta etapa devuelve cuatro productos y tres categorías ficticias en dev. POST añade categoriaId y PUT añade version. Consulta las categorías de tu ejecución: los IDs de ejemplo no son universales.

El Repository consulta un motor real. El Service comprueba categoría, SKU y versión; la base mantiene UNIQUE y FK. Validar en Java mejora el mensaje, pero una comprobación previa no elimina por sí sola una carrera entre escrituras. La restricción de la base mantiene la garantía donde convergen las operaciones.

Lee la entidad y las migraciones V1/V2. La versión es administrada por el servidor. Actualiza un producto con su versión vigente, observa la nueva y reenvía la anterior: debe recibirse 409 sin sobrescribir el dato.

Consulta [JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad11-jpa/README.md), [relaciones](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad12-relaciones/README.md) y [base/migraciones](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad14-base-datos/README.md) cuando necesites comprender esos elementos.

El perfil dev usa H2 en memoria: conserva datos entre peticiones, no entre reinicios. Para practicar duración sin instalar PostgreSQL, puedes usar [H2 en archivo](../../fullstack/laboratorio/docs/PERSISTENCIA.md), con el mismo proyecto JPA. Para PostgreSQL sigue [operación](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/OPERACION.md) en una base local de práctica.

H2 no demuestra automáticamente compatibilidad con todo PostgreSQL. Indica el motor realmente utilizado en tus evidencias y verifica migraciones/consultas en el destino si vas a utilizarlo.

## Ejercicios

1. Crea un producto con una categoría recibida de la API y explica la relación.
2. Actualiza con versión vigente y vuelve a enviar la antigua. Consulta después para verificar qué dato quedó.
3. Compara recargar un cliente, reiniciar H2 en memoria y reiniciar H2 en archivo.

## Reto

Define cómo comprobarías dos creaciones concurrentes del mismo SKU, indicando estados esperados y restricción que protege la unicidad.

## Errores frecuentes

Incrementar version manualmente; desactivar validación de esquema para ocultar una migración fallida; atribuir a PostgreSQL una prueba hecha solo con H2.

## Comprobación para avanzar

Puedes demostrar persistencia en el modo elegido y explicar el rechazo de una versión antigua.

## Continuar

- [Unidad anterior](../unidad02-rest/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad04-integracion/README.md)
