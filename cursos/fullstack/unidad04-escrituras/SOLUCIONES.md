# Soluciones de la Unidad 04

[Volver a la unidad](README.md)

Intenta los ejercicios antes de leer. Las respuestas explican criterios y admiten otras implementaciones coherentes.

1. value de los controles llega como cadena. Number construye precio y categoriaId con el tipo esperado. version se conserva de la respuesta y la valida el servidor; la interfaz no la inventa.

2. Un SKU existente provoca 409. La etapa 2 mantiene el formulario para cambiar el código. La etapa 3 distingue el contexto de edición y explica que un conflicto también puede deberse a versión antigua.

3. El archivo H2 se ubica según el directorio de ejecución. Reiniciar desde la misma carpeta conserva el registro. Flyway evita repetir las migraciones aplicadas.

**Reto:** muestra `p.activo ? 'Activo' : 'Inactivo'` con texto accesible. Para editarlo, define DTO/reglas y pruebas del servidor: el contrato de escritura actual no acepta ese cambio.
