# Soluciones desarrolladas de la Unidad 03

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Filtrar conserva datos

Agrega A y B, completa A y selecciona Pendientes. Debe verse B. Al volver a Todas reaparecen A y B con sus estados. Si A desapareció del arreglo, implementaste eliminación o sustituiste el modelo por la vista filtrada.

## Ejercicio 2. Listeners

Submit agrega; change de la casilla alterna por tarea.id; click de Eliminar retira por tarea.id; change del select solo vuelve a representar. La función aplicar recibe la transformación y centraliza éxito, error y actualización.

## Ejercicio 3. Texto con marcado

Con título `<img src=x>` debes observar una cadena y ninguna imagen en la lista. textContent inserta texto. innerHTML interpretaría una cadena como marcado y no conserva ese contrato.

## Reto desarrollado: búsqueda

En una copia añade este control junto al filtro:

```html
<label for="buscar">Buscar título</label>
<input id="buscar" type="search">
```

Guarda la referencia `const buscador = raiz.querySelector('#buscar');`, sustituye la selección de visibles por el fragmento del desarrollo y añade `buscador.addEventListener('input', representar);`. Prueba consulta vacía, una coincidencia, ninguna y cambio de mayúsculas. Alterna filtros y borra la búsqueda: todos los registros deben continuar en tareas.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
