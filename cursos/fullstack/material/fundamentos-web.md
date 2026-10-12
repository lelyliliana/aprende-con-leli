# Fundamentos web: observar una petición real

[Volver al curso](../README.md)

## Qué debes comprender

El navegador es un cliente. Un servidor escucha peticiones y responde. HTTP describe el método, la ruta, las cabeceras y el cuerpo. JSON representa datos; no ejecuta instrucciones ni sustituye una base de datos.

Una URL como `http://localhost:3001/api/productos` indica protocolo, servidor, puerto y ruta. `localhost` apunta al equipo donde se ejecuta el cliente. DNS relaciona nombres con direcciones; no es necesario usarlo para esta práctica local.

## Paso 1. Crear el servidor

Necesitas Node.js. Crea una carpeta de práctica y guarda este archivo como `servidor.cjs`. No requiere instalar paquetes.

```javascript
const http = require('node:http');
const productos = [{ id: 1, nombre: 'Cuaderno', precio: 5000 }];

const servidor = http.createServer((req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  if (req.url === '/api/productos' && req.method === 'GET') {
    res.writeHead(200);
    res.end(JSON.stringify(productos));
    return;
  }
  if (req.url === '/api/productos') {
    res.setHeader('Allow', 'GET');
    res.writeHead(405);
    res.end(JSON.stringify({ mensaje: 'Método no permitido' }));
    return;
  }
  res.writeHead(404);
  res.end(JSON.stringify({ mensaje: 'Ruta inexistente' }));
});
servidor.listen(3001, '127.0.0.1', () => {
  console.log('Abre http://127.0.0.1:3001/api/productos');
});
```

## Paso 2. Ejecutar

Desde la carpeta del archivo:

```text
node servidor.cjs
```

Mantén la terminal abierta. Si aparece `EADDRINUSE`, otro programa ocupa el puerto 3001; detén tu servidor anterior antes de repetir.

## Paso 3. Observar

Abre la URL indicada en el navegador. En las herramientas de desarrollo, abre Red (Network) y recarga. Comprueba método GET, estado 200, cabecera Content-Type y cuerpo JSON. En `/otra-ruta` comprueba 404. Detén el servidor con Ctrl+C y recarga: una conexión fallida no es una respuesta HTTP 404.

## Paso 4. Modificar y explicar

Agrega otro producto, reinicia el servidor y comprueba la respuesta. Cambiar el arreglo cambia los datos de memoria; esta práctica no guarda modificaciones en una base de datos. Explica qué viaja desde el cliente y qué devuelve el servidor.

| Operación habitual | Método | Resultado frecuente |
|---|---|---|
| Consultar | GET | 200 |
| Crear | POST | 201 |
| Reemplazar | PUT | 200 o 204 |
| Modificar parcialmente | PATCH | 200 o 204 |
| Eliminar | DELETE | 204 |

El servidor de esta práctica implementa únicamente GET. Los otros métodos requieren implementar y validar su comportamiento. 400 representa una petición inválida, 401 falta de autenticación, 403 acceso denegado y 500 un fallo del servidor.

## Continuar

[Fetch y peticiones desde JavaScript](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad20-fetch/README.md). Vuelve al índice y sigue Interfaces web si aún no conoces HTML, CSS o JavaScript.
