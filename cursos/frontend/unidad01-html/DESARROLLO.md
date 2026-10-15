# Construir primero el documento que se puede entender

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Empieza por el archivo mínimo

Abre [la versión HTML completa](../laboratorio/pasos/01-html.html) en el editor y por su URL de laboratorio en el navegador. Tiene doctype, html con idioma es, head con codificación/viewport y body. Doctype declara el modo del documento; lang ayuda a interpretar su idioma; viewport permite que el diseño use el ancho disponible del dispositivo.

No necesitas añadir una clase para que un encabezado sea encabezado. Las etiquetas expresan significado antes de la apariencia. En esta versión no se enlaza ninguna hoja de estilos, así que podrás reconocer estructura sin depender de una paleta.

## 2. Escribe las regiones en un orden útil

El enlace Saltar al plan apunta al id contenido. La navegación reúne los cinco pasos. El encabezado presenta el proyecto; main conserva el contenido principal; una sección con título agrupa el planificador; footer permite continuar.

Dentro de main la sección tiene aria-labelledby apuntando a plan-title. Ese atributo nombra la sección a partir de un título que realmente existe. No crea un texto nuevo ni sustituye el encabezado visible.

| Elemento | Responsabilidad | Elección que no debe sustituirlo |
|---|---|---|
| h1 | Tema principal | Un párrafo agrandado para que parezca título |
| nav | Navegación | Una serie de botones que solo deberían abrir páginas |
| label | Nombre de un control | Placeholder que desaparece al escribir |
| button | Acción | Un enlace que cambia datos sin navegar |
| ul/li | Colección de tareas | Saltos de línea sin estructura de lista |

## 3. Une etiqueta, ayuda y campo

El formulario de la referencia tiene tres relaciones distintas. for identifica qué control nombra el label. id identifica un elemento único en el documento. aria-describedby asocia una descripción adicional, en este caso el ejemplo de contenido.

```html
<label for="titulo">Título de la tarea</label>
<p id="ayuda">Ejemplo: practicar formularios HTML.</p>
<input id="titulo" aria-describedby="ayuda" disabled>
```

No uses el mismo id para etiqueta, ayuda y control: cada referencia necesita un destino inequívoco. Al ampliar, evita duplicar ids copiando una sección completa.

En esta etapa disabled comunica que todavía no se puede ejecutar la acción. No quites ese atributo esperando que por sí solo aparezca programación. Un formulario habilitado sin listener puede realizar el envío tradicional, que no es el comportamiento del plan que construiremos.

## 4. Representa una tarea sin fingir que existe en memoria

La lista muestra Repasar HTML y Pendiente escritos directamente en el documento. Ese contenido sirve de referencia visual. No hay un arreglo que puedas consultar, identificadores creados por la aplicación ni almacenamiento. Una misma apariencia puede corresponder a implementaciones muy distintas.

Primero cambia el título principal. Guarda y observa la página servida. Después cambia el nombre de la tarea ficticia y vuelve a comprobar. Si solo editas una pestaña de herramientas de desarrollo, la modificación puede desaparecer al recargar: no equivale a guardar el archivo fuente.

## 5. Prepara contenido que después vendrá de una persona

En la versión JavaScript el título se representará con textContent; en React se colocará como texto de una expresión JSX. No necesitamos tratar el título como HTML. Una cadena como `<img src=x>` describe el contenido de una tarea, no una instrucción para crear una imagen.

No pegues esa cadena sin escapar dentro de un archivo HTML si tu objetivo es mostrarla literalmente: en HTML fuente las entidades `&lt;` y `&gt;` representan esos signos como texto. Más adelante el programa se encargará de presentar el valor introducido sin interpretarlo como marcado.

## 6. Una adaptación que conserva el significado

Para un plan de lectura, cambia h1 y la explicación, la etiqueta del campo y la tarea ficticia. Mantén regiones, asociaciones e idioma. La mejora no consiste en sustituir todas las etiquetas por div para después reconstruir su comportamiento con CSS.

Comprueba que el documento sigue siendo comprensible sin hoja de estilos. Que no tenga decoración todavía no significa que carezca de estructura: eso es precisamente lo que esta versión permite observar.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Estructura%20y%20accesibilidad%20con%20HTML%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad01-html%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
