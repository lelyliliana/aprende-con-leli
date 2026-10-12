# Unidad 05. Del DOM a componentes React

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
