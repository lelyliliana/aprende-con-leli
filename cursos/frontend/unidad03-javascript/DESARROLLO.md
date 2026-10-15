# Construir la interacción desde los datos hacia el DOM

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Define el estado antes de dibujar filas

Abre [03-memoria.js](../laboratorio/pasos/03-memoria.js) junto a su HTML. Esta versión comienza con `let tareas = []` y no lee ni escribe almacenamiento. Esa limitación es intencional: permite aprender el recorrido de una acción antes de introducir persistencia.

Cada tarea tiene una identidad, un título y un booleano completa. El DOM es una representación de esa colección. Si solo insertaras un li pero no actualizaras tareas, la siguiente representación perdería esa fila. Si modificas el arreglo sin representar de nuevo, la pantalla no refleja el cambio.

## 2. Prepara referencias a elementos que ya existen

querySelector localiza formulario, campo, lista, filtro y mensajes. Los ids del HTML deben coincidir. No son variables creadas por la magia del navegador: el módulo guarda referencias explícitas.

El script se carga como module después de la estructura del documento. Importa funciones del dominio compartido. Esas funciones trabajan con arreglos y no necesitan conocer un botón. En la Unidad 04 seguiremos sus reglas completas; aquí utiliza sus contratos: agregar devuelve una colección nueva, alternar cambia la tarea por id, eliminar la retira y filtrar selecciona qué representar.

## 3. Implementa primero una acción mínima

Sigue el listener submit. preventDefault evita el envío tradicional del formulario. El texto del input pasa a agregar, que valida y produce el nuevo arreglo. Solo si aplicar devuelve true se vacía el campo.

```js
form.addEventListener('submit', evento => {
  evento.preventDefault();
  if (aplicar(ts => agregar(ts, campo.value), 'Tarea agregada.')) {
    campo.value = '';
  }
});
```

`ts => agregar(ts, campo.value)` es una función que todavía no se ejecutó al escribirla. aplicar la invoca con la colección actual. Así utiliza el mismo recorrido para agregar, alternar y eliminar sin que cada listener repita mensajes, representación y manejo de errores.

## 4. Sigue aplicar sin mezclar éxito y rechazo

Dentro del try, `tareas = cambio(tareas)` sustituye el estado por el resultado de la transformación. Si la validación lanza un error antes de retornar, la asignación no se completa y se conserva el arreglo anterior. El catch muestra el mensaje. Si tiene éxito, representa, recupera foco del campo y devuelve true.

| Acción | Datos antes | Datos después | Pantalla después |
|---|---|---|---|
| Agregar A | [] | A pendiente | Una tarea |
| Agregar B | A | A y B | Dos tareas |
| Completar A | A/B pendientes | A completa, B pendiente | Marca A |
| Mostrar pendientes | A completa y B pendiente | No cambia colección | Solo B visible |
| Eliminar B | A y B | Solo A | Depende del filtro actual |

Filtrar y eliminar pueden parecer que quitan una fila; solo eliminar cambia los registros conservados. Esa diferencia se comprueba volviendo al filtro Todas.

## 5. Representa una tarea de forma segura

representar limpia la lista anterior con replaceChildren y crea elementos. El título se asigna con textContent: no interpreta marcado. La casilla refleja completa y el botón tiene nombre accesible Eliminar seguido del título. Los listeners conservan el id de su tarea, no su posición en el arreglo filtrado.

```js
texto.textContent = tarea.titulo;
casilla.addEventListener('change', () =>
  aplicar(ts => alternar(ts, tarea.id), 'Estado actualizado.')
);
```

El modelo de esta referencia reconstruye la lista completa después de cada acción. Es suficiente para un plan acotado y permite ver claramente la relación datos/vista. No significa que sea la única estrategia de DOM posible para cualquier aplicación.

## 6. Comprueba identidad y contenido

Agrega dos tareas con el mismo título. Cada creación obtiene su propia identidad; el título no es clave única. Completa una y verifica que la otra no cambió. Después filtra y elimina la visible: debe actuar sobre su id, aunque ahora esté en otra posición visual.

Introduce `<img src=x>` como título. Deben verse los caracteres y no crearse una imagen. Haz la prueba en el campo de la aplicación; no la pegues como HTML fuente de una nueva etiqueta.

## 7. Añade una búsqueda sin destruir la colección

En una copia puedes añadir un input de búsqueda y tomar una selección derivada:

```js
const consulta = buscador.value.trim().toLocaleLowerCase('es');
const visibles = filtrar(tareas, filtro.value).filter(tarea =>
  tarea.titulo.toLocaleLowerCase('es').includes(consulta)
);
```

La búsqueda vacía acepta todos los títulos que cumplen el filtro. El listener input del buscador debe llamar representar. No asignes esa selección a tareas: perderías los registros ocultos. Este fragmento ignora diferencias de mayúsculas; no promete ignorar tildes o realizar búsqueda aproximada.

Al recargar el paso 3 volverá a quedar vacío, aunque la interacción haya funcionado correctamente. Esa es la pregunta que resolverá el siguiente paso.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Interacci%C3%B3n%20con%20JavaScript%20y%20DOM%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad03-javascript%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
