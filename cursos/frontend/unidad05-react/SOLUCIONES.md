# Soluciones desarrolladas de la Unidad 05

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Clasificar estados

En App de la aplicación principal, titulo y filtro pertenecen a interfaz; tareas al modelo; error y mensaje a la operación. La cantidad de completas se puede derivar del arreglo. El paso 5 presenta la misma separación con nombres legibles y componente Tarea extraído.

## Ejercicio 2. Transferencia

Para los pasos utiliza 04-guardado y 05-react. Agrega en uno, cierra, abre el otro y comprueba. Para la pareja principal utiliza javascript.html y react.html. Mantén la misma identidad y documento; no cambies de clave durante la prueba.

## Ejercicio 3. Cantidad completa

Dentro del componente calcula `const completas = tareas.filter(t => t.completa).length;` y representa `<p>{completas} tareas completas.</p>`. No hace falta otro useState ni un efecto para actualizar esa cuenta después de cada acción.

## Reto resuelto: extracción de Tarea

La versión completa de [05-react.jsx](../laboratorio/pasos/05-react.jsx) incluye Tarea. El checkbox usa tarea.completa y notifica alCompletar(tarea.id). El botón comunica alEliminar(tarea.id). El padre conserva reglas, mensajes y persistencia. Esto permite comparar una extracción completa con el reto, en lugar de ofrecer únicamente una recomendación conceptual.

Prueba dos tareas de igual título y elimina una: la identidad debe impedir que desaparezca la otra. Filtrar no debe cambiar cuál objeto recibe la acción.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
