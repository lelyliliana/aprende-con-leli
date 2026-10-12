# Nube y preparación para producción

[Volver al curso](../README.md)

Desplegar significa ejecutar una aplicación en un entorno donde puedan utilizarla sus usuarios. La nube ofrece recursos mediante servicios; no elimina la necesidad de configurar, comprobar y mantener la aplicación.

## Paso 1. Identificar qué se ejecuta

| Componente | Necesidad |
|---|---|
| React construido con Vite | Alojamiento de archivos estáticos |
| API Spring Boot | Proceso Java que recibe peticiones |
| Base de datos | Motor, almacenamiento persistente y copias recuperables |

Un alojamiento estático no ejecuta el JAR de Spring Boot. La aplicación completa puede tener varios servicios o servir la interfaz y la API desde el mismo origen.

## Paso 2. Comprender los modelos

En IaaS administras más infraestructura (sistema operativo y aplicación). En PaaS el proveedor gestiona más del entorno y tú configuras/despliegas tu aplicación. En SaaS utilizas un software ya ofrecido como servicio. Nube pública, privada e híbrida describen otra dimensión: cómo se organiza y utiliza la infraestructura.

## Paso 3. Preparar los artefactos

Sigue [build y publicación de React](https://github.com/lelyliliana/Curso-React/blob/main/unidad32-build/README.md) y [empaquetado de Spring Boot](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad27-produccion/README.md). Ejecuta los comandos desde el proyecto correspondiente y comprueba sus resultados. `npm run preview` sirve para revisar el build localmente; no es un servidor de producción.

## Paso 4. Separar configuración y secretos

La URL pública de una API puede configurarse en React. Las variables VITE_ llegan al navegador y se incorporan durante el build: no guardes contraseñas ni claves privadas en ellas. Cambiar su valor normalmente requiere reconstruir la interfaz.

Configura credenciales de base de datos en el entorno del backend. En producción, `localhost` dentro del navegador apunta al equipo de quien visita la página. Comprueba URL de API, HTTPS, puerto del servidor y origen permitido antes de publicar.

## Paso 5. Verificar operación

Comprueba la página, los flujos de consulta y escritura, errores, logs, persistencia y recuperación de una copia de datos. Un build exitoso no demuestra que la base esté conectada o que CORS permita a la interfaz consultar la API.

La elección de proveedor y el despliegue completo se harán cuando el laboratorio integrado pueda ejecutarse y comprobarse localmente. Esta unidad no exige contratar un servicio para aprender los conceptos.
