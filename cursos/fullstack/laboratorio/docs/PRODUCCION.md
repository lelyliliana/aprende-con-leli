# Del laboratorio local a producción

[Volver al laboratorio](../README.md)

Esta versión comprueba integración local. El backend utilizado es una etapa educativa sin autenticación. No lo expongas con información de usuarios reales como una aplicación lista para producción.

## Paso 1. Comprender qué se publica

`npm run build` genera `dist`. Vite usa rutas relativas para los archivos del cliente, pero su proxy no se incluye en dist. Un alojamiento de archivos estáticos solo entrega la interfaz: necesita una API accesible y una configuración coherente.

`npm run preview` prueba el build local en 4173 y utiliza el mismo proxy que el entorno dev. El comando no despliega nada.

## Paso 2. Elegir cómo conectar la API

La opción recomendada para conservar este cliente es servir la interfaz y reenviar `/api` al backend bajo el mismo origen mediante un servidor/proxy de producción. En ese caso se mantiene el valor vacío de VITE_API_URL.

Si utilizas otro origen para el backend, crea `.env.local` en la carpeta laboratorio con, por ejemplo:

```text
VITE_API_URL=https://api.ejemplo.com
```

Reinicia Vite durante desarrollo o reconstruye la interfaz para producción. El backend debe admitir explícitamente ese origen mediante CORS; el laboratorio JPA no incluye esa configuración. CORS no es una medida de autenticación.

Las variables VITE_ se incorporan al JavaScript que descarga el navegador. Nunca pongas en ellas credenciales de la base de datos o claves privadas.

## Paso 3. Preparar el backend y la base

Sigue [configuración de producción](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad27-produccion/README.md) y [operación](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/OPERACION.md). El laboratorio JPA puede usar PostgreSQL con el perfil prod, pero requiere URL, usuario, contraseña y categorías creadas en la base nueva.

La API final del curso añade seguridad. Este cliente todavía no implementa login ni envío de tokens CSRF, por lo que no puedes cambiar de backend sin adaptar ese flujo.

## Paso 4. Comprobar antes de publicar

Verifica HTTPS, rutas, validación, autenticación y permisos, conexión a la base, migraciones, errores, logs y recuperación de copias. Repite los flujos reales con los artefactos que publicarás.

No se contrató ni publicó infraestructura en esta práctica. El despliegue completo y la integración de seguridad quedan como ampliaciones, después de comprender la conexión local.
