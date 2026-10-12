# Unidad 04. Escrituras, validación y persistencia

[Volver al índice](../README.md)

## Objetivos

- Construir una escritura válida a partir de un formulario.
- Reconsultar después de guardar y conservar entradas rechazadas.
- Explicar actualizaciones, eliminación y duración del almacenamiento.

## Antes de comenzar

La consulta de la Unidad 03 debe funcionar. Para repasar estado y formularios, usa [formularios React](https://github.com/lelyliliana/Curso-React/blob/main/unidad10-formularios/README.md). Para entender las reglas del servidor, consulta [capas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad10-capas/README.md) y [JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad11-jpa/README.md) cuando la explicación lo requiera.

## 1. Ejecutar creación antes del CRUD completo

Abre `http://127.0.0.1:5173/?etapa=2`. Crea un producto con SKU `ETAPA-01`, nombre `Libro de práctica`, precio `25.50` y una categoría del select. Observa POST, su estado 201 y la consulta que se realiza después.

Esta etapa mantiene separadas creación y lectura. Abre [Creacion.jsx](../laboratorio/src/etapas/Creacion.jsx): el formulario conserva cadenas mientras escribes; guardar construye los tipos del contrato y espera crearProducto.

## 2. El servidor confirma el cambio

Solo una respuesta correcta permite anunciar creación y limpiar el formulario. Después, incrementar revision provoca que Consulta vuelva a pedir los datos. No se necesita recargar toda la página ni insertar un producto que aún no confirmó el backend.

Si tienes más de cinco productos, el nuevo puede quedar fuera de la primera página. La consulta de etapa 2 muestra total; usa la etapa 3 para buscarlo. Una confirmación de creación no promete que el producto esté en la página que estás mirando.

## 3. Validación en dos lugares

El navegador evita errores comunes con required, min, step y pattern. Spring Boot valida el DTO y el Service verifica reglas como SKU único y categoría existente. La base también impone restricciones.

Una petición puede venir de otro programa. Validar solo en React dejaría el servidor sin protección. En [pruebas del laboratorio](../laboratorio/docs/PRUEBAS.md#paso-3-validación-del-servidor) puedes enviar una petición inválida y observar el rechazo.

## 4. Ampliar a edición y eliminación

Abre `http://127.0.0.1:5173/?etapa=3` y sigue las acciones del [recorrido CRUD](../laboratorio/README.md#paso-4-completar-el-recorrido-crud).

Al editar se conserva el ID y la versión recibidos. PUT envía el nuevo estado y la versión que conocías; el servidor comprueba si sigue siendo actual. DELETE puede terminar con 204: una eliminación correcta no requiere un cuerpo JSON.

El diálogo de eliminación pide decidir antes de una acción que no se revierte desde el catálogo. Cancelar no envía DELETE. Tras eliminar la última fila de una página, la navegación retrocede si esa página dejó de existir.

## 5. De JPA a la duración de los datos

En el backend público, Controller recibe, Service decide y Repository opera sobre entidades JPA. H2 es el motor de esta práctica. Su modo de memoria pierde los cambios al terminar Java; el modo de archivo los conserva.

Completa [persistencia entre reinicios](../laboratorio/docs/PERSISTENCIA.md). La recarga del navegador y el reinicio del servidor son experimentos distintos. Flyway registra migraciones aplicadas para no insertar repetidamente los datos iniciales.

## Ejercicios

1. Explica por qué precio y categoriaId se convierten con Number y por qué version no se calcula a partir del texto visible del formulario.
2. Crea un SKU duplicado. Registra estado y mensaje; comprueba qué datos conserva el formulario.
3. Ejecuta el modo H2 en archivo y conserva un producto tras reiniciar Java. Registra la carpeta desde donde ejecutaste el comando.

## Reto

Implementa en tu copia un indicador textual del estado activo que devuelve GET. Diseña después qué cambios de contrato harían falta para editarlo; no asumas que añadir un checkbox obliga al servidor a aceptar el nuevo campo.

## Errores frecuentes

- Mostrar “guardado” antes de recibir confirmación: se puede anunciar un cambio que nunca ocurrió.
- Repetir automáticamente POST si no llegó una respuesta: el servidor pudo haber creado el recurso.
- Tratar version como un contador del cliente: la administra el servidor.
- Ejecutar H2 en archivo desde carpetas diferentes: puedes abrir bases distintas.

## Comprobación para avanzar

Puedes describir el viaje de una escritura, demostrar un rechazo sin perder lo escrito y distinguir persistencia de memoria y archivo.

## Continuar

- [Unidad anterior: React conectado a una API](../unidad03-consulta/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Errores, concurrencia y pruebas](../unidad05-calidad/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Escrituras%2C%20validaci%C3%B3n%20y%20persistencia%20del%20curso%20Desarrollo%20Full%20Stack%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffullstack%2Funidad04-escrituras%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
