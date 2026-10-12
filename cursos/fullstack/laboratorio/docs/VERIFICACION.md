# Verificación del laboratorio 1.0

[Volver al laboratorio](../README.md)

Comprobación realizada el 11 de octubre de 2026 (Colombia), con el backend registrado en backend.json.

## Resultados

| Comprobación | Resultado |
|---|---|
| Pruebas del cliente (Vitest y Testing Library) | 17 correctas |
| Pruebas del laboratorio público JPA (Maven verify) | 7 correctas |
| Build del cliente | Correcto |
| Peticiones reales a través del proxy de desarrollo | Correctas |
| Peticiones reales a través del proxy de preview del build | Correctas |
| Categorías, creación, consulta, filtro, actualización y eliminación | Correctas |
| Entrada inválida (400) y SKU duplicado (409) | Correctos |
| Versión antigua (409) sin sobrescribir el registro | Correcta |
| DELETE sin cuerpo (204) y consulta posterior (404) | Correctos |
| API detenida | Proxy devuelve error; no inventa datos |
| H2 en archivo tras dos reinicios del backend | Producto conservado |

Las pruebas de interfaz incluyen formulario, tipos numéricos, versión de actualización, conservación de campos, validación, confirmación de eliminación, reintento, lista vacía, cancelación de carga, bloqueo de doble envío, paginación tras eliminar y foco del diálogo.

## Entorno utilizado

- Linux, Node.js 24.19.0 y npm 11.9.0.
- Java 21.0.12.1 y Maven 3.9.11.
- React 19.3.0, Vite 8.3.4 y Vitest 5.0.3 (lockfile incluido).
- Spring Boot 4.1.1, H2 y las migraciones del laboratorio público JPA.

## Límites de la comprobación

No se hizo inspección visual con un navegador real, ni ejecución en Windows o macOS. Las pruebas de interfaz utilizan jsdom; la comprobación de integración usa peticiones HTTP reales. Los comandos se documentan sin depender de sintaxis específica de una terminal, pero no se presenta esa compatibilidad como una prueba realizada.

No se verificó un despliegue completo de la aplicación, PostgreSQL, autenticación ni CSRF para este cliente. La publicación del curso entrega sus fuentes e instrucciones; la API de práctica se ejecuta localmente.

## Repetir

Desde la carpeta laboratorio, ejecuta npm test y npm run build. Con Vite y Spring Boot iniciados, ejecuta npm run verify:integration. Para validar la base en archivo, sigue PERSISTENCIA.md. Para validar interacción y presentación en tu navegador, sigue PRUEBAS.md.
