# Soluciones desarrolladas de la Unidad 07

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Alcance de las pruebas

Dominio evalúa reglas; componente/DOM comprueba interacción en entorno controlado; HTTP consulta un servidor real escuchando. Ninguna por separado demuestra la apariencia y el teclado de todos los navegadores. Elige evidencia adecuada a la afirmación.

## Ejercicio 2. Build y preview

El build genera nueve páginas: tres principales, índice de construcción y cinco pasos. Preview permite servir ese resultado con el middleware de práctica. Un alojamiento estático de dist no lleva ese proceso de API. Comprueba ese límite antes de anunciar que todas las funciones remotas quedaron publicadas.

## Ejercicio 3. README reproducible

Indica requisitos de Node, carpeta laboratorio, npm ci, arranque, URLs, pruebas y build. Explica las dos claves de práctica y que no hay sincronización entre pestañas/equipos. Describe recuperación de una clave inválida sin borrar todo Storage del origen.

## Reto desarrollado: búsqueda que conserva datos

Requisito: filtrar por título sin cambiar el plan. Aceptación: crear A y B, buscar solo A, limpiar búsqueda y conservar ambos con sus ids y estados. Un fallo controlado consiste en asignar la vista filtrada a tareas: la prueba debe detectar pérdida de B. Restaura el modelo completo y verifica otra vez. Cambiar colores no demostraría este comportamiento.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
