# Conectar las capas: contrato y comprobaciones

[Volver al curso](../README.md)

Un frontend y un backend no quedan integrados solo por ejecutarse a la vez. Deben acordar rutas, métodos, campos, validaciones y errores. La base de datos pertenece al backend: el navegador no recibe su contraseña.

## Paso 1. Elegir una implementación concreta

Usa el [laboratorio JPA de productos](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/laboratorios/jpa-productos/README.md). Sigue allí la instalación, las pruebas y la ejecución. Esa etapa permite practicar sin la autenticación de la API final. No combines sus comandos con los de otros proyectos.

Consulta su [contrato HTTP](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/CONTRATO_ETAPAS.md). Antes de crear formularios, registra qué campos recibe POST, cuáles exige PUT y qué campos devuelve GET. La versión del registro interviene en las actualizaciones; no debe omitirse.

## Paso 2. Comprobar el backend por separado

Sigue las peticiones de ejemplo del laboratorio. Comprueba consulta (200), creación (201), validación y registro inexistente. Si la API falla por sí sola, resuelve ese problema antes de trabajar en React. H2 en memoria pierde los cambios al reiniciar; eso no demuestra persistencia entre reinicios.

## Paso 3. Preparar la interfaz

Consulta [datos remotos](https://github.com/lelyliliana/Curso-React/blob/main/unidad14-datos-remotos/README.md), [estados remotos](https://github.com/lelyliliana/Curso-React/blob/main/unidad15-estados-remotos/README.md) y [configuración](https://github.com/lelyliliana/Curso-React/blob/main/unidad31-configuracion/README.md) cuando los necesites.

La interfaz debe mostrar carga, error, lista vacía y datos. `fetch` no rechaza automáticamente una respuesta 400 o 500: comprueba `response.ok`. Una respuesta 204 no tiene cuerpo JSON que debas analizar.

## Paso 4. Resolver el origen de las peticiones

Protocolo, host y puerto forman el origen. React en el puerto 5173 y una API en 8080 tienen orígenes diferentes. Para el laboratorio integrado habrá que configurar un proxy de desarrollo o CORS en el backend. CORS regula el acceso del navegador a respuestas entre orígenes; no sustituye autenticación ni autorización.

No uses `mode: 'no-cors'` para ocultar un error: una respuesta opaca no permite leer los datos. Observa la petición en Red y distingue conexión fallida, bloqueo CORS y error HTTP.

## Paso 5. Definir evidencias de integración

| Acción | Comprobación |
|---|---|
| Abrir catálogo | La interfaz presenta los productos de la API |
| Crear producto válido | Se confirma y aparece en una nueva consulta |
| Enviar entrada inválida | Se muestra el error y se conserva el formulario |
| Actualizar una versión antigua | El conflicto se informa sin sobrescribir silenciosamente |
| Detener API | Se muestra un error recuperable |
| Volver a iniciarla | La interfaz permite reintentar |

El [laboratorio integrado](../laboratorio/README.md) incluye el cliente React, el proxy de desarrollo, pruebas de interfaz y una comprobación contra la API real. Sigue su recorrido desde la instalación hasta CRUD, errores y persistencia entre reinicios.

[Continuar: nube y producción](nube.md)
