# Laboratorio Frontend: mi plan de estudio

[Volver al curso](../README.md)

Un proyecto, tres etapas: estructura/diseño, tareas con JavaScript y componentes React. JavaScript y React usan las mismas funciones de dominio y la misma clave de almacenamiento, sin cursos universitarios.

## Construcción antes de la integración

Sigue el [recorrido de cinco versiones pequeñas](pasos/README.md) y los desarrollos de cada unidad. Una vez iniciado dev, abre http://127.0.0.1:5174/pasos/. Las versiones guardadas de esa construcción usan una clave distinta de la aplicación principal.

## Paso 1. Preparar

Necesitas Node.js 24 LTS desde 24.15.0, npm y Git. Si necesitas instalar o verificar, consulta [entorno del curso público React](https://github.com/lelyliliana/Curso-React/blob/main/docs/ENTORNO.md).

```text
node --version
npm --version
git --version
```

## Paso 2. Descargar

```text
git clone https://github.com/lelyliliana/aprende-con-leli.git
cd aprende-con-leli/cursos/frontend/laboratorio
npm ci
npm run dev
```

Si ya tienes una copia, actualízala conservando tus cambios y entra a la carpeta indicada. Los comandos son comunes a las terminales de Windows, macOS y Linux; la comprobación registrada se realizó en Linux.

## Paso 3. Estructura y diseño

Abre http://127.0.0.1:5174/index.html. Observa la estructura, modifica textos en tu copia y comprueba estilos. Esta etapa presenta datos de ejemplo y controles deshabilitados; aún no guarda tareas. Realiza las unidades 01 y 02.

## Paso 4. Interacción JavaScript

Abre http://127.0.0.1:5174/javascript.html. Agrega una tarea, complétala, filtra y elimina. Recarga para comprobar el guardado. Examina javascript.js, dominio.js y almacenamiento.js. Realiza las unidades 03 y 04.

## Paso 5. React sobre el mismo modelo

Cierra la versión JavaScript y abre http://127.0.0.1:5174/react.html. Deben aparecer las tareas que conservaste. La interfaz usa App.jsx, las mismas reglas y el mismo documento versionado.

Agrega y completa una tarea, cierra React y vuelve a JavaScript para comprobar transferencia. No edites simultáneamente desde dos pestañas: no se coordinan en esta versión. Realiza la unidad 05.

## Paso 6. API de práctica

En React, cambia la respuesta de recursos entre normal, vacío y error. Observa 200 con datos, 200 con [] y 503. Reintenta y vuelve al modo normal. El endpoint /api/recursos devuelve datos ficticios desde un plugin de Vite; no requiere servicio externo. Realiza la unidad 06.

## Paso 7. Comprobar

```text
npm test
npm run build
npm run preview
```

Preview sirve en http://127.0.0.1:4174/. Abre las tres páginas por sus nombres y repite el recorrido. Los datos de 5174 no aparecen automáticamente en 4174 porque cambia el origen.

Con dev iniciado, también puedes ejecutar `npm run verify:http`: comprueba las nueve páginas y las respuestas del endpoint.

## Almacenamiento y recuperación

La clave propia es leli.frontend.plan.v1 y guarda version 1 con tareas. El plan admite hasta 100 tareas, títulos de 1 a 80 unidades de longitud de cadena JavaScript e IDs únicos. Solo se escribe después de una acción válida.

Un contenido inválido se conserva y las modificaciones se bloquean hasta corregirlo. Para una prueba con datos ficticios, copia el valor en las herramientas de desarrollo antes de repararlo; actúa únicamente sobre esa clave y recarga. No borres todo el almacenamiento del sitio.

Si guardar falla, el cambio continúa en memoria y se muestra un aviso. No es respaldo remoto ni una cuenta; otro navegador u origen tiene otro almacenamiento. Usa datos ficticios de práctica.

Para verificar el servidor preview con el mismo script utiliza `npm run verify:http -- http://127.0.0.1:4174`.

## Estructura

| Archivo | Función |
|---|---|
| index.html y estilos.css | Estructura y diseño compartido |
| javascript.html y src/javascript.js | DOM y eventos |
| react.html y src/App.jsx | Estado y representación con React |
| src/dominio.js | Reglas y transformaciones sin interfaz |
| src/almacenamiento.js | Documento y clave común |
| src/Recursos.jsx | Peticiones y estados remotos |
| vite.config.js | Tres entradas de build y endpoint local |

## Publicación y límites

El build genera nueve páginas: tres principales y seis del recorrido de construcción, contando su índice. Las tareas locales funcionan en alojamiento estático. La API de recursos existe solo mientras dev o preview sirven: para conservar esa vista publicada necesitas una API en el destino o declarar una variante estática. No publiques dist esperando que incluya el proceso Vite.

No se publicó una aplicación con cuentas o sincronización remota. La publicación del curso entrega código e instrucciones. Sigue la unidad 07 para entregar un proyecto propio y registra sus límites.

[Ver resultados de comprobación](docs/VERIFICACION.md)
