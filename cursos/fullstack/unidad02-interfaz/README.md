# Unidad 02. Interfaz y recorrido del usuario

[Volver al índice](../README.md)

## Objetivos

- Diseñar una interfaz que facilite un flujo concreto.
- Reconocer estados visibles y decisiones de accesibilidad.
- Traducir el contrato a campos y acciones comprensibles.

## Antes de comenzar

Debes comprender el contrato de productos. Si aún no puedes construir un formulario HTML, repasa [formularios](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad07-formularios/README.md). Para adaptar el diseño a pantallas pequeñas, consulta [diseño responsivo](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad19-responsive/README.md) solo cuando lo necesites.

## 1. Empezar por el usuario

Una persona que gestiona productos necesita saber qué puede hacer, si la operación terminó y cómo corregir un fallo. No necesita conocer nombres de DTO, migraciones o propiedades de configuración para usar el formulario.

Antes de conectar una API, dibuja el recorrido: abrir catálogo, encontrar un producto, crear o editar, observar la confirmación. Mantén un lugar estable para errores y evita borrar lo escrito cuando el servidor lo rechaza.

## 2. Del contrato al formulario

| Dato | Control y decisión |
|---|---|
| sku | Texto, código único, mayúsculas/números/guion |
| nombre | Texto obligatorio con límite de longitud |
| precio | Número positivo con dos decimales |
| categoriaId | Selección de opciones recibidas de la API |
| id y version | Estado del cliente obtenido del servidor; no campos que la persona inventa |

Un input de tipo number produce su value como cadena en JavaScript. El cliente debe decidir cómo construir el cuerpo numérico. Un select también devuelve una cadena: categoría “1” no es todavía un número.

## 3. Práctica guiada sobre un ejemplo real

Completa la [preparación del laboratorio](../laboratorio/README.md#paso-1-comprobar-herramientas) y abre `http://127.0.0.1:5173/?etapa=2`. Antes de crear un producto, recorre sus controles con Tab.

Abre [Creacion.jsx](../laboratorio/src/etapas/Creacion.jsx). Localiza cada pareja label/control y el atributo htmlFor. Cambia un texto de ayuda en tu copia y comprueba el resultado en el navegador. No cambies todavía nombres de campos del contrato.

Los estados de carga y guardado deshabilitan el formulario para impedir enviar antes de tener categorías o duplicar una petición pendiente. Un botón deshabilitado debe acompañarse de información visible: la persona necesita saber si se está cargando o guardando.

## 4. Vacío, carga y error son distintos

“Todavía no llegaron los productos” no significa “no existen productos”. Mostrar la lista vacía mientras la API responde puede confundir. En el ejemplo de consulta, primero aparece carga; después datos, vacío o error con reintento.

Un fallo de escritura conserva el formulario. Una creación correcta puede limpiarlo porque existe confirmación del servidor. Una pérdida de conexión no permite afirmar automáticamente que el servidor no guardó nada.

## Ejercicios

1. Identifica un control que necesite texto de ayuda. Redacta la ayuda para una persona que no conoce nombres de variables.
2. Modifica el título y los textos del formulario en tu copia sin cambiar el contrato. Comprueba que sus labels siguen asociados a los controles.
3. Escribe qué debe ver el usuario en carga, lista vacía, entrada inválida y creación correcta. Define también si conserva o limpia el formulario.

## Reto

Diseña una maqueta para un catálogo de libros con un formulario y una lista. Recorre el flujo con teclado y comprueba el diseño en una ventana estrecha. Documenta dos decisiones que mejoren comprensión o acceso.

## Errores frecuentes

- Usar placeholder como única etiqueta: desaparece al escribir y no reemplaza label.
- Comunicar fallos solo con color: incluye un mensaje legible.
- Limpiar el formulario antes de conocer la respuesta: se pierde la propuesta.
- Deshabilitar acciones sin explicar por qué: muestra el estado pendiente.

## Comprobación para avanzar

Puedes justificar campos y mensajes, recorrer controles con teclado y distinguir los cuatro estados de consulta. La revisión visual manual forma parte de tu práctica, además de las pruebas automáticas.

## Continuar

- [Unidad anterior: Comunicación HTTP y contrato](../unidad01-http/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: React conectado a una API](../unidad03-consulta/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Interfaz%20y%20recorrido%20del%20usuario%20del%20curso%20Desarrollo%20Full%20Stack%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffullstack%2Funidad02-interfaz%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
