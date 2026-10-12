# Arquitectura y contrato

[Volver al laboratorio](../README.md)

## Qué sucede al abrir el catálogo

El navegador solicita `/api/productos` al origen de Vite (127.0.0.1:5173). El proxy reenvía la petición al backend (127.0.0.1:8080). El Controller interpreta parámetros, el Service aplica reglas y el Repository consulta H2 mediante JPA. Spring Boot devuelve JSON; React toma `contenido` y representa las filas.

El proxy es una herramienta de desarrollo. No convierte React en backend y no queda incluido en los archivos estáticos del build.

## Qué hace cada capa

| Capa | Decisión |
|---|---|
| Formulario | Facilita entrada válida y presenta errores |
| Cliente HTTP | Serializa JSON, comprueba response.ok y maneja 204 |
| Controller | Define rutas, métodos y validación de entrada |
| Service | Verifica SKU, categoría y versión de actualización |
| Repository y base | Guardan registros y hacen cumplir restricciones |

La validación del navegador mejora la experiencia. El backend debe volver a validar porque cualquier cliente puede enviar peticiones sin usar tu formulario.

## Contrato utilizado

| Método/ruta | Entrada | Resultado |
|---|---|---|
| GET /api/categorias | Sin cuerpo | Lista de id y nombre |
| GET /api/productos | nombre, pagina, tamano | Objeto paginado |
| GET /api/productos/{id} | ID | Producto o 404 |
| POST /api/productos | sku, nombre, precio, categoriaId | 201, producto y Location |
| PUT /api/productos/{id} | Campos de POST y version | 200, producto con nueva versión |
| DELETE /api/productos/{id} | ID | 204, sin cuerpo |

Ejemplo de creación:

```json
{"sku":"FS-01","nombre":"Cuaderno","precio":25.50,"categoriaId":1}
```

No inventes el ID de la categoría: selecciónalo de GET `/api/categorias`. Los IDs de demostración no deben suponerse en otra base.

Una respuesta paginada no es un arreglo. Sus productos están en `contenido`. La página comienza en cero; la interfaz muestra números desde uno. El servidor acepta tamaño entre 1 y 100 y el cliente pide cinco registros por página.

Los productos devueltos incluyen id, sku, nombre, precio, categoriaId, categoria, version y activo. El frontend de este laboratorio no modifica activo. Los errores de validación pueden incluir `campos`; los conflictos y errores de dominio usan ProblemDetail.

## Evitar sobrescrituras silenciosas

Cuando abres Editar, React conserva ID y versión. Si otro cliente cambia el producto, tu versión deja de ser actual. PUT devuelve 409 y el formulario permanece intacto. Actualiza el catálogo, compara y vuelve a abrir el producto antes de decidir qué guardar. No reemplaces la versión automáticamente y reenvíes: eso ocultaría el conflicto.

## Estados de la interfaz

- Cargando: aún no se conoce el resultado.
- Datos: consulta completada con registros.
- Vacío: consulta correcta sin coincidencias.
- Error: consulta fallida, con opción de reintento.
- Guardando: petición de escritura pendiente y controles bloqueados.

Las consultas anteriores se cancelan al cambiar filtro o página. React no debe aplicar una respuesta antigua encima de una consulta nueva.

[Contrato del backend público](https://github.com/lelyliliana/Curso-Spring-Boot/blob/28abba405067d59f8670c144443727772ee5db17/docs/CONTRATO_ETAPAS.md).
