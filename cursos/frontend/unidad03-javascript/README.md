# Unidad 03. Interacción con JavaScript y DOM

**[Construcción paso a paso: Construir la interacción desde los datos hacia el DOM](DESARROLLO.md)**. Compara versiones ejecutables, sigue el recorrido y después resuelve los ejercicios.

[Volver al índice](../README.md)

## Objetivos

Actualizar el DOM a partir de eventos y un modelo de datos.

## Explicación y práctica guiada

Abre javascript.html y agrega una tarea. Esta versión construye elementos desde el arreglo de tareas y conecta listeners con las acciones. Lee src/javascript.js en este orden: consulta de nodos, aplicar cambios, render, evento submit y evento del filtro.

Si no puedes interpretar funciones o arreglos, consulta [funciones](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad05-funciones/README.md) y [arrays](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad07-arrays/README.md) antes de seguir. Para las operaciones de la página, usa [DOM](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad12-dom/README.md) y [eventos](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad13-eventos/README.md) en el punto donde te hagan falta.

submit evita la navegación tradicional con preventDefault. Lee el texto del campo, llama a agregar y representa la colección resultante. El botón no agrega una fila independiente de los datos: primero se actualiza el modelo y después se vuelve a representar.

La función render elimina la representación anterior y reconstruye la lista. Cada checkbox y botón queda vinculado al ID de su tarea. No uses la posición del arreglo como identidad: eliminar o filtrar cambia posiciones, pero el ID del registro sigue siendo el mismo.

textContent presenta títulos como texto, incluso si contienen símbolos de marcado. Probar un título como <img src=x> debe mostrar esos caracteres y no crear una imagen. El propósito es representar contenido, no interpretar instrucciones del usuario.

El filtro decide qué tareas mostrar, no qué tareas conservar. Cambiar a Pendientes debe ocultar las completas sin eliminarlas del arreglo o del almacenamiento.

## Ejercicios

1. Agrega dos tareas y completa una. Alterna el filtro y comprueba que ambas siguen existiendo.
2. Identifica qué listener corresponde a agregar, completar y eliminar.
3. Agrega un título con caracteres de marcado y comprueba que no se convierte en un elemento HTML.

## Reto

Añade una búsqueda por título a tu copia, manteniendo la colección completa y aplicando el filtro solo a la vista.

## Errores frecuentes

Modificar solo una fila sin actualizar datos; usar innerHTML con texto del usuario; eliminar registros al filtrar.

## Comprobación para avanzar

Puedes seguir una acción desde evento hasta datos y DOM, y justificar el uso de identificadores estables.

## Continuar

- [Unidad anterior](../unidad02-css/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad04-persistencia/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Interacci%C3%B3n%20con%20JavaScript%20y%20DOM%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad03-javascript%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
