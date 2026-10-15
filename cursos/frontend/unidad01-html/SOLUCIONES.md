# Soluciones desarrolladas de la Unidad 01

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Cambiar el tema

En una copia usa h1 Mi plan de lectura y un párrafo que explique para quién sirve. Guarda el archivo, recarga su URL y distingue esa edición de un cambio temporal en DevTools. Un h1 no se elige solo por el tamaño que el navegador le da.

## Ejercicio 2. Ayuda asociada

La solución completa del recorrido es:

```html
<label for="titulo">Título de la tarea</label>
<p id="ayuda">Escribe la actividad que realizarás esta semana.</p>
<input id="titulo" aria-describedby="ayuda" disabled>
```

for e id conectan el nombre; aria-describedby apunta al párrafo de ayuda. Cuando se habilite el campo, pulsar la etiqueta deberá dirigir el foco al control correspondiente.

## Ejercicio 3. Enlace y botón

El enlace al paso 2 cambia de documento. Agregar tarea es una acción sobre el plan. En esta maqueta está deshabilitada porque no se implementó todavía la acción. Darles el mismo color no cambia sus responsabilidades.

## Reto desarrollado

Una adaptación a lectura puede usar una tarea ficticia Leer capítulo 1. Conserva lista y estado Pendiente. No la presentes como guardada hasta implementar datos y persistencia. Comprueba regiones y nombres sin CSS antes de continuar.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
