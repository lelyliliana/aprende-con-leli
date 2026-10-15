# Unidad 02. Diseño responsivo con CSS

**[Construcción paso a paso: Añadir CSS sin cambiar el problema ni el documento](DESARROLLO.md)**. Compara versiones ejecutables, sigue el recorrido y después resuelve los ejercicios.

[Volver al índice](../README.md)

## Objetivos

Diseñar una interfaz legible que se adapte al ancho disponible.

## Explicación y práctica guiada

Abre estilos.css del laboratorio. Primero observa cómo los selectores aplican estilos a contenedor, tarjeta, acciones y lista. La regla global box-sizing ayuda a interpretar el tamaño de las cajas; el contenedor limita el ancho de lectura y utiliza espacio lateral.

Si no conoces la cascada o el modelo de caja, consulta [cascada](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad09-css-cascada/README.md) y [box model](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad11-box-model/README.md). Para trabajar la fila de entrada y botón, repasa [Flexbox](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad16-flexbox/README.md).

En una pantalla amplia, acciones organiza campo y botón en fila. La media query de 500 px los coloca en columna cuando falta espacio. No necesitas diseñar una página distinta por dispositivo: el contenido puede reorganizarse según el espacio disponible.

Modifica una propiedad a la vez y predice el resultado. Por ejemplo, cambia el gap de acciones, recarga y describe qué distancia cambió. El texto largo de una tarea usa overflow-wrap para que el contenido no se salga de su fila.

El foco visible señala dónde actuará el teclado. No elimines el outline sin ofrecer una alternativa legible. Los estados completados incluyen texto y control marcado; el color y el tachado acompañan la información.

Abre las herramientas de desarrollo y revisa el elemento calculado si una regla no funciona. Una propiedad puede quedar reemplazada por otra regla o afectar otro elemento. Para profundizar, usa [DevTools](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad27-devtools/README.md).

## Ejercicios

1. Cambia el espacio de la fila de acciones y explica qué selector lo controla.
2. Reduce la ventana y comprueba la reorganización de controles. Registra cualquier desbordamiento.
3. Recorre la etapa JavaScript con Tab y conserva un foco visible; no borres estilos para ocultar una dificultad.

## Reto

Crea una paleta propia y adapta una tarea con un título largo, manteniendo legibilidad y acceso por teclado.

## Errores frecuentes

Fijar anchos que desbordan; elegir colores sin comprobar lectura; confundir el diseño de la tarjeta con la estructura de datos.

## Comprobación para avanzar

Puedes localizar la regla que cambia un elemento y comprobar diseño ancho y estrecho en tu navegador.

## Continuar

- [Unidad anterior](../unidad01-html/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad03-javascript/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Dise%C3%B1o%20responsivo%20con%20CSS%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad02-css%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
