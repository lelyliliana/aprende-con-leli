# Pruebas y diagnóstico paso a paso

[Volver al laboratorio](../README.md)

## Paso 1. Observar las peticiones

Abre las herramientas de desarrollo del navegador, selecciona Red (Network) y pulsa Actualizar catálogo. Debes ver peticiones a `/api/productos` y `/api/categorias` en el puerto de Vite. Inspecciona método, parámetros, estado y cuerpo. Si no sabes utilizar la herramienta, consulta [DevTools](https://github.com/lelyliliana/Curso-React/blob/main/unidad27-debug/README.md).

## Paso 2. Detener la API

Detén Spring Boot con Ctrl+C y pulsa Actualizar catálogo. Se muestra un error, sin presentar el catálogo anterior como si estuviera actualizado. Inicia Spring Boot otra vez y pulsa Reintentar. Se recupera el catálogo. En memoria, los datos creados anteriormente se habrán perdido.

## Paso 3. Validación del servidor

El formulario limita la entrada. Para comprobar que el servidor también valida, abre la consola del navegador **en la aplicación local** y ejecuta:

```javascript
fetch('/api/productos', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ sku: 'INVALIDO-01', nombre: 'Prueba', precio: 0, categoriaId: 1 })
}).then(async r => console.log(r.status, await r.json()));
```

Debes observar 400 y un error en precio. El registro no debe aparecer en el catálogo. La prueba automática realiza un caso equivalente utilizando una categoría recibida de la API.

## Paso 4. Dos pestañas y un conflicto

1. Abre dos pestañas de `http://127.0.0.1:5173/`.
2. Abre Editar sobre el mismo producto en ambas.
3. Cambia el nombre en la primera y guarda.
4. Cambia el nombre en la segunda y guarda.
5. La segunda muestra conflicto 409 y conserva lo escrito.
6. Copia tu propuesta si deseas conservarla; pulsa Actualizar catálogo y vuelve a abrir Editar. Compara con el dato actual antes de decidir.

Esto evita que la segunda pestaña sobrescriba silenciosamente lo guardado por la primera. Un SKU duplicado también devuelve 409, por lo que el mensaje presenta ambas posibilidades.

## Paso 5. Paginación y eliminación

La demostración comienza con cuatro productos. Crea al menos dos productos ficticios adicionales para habilitar la segunda página. Navega con Siguiente, elimina el último registro de una página y comprueba que el catálogo retrocede cuando la página queda vacía. Un filtro nuevo comienza desde la primera página.

## Paso 6. Teclado

Recorre los controles con Tab y comprueba el foco visible. Abre el diálogo de eliminación: el foco inicia en Cancelar, Tab permanece dentro del diálogo y Escape cancela. Comprueba que el botón desde donde abriste el diálogo recupera el foco. La creación y los errores se anuncian mediante regiones de estado/alerta.

## Problemas frecuentes

| Síntoma | Qué revisar |
|---|---|
| Comando no reconocido | Herramienta instalada y terminal reiniciada |
| Maven usa Java 17 | Java seleccionado en mvn -version |
| Puerto ocupado | Detener ejecución anterior; Vite no cambia de puerto silenciosamente |
| API devuelve 401/403 | Usaste la API final con Security en vez del laboratorio JPA |
| Proxy 500/502 o conexión fallida | Backend iniciado en 127.0.0.1:8080 |
| Error CORS | Usa /api por Vite; no reemplaces fetch con no-cors |
| Error 409 | SKU duplicado o versión desactualizada |
| Producto desaparece al reiniciar | H2 en memoria; sigue PERSISTENCIA.md |
| No aparecen categorías | Falló la carga o usaste una base sin datos de demostración |
| El build no consulta la API alojado fuera de Vite | El proxy local no se publica; sigue PRODUCCION.md |

Para cerrar la práctica detén ambos procesos con Ctrl+C en sus terminales.
