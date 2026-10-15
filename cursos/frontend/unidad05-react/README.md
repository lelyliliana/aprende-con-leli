# Unidad 05. Del DOM a componentes React

**[Construcción paso a paso: Pasar a React conservando reglas y significado](DESARROLLO.md)**. Compara versiones ejecutables, sigue el recorrido y después resuelve los ejercicios.

[Volver al índice](../README.md)

## Objetivos

Representar el mismo proyecto con componentes y estado React.

## Explicación y práctica guiada

Abre react.html. El formulario y las operaciones resuelven el mismo problema que JavaScript; cambia quién coordina la representación. React toma el estado y calcula qué elementos presentar.

Consulta [componentes](https://github.com/lelyliliana/Curso-React/blob/main/unidad03-componentes/README.md), [estado](https://github.com/lelyliliana/Curso-React/blob/main/unidad07-usestate/README.md) y [formularios](https://github.com/lelyliliana/Curso-React/blob/main/unidad10-formularios/README.md) cuando necesites interpretar el ejemplo.

En App.jsx, el título del campo y el filtro son estados de interfaz. tareas contiene el modelo. aplicar recibe una transformación, genera nuevas tareas, informa un resultado y utiliza guardar. JSX representa la colección filtrada, con key basada en ID.

No debes manipular filas con document.querySelector para reflejar cada cambio. Modificas el estado y React representa. Las funciones de dominio y almacenamiento se mantienen: la migración no exige reescribir las reglas o perder la colección.

La lectura inicial está dentro de una función de inicialización de estado. Leer no escribe. No añadimos un efecto que guarde una colección vacía apenas se monta el componente: eso podría destruir datos que no pudimos interpretar.

Después de una acción, el foco vuelve al campo de entrada mediante una ref. La referencia dirige el foco a un elemento; no sustituye al estado de las tareas.

## Ejercicios

1. Identifica los estados de datos y los estados de interfaz en App.jsx.
2. Agrega en React una tarea, cambia a JavaScript después de cerrar React y comprueba la transferencia.
3. Añade un texto que muestre cuántas tareas están completas, derivándolo del arreglo actual.

## Reto

Extrae la representación de una tarea a un componente que reciba datos y callbacks. Conserva la lógica de dominio fuera del JSX.

## Errores frecuentes

Mutar directamente el arreglo; usar índices como key; duplicar reglas distintas en JavaScript y React; guardar datos vacíos antes de validar la lectura.

## Comprobación para avanzar

Puedes comparar el ciclo evento → datos → representación en ambas versiones sin explicar React como una base de datos.

## Continuar

- [Unidad anterior](../unidad04-persistencia/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad06-api/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Del%20DOM%20a%20componentes%20React%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad05-react%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
