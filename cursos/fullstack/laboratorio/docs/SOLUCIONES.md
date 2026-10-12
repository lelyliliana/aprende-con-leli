# Soluciones razonadas

[Volver a los retos](RETOS.md)

## 1. Recorrido del precio

El input produce una cadena. El formulario la convierte con Number antes de serializar JSON; Spring valida el DTO y el precio se representa como BigDecimal en el backend. El Service construye/actualiza la entidad y JPA la persiste. GET devuelve el precio y React lo formatea para mostrarlo. La validación del servidor sigue funcionando cuando la petición no viene de React. Para operaciones monetarias de producción, define también precisión, redondeo y límites en el contrato.

## 2. Paginación

El valor predeterminado tamano de listarProductos cambia de 5 a 2. El servidor devuelve dos registros como máximo, además de total y paginas. App representa resultado.contenido, que sí es un arreglo. El objeto contenedor conserva la información de navegación. La numeración interna comienza en cero y la interfaz suma uno para mostrarla.

## 3. DELETE sin cuerpo

request retorna null cuando recibe 204. Intentar analizar como JSON un cuerpo vacío genera un error de análisis aunque la eliminación haya sido correcta. El cliente debe distinguir éxito sin datos de un fallo del servidor. La prueba de api.test.js conserva este contrato.

## 4. Conflicto

Cada pestaña obtuvo una versión del registro. La primera actualización la incrementó en el servidor; la segunda envió una versión antigua y recibió 409. La versión expresa concurrencia, no un contador administrado por el formulario. Reintentar automáticamente con una versión nueva podría destruir el cambio de otra persona. Se debe comparar y decidir.

## 5. Estado activo

Puedes mostrar p.activo ? 'Activo' : 'Inactivo' en una celda con encabezado Estado. Incluye texto y no dependas solo del color. El DTO de escritura actual no acepta activo: no basta añadir un checkbox al frontend. Para permitirlo necesitas acordar DTO, reglas, autorizaciones y pruebas en el backend.

## 6. Persistencia

El comando Java de PERSISTENCIA.md cambia la URL de H2 a un archivo. Flyway aplica cada migración una vez sobre esa base. Reiniciar desde la misma carpeta vuelve a abrir el mismo archivo; ejecutar desde otra carpeta crea/abre una ruta diferente. Un producto ausente puede indicar otra base, no una pérdida del registro original.
