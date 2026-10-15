# Preparar un proyecto y elegir un punto de partida

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. El problema que vas a construir

Una persona necesita organizar qué estudiará, completar tareas y volver a encontrarlas después. Construiremos una solución pequeña antes de añadir otras funciones. El modelo de una tarea tendrá id, titulo y completa. HTML dará significado a los controles; CSS organizará su presentación; JavaScript responderá a eventos; React representará el mismo problema mediante componentes.

Hay dos recorridos complementarios: cinco versiones pequeñas en la carpeta pasos y una aplicación completa con tres páginas principales. Las versiones pequeñas permiten ver qué se añadió; la completa permite practicar integración y fallos. No necesitas memorizar todo el proyecto final antes de comenzar.

## 2. Prepara un entorno identificable

Necesitas navegador, editor, Node.js compatible con el package.json y npm. Git es una opción para descargar y actualizar; también puedes descargar el ZIP desde GitHub y extraerlo. No abras archivos directamente dentro del ZIP.

Primero comprueba el ejecutor con un comando:

```text
node --version
```

Después comprueba npm:

```text
npm --version
```

La referencia pide Node 24 LTS desde 24.15.0 y menor que 25. El package-lock.json fija dependencias concretas. No cambies versiones solo porque todavía no sabes desde qué carpeta ejecutas el comando.

Entra con tu terminal a aprende-con-leli/cursos/frontend/laboratorio. Si ya estás en esa carpeta, no repitas la ruta completa. Comprueba que ves package.json, package-lock.json y vite.config.js. Ejecuta por separado:

```text
npm ci
```

Cuando termine, inicia:

```text
npm run dev
```

Conserva esa terminal mientras usas la práctica. Vite sirve los archivos y transforma módulos/JSX; la página de GitHub muestra fuentes, no ese proceso ejecutándose en tu computador. Detener el proceso impide solicitar nuevas respuestas de ese servidor.

## 3. Abre una sola etapa

Visita `http://127.0.0.1:5174/pasos/index.html`. La lista te lleva al punto concreto. Comienza con HTML; no intentes probar persistencia antes de tener una interacción.

| Punto | Comportamiento que puedes comprobar |
|---|---|
| 01-html.html | Estructura sin hoja de estilos y controles deshabilitados |
| 02-css.html | Misma estructura presentada con CSS |
| 03-memoria.html | Agregar, completar, filtrar y eliminar; recargar comienza vacío |
| 04-guardado.html | Mismas acciones con documento local persistente |
| 05-react.html | Mismo documento del paso 4 con componentes React |

Después consulta index.html, javascript.html y react.html en la raíz del laboratorio. Son las tres páginas de integración que ya contiene el curso. El build incluye las nueve páginas: seis del recorrido, contando su índice, y tres principales.

## 4. Separa las dos prácticas de datos

Los pasos 4/5 usan leli.frontend.construccion.v1. Las páginas principales JavaScript/React usan leli.frontend.plan.v1. La separación evita que una prueba de construcción reemplace el plan completo. Abrir la aplicación principal no importa automáticamente las tareas de los pasos.

El paso 3 solo usa memoria. Recargarlo pierde su estado por diseño. En el paso 4, guardar y recargar bajo el mismo origen permite volver a leer el documento. Cambiar host, protocolo o puerto puede mostrar otro almacenamiento. No abras dos versiones persistentes para editar simultáneamente: no coordinan cambios entre pestañas.

## 5. Diagnostica una dificultad concreta

Un error de npm por archivo ausente puede indicar carpeta incorrecta. Un puerto ocupado requiere localizar el proceso y conservar una decisión explícita de puerto; la configuración usa strictPort. Un JSX que el navegador no interpreta puede indicar que abriste el archivo sin el servidor de desarrollo.

Antes de cambiar código, registra comando, carpeta y primera parte relevante del error. Prueba primero una página estática servida y después una interactiva. Esa secuencia separa instalación, servidor y aplicación.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Ruta%20y%20entorno%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad00-entorno%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
