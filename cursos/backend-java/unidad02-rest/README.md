# Unidad 02. Contratos REST, validación y capas

[Volver al índice](../README.md)

[Desarrollo del caso](DESARROLLO.md) · [Práctica paso a paso](PRACTICA.md)

## Objetivos

- Definir entrada, respuesta, estados y reglas de un recurso.
- Construir CRUD con DTO, validación y capas.
- Distinguir limitaciones de un catálogo en memoria.

## Explicación y práctica guiada

Usa [REST en memoria](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/laboratorios/rest-memoria/README.md). El catálogo comienza vacío. POST recibe sku, nombre y precio; todavía no recibe categoría ni versión. Lee el [contrato de etapas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/CONTRATO_ETAPAS.md) antes de copiar una petición de otro proyecto.

Crea un producto y observa 201, Location y JSON. Utiliza el ID devuelto para consultarlo: no asumas que siempre será uno. Repite el SKU y anticipa 409. Envía un precio con más de dos decimales y explica el 400.

Localiza Controller, DTO, Service y ApiErrorHandler. El Controller interpreta HTTP; el DTO define el contrato; el Service comprueba reglas del catálogo; el manejador representa errores. Para estudiar conceptos nuevos, consulta [DTO](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad07-dto/README.md), [validación](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad08-validacion/README.md) y [capas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/unidad10-capas/README.md).

Una respuesta paginada incluye contenido y metadatos. GET no debe mutar productos al consultarlos. PUT y DELETE deben definir resultado para recursos inexistentes. DELETE correcto devuelve 204, sin cuerpo JSON que el cliente necesite analizar.

El mapa mantiene coherencia dentro de este proceso. Su monitor no vuelve compartidos los datos entre dos aplicaciones distintas ni conserva información después de detener Java. Esa limitación será una razón para introducir persistencia, no una excusa para afirmar que un mapa es una base duradera.

## Ejercicios

1. Registra un ciclo crear, consultar, actualizar y eliminar con estados y cuerpos reales.
2. Compara rechazo por duplicado con rechazo por formato de precio.
3. Reinicia el proyecto y explica por qué el catálogo vuelve a estar vacío.

## Reto

Diseña el contrato de un catálogo de materiales con un caso válido, un límite y un rechazo antes de crear otra entidad.

## Errores frecuentes

Copiar categoriaId en esta etapa; leer 204 como JSON; confundir validación de formato con unicidad; afirmar persistencia por una consulta posterior sin reinicio.

## Comprobación para avanzar

Puedes repetir CRUD y explicar cada rechazo y la duración de datos de esta etapa.

## Continuar

- [Unidad anterior](../unidad01-fundamentos/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad03-persistencia/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Contratos%20REST%2C%20validaci%C3%B3n%20y%20capas%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad02-rest%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
