# Laboratorio Full Stack: catálogo de productos

[Volver al curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/fullstack/)

Construye y comprende una aplicación que consulta, crea, edita y elimina productos. React se conecta mediante HTTP y JSON a Spring Boot; JPA guarda los registros en H2. Incluye búsqueda, paginación, categorías, validación, estados de interfaz y conflictos de actualización.

El cliente React está en esta carpeta. El backend se reutiliza del **curso público de Spring Boot**; no necesitas cursos universitarios ni duplicar su código. GitHub permite leer el código: para ejecutar la aplicación debes descargar los repositorios y seguir los pasos siguientes.

## Antes de comenzar

Necesitas Git, Node.js 24 LTS (desde 24.15.0), npm, Java 21 y Maven 3.9.x. Los comandos de esta guía funcionan en PowerShell (Windows), Terminal (macOS) y una terminal de Linux. No requiere Docker, WSL, MySQL ni contratar servicios.

Si necesitas repasar un concepto, consulta solo el tema correspondiente:

- [Entorno React](https://github.com/lelyliliana/Curso-React/blob/main/docs/ENTORNO.md).
- [Entorno Java y Maven](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/ENTORNO.md).
- [Fetch y HTTP](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad20-fetch/README.md).
- [Estado y formularios React](https://github.com/lelyliliana/Curso-React/blob/main/unidad10-formularios/README.md).
- [JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad11-jpa/README.md).

## Paso 1. Comprobar herramientas

Ejecuta cada comando y revisa su salida antes de continuar:

```text
node --version
npm --version
java -version
mvn -version
git --version
```

`mvn -version` debe indicar Java 21, además de Maven. Si alguno no existe o Maven utiliza otro Java, sigue la guía de entorno enlazada. Esta práctica fija sus dependencias en `package-lock.json` y registra el backend compatible en [backend.json](backend.json).

## Paso 2. Descargar el backend público

Desde una carpeta para tus prácticas:

```text
git clone https://github.com/lelyliliana/Curso-Spring-Boot.git
cd Curso-Spring-Boot
git checkout --detach 28abba405067d59f8670c144443727772ee5db17
```

El aviso de HEAD separado es esperado: estás usando la revisión comprobada de este laboratorio. No ejecutes este checkout sobre un repositorio donde tengas cambios propios; usa una copia nueva para la práctica.

Comprueba el backend:

```text
mvn -f laboratorios/jpa-productos/pom.xml verify
```

Después inícialo:

```text
mvn -f laboratorios/jpa-productos/pom.xml spring-boot:run
```

Espera el mensaje de inicio. Conserva esta terminal abierta. En el navegador abre `http://127.0.0.1:8080/api/productos`: debes recibir un objeto JSON con `contenido`, `pagina`, `tamano`, `total` y `paginas`. La demostración inicia con cuatro productos y tres categorías.

No uses la API final `ejemplos/api-productos` en lugar de este laboratorio: tiene autenticación y CSRF, y requiere otro flujo de cliente.

## Paso 3. Descargar e iniciar React

Abre una **segunda terminal** en la carpeta donde guardas tus prácticas (junto a Curso-Spring-Boot):

```text
git clone https://github.com/lelyliliana/aprende-con-leli.git
cd aprende-con-leli/cursos/fullstack/laboratorio
npm ci
npm run dev
```

Si ya descargaste Aprende con Leli, actualiza tu copia sin perder cambios propios y entra a la carpeta indicada; no necesitas clonarlo otra vez.

Abre `http://127.0.0.1:5173/`. Debes ver cuatro productos y el formulario de creación. No abras `index.html` haciendo doble clic: Vite procesa JSX y reenvía las peticiones a la API.

## Paso 4. Completar el recorrido CRUD

1. Crea un producto con SKU `FS-01`, nombre `Cuaderno de práctica`, precio `25.50` y categoría `Libros`. Comprueba el mensaje de confirmación y el registro en el catálogo.
2. Busca `Cuaderno`. Observa la petición en Red (Network) y su respuesta paginada.
3. Abre **Editar** y cambia el precio. El cliente envía PUT con la versión recibida; la API devuelve el registro actualizado.
4. Intenta crear otro producto con el mismo SKU. Debes recibir un conflicto y conservar el formulario.
5. Borra el producto de práctica. Cancela primero para comprobar que no se elimina; vuelve a abrir el diálogo y confirma. La respuesta DELETE es 204 y no contiene JSON.
6. Busca un nombre inexistente. Debe aparecer el estado de lista vacía, no un error.

En [arquitectura y contrato](docs/ARQUITECTURA.md) se explica cada responsabilidad y el flujo de los datos.

## Paso 5. Probar errores y concurrencia

Sigue [pruebas y diagnóstico](docs/PRUEBAS.md) para detener/reiniciar la API, observar validación del servidor, navegar entre páginas y provocar un conflicto desde dos pestañas.

La aplicación no reintenta escrituras automáticamente. Si se pierde una respuesta, consulta el catálogo antes de repetir la operación: el servidor pudo haberla aplicado.

## Paso 6. Comprender la persistencia

El perfil de demostración usa H2 **en memoria**: la información sobrevive a una recarga del navegador, pero no al reinicio del backend. JPA está conectado a un motor real; el modo de almacenamiento determina cuánto dura la información.

En [persistencia entre reinicios](docs/PERSISTENCIA.md) puedes ejecutar el mismo backend con H2 en archivo y comprobar que los cambios se conservan. Las categorías y los datos ficticios se insertan mediante migraciones.

## Paso 7. Ejecutar comprobaciones automáticas

Desde la carpeta del cliente (laboratorio):

```text
npm test
npm run build
```

Con Spring Boot y Vite iniciados:

```text
npm run verify:integration
```

La última comprobación realiza operaciones reales por el proxy de Vite. Crea un producto de prueba con SKU único, lo modifica y elimina. Úsala con tus datos ficticios locales.

Las pruebas de React comprueban comportamientos con respuestas controladas. La comprobación de integración prueba HTTP y la base real; no sustituye una revisión del navegador. Consulta [verificación registrada](docs/VERIFICACION.md) para conocer los resultados y límites.

## Paso 8. Revisar el build

Detén Vite con Ctrl+C y ejecuta:

```text
npm run preview
```

Mantén Spring Boot iniciado. Abre `http://127.0.0.1:4173/` y repite una consulta y una creación de prueba. `preview` reenvía las peticiones para esta revisión local; no es un servidor de producción.

[Preparación para producción](docs/PRODUCCION.md) explica qué debes cambiar antes de publicar la aplicación completa.

## Retos

Intenta los [retos](docs/RETOS.md) y después compara con las [soluciones razonadas](docs/SOLUCIONES.md). No basta copiar el código: debes explicar dónde se guarda cada dato, qué petición provoca cada acción y cómo se informa un fallo.

## Organización

| Archivo | Responsabilidad |
|---|---|
| src/App.jsx | Estados, formulario, catálogo y acciones del usuario |
| src/api.js | Contrato HTTP, errores y tiempos de espera |
| vite.config.js | Proxy y puertos de práctica |
| src/App.test.jsx | Comportamientos de la interfaz |
| src/api.test.js | Peticiones, errores y respuesta sin cuerpo |
| scripts/verificar-integracion.mjs | Comprobación de API real a través de Vite |
| backend.json | Revisión compatible del curso público Spring Boot |

**Autora:** Leli Liliana Díaz Izquierdo.
