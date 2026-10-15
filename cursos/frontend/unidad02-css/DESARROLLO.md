# Añadir CSS sin cambiar el problema ni el documento

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Compara las dos primeras versiones

Abre 01-html y 02-css una después de otra. El formulario, la tarea ficticia y los controles deshabilitados siguen presentes. El segundo documento enlaza [base.css](../laboratorio/pasos/base.css). Puedes comparar ambos archivos: la diferencia que interesa es la presentación, no una lógica nueva.

El navegador carga HTML, encuentra el link de stylesheet y solicita CSS. Si el archivo no carga, comprueba la ruta desde el documento. Un selector correcto dentro de una hoja que nunca llegó no puede modificar la página.

## 2. Construye la caja antes de decorar

La regla global border-box incluye padding y borde dentro del ancho declarado. `.contenedor` usa el menor valor entre 54rem y 92% del ancho disponible. El margen automático reparte el espacio lateral sobrante. Así no hace falta fijar una anchura distinta para cada teléfono.

En una ventana de 375 px, 92% son 345 px. La tarjeta todavía usa padding y borde dentro de su caja. El ancho de contenido no es igual al de la ventana. El tamaño rem depende del tamaño de fuente raíz; no lo conviertas a píxeles sin indicar ese supuesto.

Primero verifica ancho, márgenes y espacio interior. Después añade borde, fondo y esquinas. Esa secuencia permite distinguir una caja mal dimensionada de una decoración que simplemente no te gusta.

## 3. Ordena acciones con una regla concreta

La clase acciones usa display:flex y gap. En ancho suficiente sitúa campo y botón en fila. La media query de 500 px cambia flex-direction a column. El mismo HTML conserva orden de lectura; cambia cómo se distribuye el espacio.

```css
.acciones { display: flex; gap: .6rem; }
@media (max-width: 500px) {
  .acciones { flex-direction: column; }
}
```

No confundas ese umbral con la detección de un modelo de teléfono. Responde al ancho que tiene el viewport. Comprueba también tamaños intermedios, no solo dos capturas.

## 4. Permite que el texto tenga una caja real

Un título largo ocupa espacio dentro de una fila flexible. min-width:0 permite encoger un elemento que de otro modo puede conservar un mínimo intrínseco grande. overflow-wrap:anywhere ofrece oportunidades de partir texto difícil. Son decisiones complementarias; ninguna justifica esconder contenido importante con overflow:hidden.

La fila también reserva espacio al botón mediante flex-shrink:0. Si todo el ancho se entregara al texto, el botón podría quedar comprimido. En pantallas estrechas comprueba el conjunto, no un elemento aislado.

## 5. Haz visible el uso por teclado

focus-visible dibuja un contorno separado del elemento. Tab mueve el foco y debe poder reconocerse. No elimines outline solo porque aparece en una captura. El enlace de salto se mantiene fuera de la vista hasta recibir foco y entonces permite ir al contenido.

Los controles disabled de los pasos 1/2 no reciben el recorrido normal. Para probar formulario y botones usa el paso 3 cuando esté operativo. Un título tachado acompaña al checkbox marcado; el color no es la única información del estado.

## 6. Diagnostica una regla en DevTools

Selecciona el elemento que quieres cambiar, revisa estilos aplicados y valor calculado. Un gap pertenece al contenedor flexible; no crea por sí mismo margen exterior alrededor de la tarjeta. Si cambias `.tarjeta` esperando separar los hijos del formulario, modificaste otro nivel de la estructura.

Haz un cambio, predice y observa. Si una propiedad aparece tachada, busca qué regla la reemplaza. Si la propiedad está activa pero no cambia nada, pregunta si el elemento participa en el tipo de distribución al que se aplica.

## 7. Adapta con criterios verificables

Una paleta propia debe conservar contraste suficiente en texto, enlaces, foco, error y controles. Una captura agradable no demuestra ese contraste. Comprueba lectura, teclado y redistribución; incluye una tarea con muchas letras sin espacios cuando pruebes el paso interactivo.

Antes de avanzar explica por qué la misma tarea sigue siendo ficticia aunque la tarjeta tenga mejor presentación. CSS no creó un arreglo ni habilitó guardar.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Dise%C3%B1o%20responsivo%20con%20CSS%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad02-css%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
