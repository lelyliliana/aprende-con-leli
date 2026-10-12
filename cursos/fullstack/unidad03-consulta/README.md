# Unidad 03. React conectado a una API

[Volver al índice](../README.md)

## Objetivos

- Seguir una petición desde React hasta Spring Boot y de vuelta.
- Representar carga, datos, vacío y error sin datos inventados.
- Evitar que una respuesta antigua reemplace una consulta nueva.

## Antes de comenzar

Debes poder trabajar con un componente y estado React. Si lo necesitas, repasa [useState](https://github.com/lelyliliana/Curso-React/blob/main/unidad07-usestate/README.md) y [datos remotos](https://github.com/lelyliliana/Curso-React/blob/main/unidad14-datos-remotos/README.md). El laboratorio debe tener Spring Boot y Vite iniciados según su guía.

## 1. Ejecutar la primera etapa

Abre `http://127.0.0.1:5173/?etapa=1`. Debes ver los productos de demostración. Todavía no hay formulario de creación ni botones de edición. El objetivo es comprender una consulta completa antes de añadir escrituras.

En Red (Network) observa la petición a `/api/productos`. El navegador la dirige al puerto de Vite y el proxy la reenvía a 8080. El archivo de configuración no cambia el contrato de la API ni almacena datos.

## 2. Explicar Consulta.jsx

Abre [Consulta.jsx](../laboratorio/src/etapas/Consulta.jsx). Lee sus bloques en este orden:

1. Los estados productos, total, cargando y error describen lo que se puede mostrar.
2. El efecto inicia una consulta cuando cambian revision o intento.
3. listarProductos obtiene el objeto paginado y la respuesta se interpreta con pagina.contenido.
4. La rama catch comunica el fallo; finally termina el estado de carga.
5. El retorno del efecto cancela una consulta que dejó de ser necesaria.
6. El JSX representa un estado por vez y ofrece reintento cuando falla.

No necesitas copiar cada línea de memoria. Debes poder señalar cuál línea inicia la operación y cuál modifica lo visible cuando termina.

## 3. Del componente al cliente HTTP

Abre [api.js](../laboratorio/src/api.js). listarProductos construye parámetros con URLSearchParams y delega en request. Así se evita concatenar un nombre con espacios o símbolos sin codificarlo.

request comprueba estados HTTP y devuelve los datos; no decide cómo se dibujan. El componente conoce estados de interfaz y el cliente conoce peticiones. Esa separación permite probar errores sin necesitar un servidor en cada prueba de React.

## 4. Qué protege la cancelación

La persona puede abandonar una pantalla o iniciar otra consulta antes de que llegue una respuesta. Si una respuesta antigua se aplica después de la nueva, se muestran datos del filtro incorrecto. AbortController y la comprobación de signal.aborted impiden aplicar resultados que ya no corresponden.

Cancelar una consulta desde el cliente no demuestra que se haya cancelado una escritura en el servidor. Por eso no usamos cancelación como garantía para deshacer una creación.

## Ejercicios

1. Cambia el tamaño de página de cinco a dos en api.js. Predice el número de registros mostrado y observa total. Después restaura el tamaño para seguir la guía.
2. Detén Spring Boot, pulsa Volver a consultar y explica lo observado. Reinícialo y usa Reintentar consulta.
3. En tu copia añade el SKU como texto en cada elemento, usando el campo que ya devuelve la API. No crees un segundo arreglo de datos ficticios.

## Reto

Añade un filtro por nombre a la etapa de consulta. Reinicia la página interna a cero al cambiar el filtro y diferencia búsqueda vacía de conexión fallida. Intenta resolverlo antes de consultar la etapa 3, que muestra una implementación completa.

## Errores frecuentes

- Hacer map sobre la respuesta completa: el arreglo está en contenido.
- Escribir productos fijos en el JSX: oculta si la integración falla.
- Omitir las dependencias del efecto o incluir un objeto nuevo en cada render sin criterio: provoca datos antiguos o peticiones repetidas.
- Usar no-cors para ocultar un bloqueo: una respuesta opaca no permite leer productos.

## Comprobación para avanzar

Puedes modificar la consulta, explicar el proxy, recuperar la interfaz tras detener la API y señalar cómo se evita aplicar una respuesta anterior.

## Continuar

- [Unidad anterior: Interfaz y recorrido del usuario](../unidad02-interfaz/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Escrituras, validación y persistencia](../unidad04-escrituras/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20React%20conectado%20a%20una%20API%20del%20curso%20Desarrollo%20Full%20Stack%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffullstack%2Funidad03-consulta%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
