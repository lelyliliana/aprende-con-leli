# Unidad 01. Estructura y accesibilidad con HTML

[Volver al índice](../README.md)

## Objetivos

Construir una estructura comprensible y asociar controles con etiquetas.

## Explicación y práctica guiada

Abre index.html del laboratorio. La primera versión define navegación, encabezado, contenido principal, una sección del planificador y pie de página. HTML expresa el significado de esas partes; no hace falta agregar clases a todo para que exista una estructura.

Consulta [HTML semántico](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad05-semantica/README.md) y [formularios](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad07-formularios/README.md) cuando necesites comprender una etiqueta o el propósito de un control.

En tu copia local, modifica el título y agrega una explicación propia del plan. Revisa el par label/input: el for del label debe coincidir con el id del campo. El placeholder es un ejemplo temporal y no sustituye la etiqueta.

La página usa una lista para representar tareas. Todavía son datos de ejemplo; los botones no prometen guardar nada en esta etapa. Un enlace navega entre etapas y un botón actúa sobre el plan: no intercambies esos elementos solo porque puedes darles el mismo estilo.

Las etiquetas y atributos de idioma ayudan a interpretar el contenido. Una persona debe poder reconocer títulos, regiones y controles sin depender del color. En la etapa interactiva recorrerás los controles con Tab; los controles disabled de la maqueta no reciben foco.

El contenido de tareas provendrá después de lo escrito por el usuario. En JavaScript se representará con textContent; React escapará el texto del título. Nunca necesitarás tratar un título como HTML para mostrarlo.

## Ejercicios

1. Modifica h1 y el texto introductorio en tu copia. Recarga y comprueba el cambio.
2. Agrega un texto de ayuda y relaciónalo con el campo mediante aria-describedby.
3. Identifica un enlace y un botón; explica qué debería ocurrir al activarlos.

## Reto

Adapta la maqueta a un plan de lectura, conservando regiones, títulos y etiquetas de controles.

## Errores frecuentes

Usar placeholder como única etiqueta; repetir IDs; elegir una etiqueta solo por el tamaño visual que produce.

## Comprobación para avanzar

Puedes explicar la estructura del documento y demostrar una asociación válida entre etiqueta y control.

## Continuar

- [Unidad anterior](../unidad00-entorno/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad02-css/README.md)
