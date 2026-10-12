# Unidad 01. Comunicación HTTP y contrato

[Volver al índice](../README.md)

## Objetivos

- Leer método, ruta, estado, cabeceras y cuerpo de una petición.
- Distinguir datos JSON de instrucciones y de persistencia.
- Definir un contrato antes de conectar clientes.

## Antes de comenzar

Necesitas distinguir cliente y servidor. Si no lo tienes claro, vuelve a la Unidad 00. Esta unidad usa una práctica breve en Node.js para observar HTTP; el backend del catálogo será Spring Boot.

## 1. El contrato evita adivinar

Cuando una persona pulsa Buscar, el cliente debe saber la ruta, el método y la forma de la respuesta. “La API devuelve productos” es insuficiente: puede devolver un arreglo o un objeto paginado. La interfaz debe interpretar el contrato real.

Una petición no equivale a guardar un dato. GET consulta; POST solicita crear. El resultado depende del servidor, sus reglas y el estado actual de la base. Un 200 no demuestra que una escritura se haya persistido entre reinicios.

## 2. Laboratorio: observar HTTP

Sigue los cuatro pasos de la [práctica propia de fundamentos web](../material/fundamentos-web.md): crea el archivo, inicia el servidor y observa la pestaña Red del navegador. Predice primero qué sucederá en `/api/productos` y en `/otra-ruta`.

Debes comprobar GET 200 con JSON y 404 en la ruta desconocida. Esa práctica implementa únicamente GET. Los demás métodos no se habilitan por cambiar el texto del navegador: el servidor debe implementarlos.

Detén Node antes de seguir con otro ejercicio. El catálogo JPA y este ejemplo son aplicaciones distintas, con puertos y contratos diferentes.

## 3. Leer el catálogo que utilizaremos

Consulta el [contrato del laboratorio público JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/28abba405067d59f8670c144443727772ee5db17/docs/CONTRATO_ETAPAS.md). Esta etapa recibe categoriaId al crear y version al actualizar. La etapa REST en memoria del mismo documento tiene otro contrato; no mezcles sus cuerpos JSON.

Una consulta del catálogo devuelve, por ejemplo, un objeto con `contenido`, `pagina`, `tamano`, `total` y `paginas`. El arreglo está dentro de contenido. Un cliente que aplique map directamente al objeto contenedor fallará incluso si la respuesta HTTP es correcta.

Para crear, el navegador envía sku, nombre, precio y categoriaId. No debe inventar IDs de categorías: los obtiene de GET `/api/categorias`. La respuesta añade ID y versión administrados por el servidor.

## 4. Clasificar resultados

| Observación | Interpretación |
|---|---|
| 201 y Location | Se creó un recurso y se indica dónde consultarlo |
| 204 sin cuerpo | La operación terminó correctamente sin devolver datos |
| 400 con campos | La entrada no cumple el contrato |
| 404 | El recurso o la ruta no existe |
| 409 | El estado actual impide la operación |
| Conexión rechazada | No se obtuvo una respuesta HTTP del servidor |

No todos los errores son de red. fetch normalmente resuelve una promesa cuando recibe 400 o 500: el cliente debe comprobar response.ok. Si la respuesta es 204, llamar response.json produciría un fallo porque no hay contenido que analizar.

## Ejercicios

1. Registra una petición real de la práctica HTTP indicando método, URL, estado, tipo de contenido y cuerpo. Explica cuáles datos pertenecen a petición y cuáles a respuesta.
2. Diseña la entrada de un producto con precio 15.50 y categoría existente. Señala qué campos no debes asignar tú al crear.
3. Explica cómo representarías en React una página vacía con total cero y cómo distinguirla de una conexión fallida.

## Reto

Redacta el contrato mínimo para registrar libros: título, ISBN y categoría. Especifica un caso válido, uno inválido y un rechazo por duplicado. No implementes aún una API nueva; el objetivo es evitar ambigüedades.

## Errores frecuentes

- Usar cualquier estructura JSON porque “se ve parecida”: respeta nombres y tipos.
- Confundir 404 con servidor apagado: en 404 existe una respuesta.
- Leer el cuerpo de DELETE 204 como JSON: maneja el éxito sin cuerpo.
- Usar IDs de demostración como si fueran universales: consulta las categorías de tu base.

## Comprobación para avanzar

Puedes explicar una petición sin mirar el código, construir un cuerpo válido y anticipar cómo manejar vacío, error HTTP y error de conexión.

## Continuar

- [Unidad anterior: Punto de entrada y forma de estudiar](../unidad00-ruta/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Interfaz y recorrido del usuario](../unidad02-interfaz/README.md)
