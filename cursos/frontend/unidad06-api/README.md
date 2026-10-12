# Unidad 06. Consulta de datos y estados remotos

[Volver al índice](../README.md)

## Objetivos

Consultar una API y distinguir carga, vacío y error.

## Explicación y práctica guiada

La versión React añade Recursos.jsx con un endpoint local de práctica. Selecciona Con recursos, Sin recursos y Fallo del servidor. Antes de cada cambio, predice el estado visible y el HTTP que observarás.

La API devuelve datos ficticios para controlar escenarios sin depender de un servicio externo. El plugin de Vite ofrece /api/recursos durante dev y preview; no se convierte en un servicio público al copiar dist a un hosting.

Lee el efecto de Recursos.jsx: crea un controlador, marca carga, realiza fetch y comprueba response.ok. Una respuesta 503 debe generar error aunque fetch haya obtenido una respuesta HTTP. Una respuesta 200 con arreglo vacío es una consulta correcta sin datos.

El cliente valida la forma JSON para evitar mostrar un objeto inesperado como si fueran recursos. La cancelación impide que una respuesta de un modo anterior reemplace la consulta actual. El límite temporal evita una espera indefinida.

Para repasar promesas y peticiones usa [Fetch](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad20-fetch/README.md) y [datos remotos React](https://github.com/lelyliliana/Curso-React/blob/main/unidad14-datos-remotos/README.md). No necesitas crear ni contratar un backend para este experimento.

La colección de recursos y tu plan tienen responsabilidades diferentes. Consultar un recurso no lo guarda como tarea ni borra tu plan. Define una acción explícita si quieres añadir un recurso al plan en una ampliación.

## Ejercicios

1. Registra estado HTTP y mensaje visible para los tres modos.
2. Explica por qué 503 requiere comprobar response.ok y no depende únicamente de catch de red.
3. Cambia rápidamente de modo y comprueba que una consulta anterior no reemplaza a la actual.

## Reto

Diseña una acción para convertir un recurso en tarea. Reutiliza la validación del dominio y decide cómo presentar un rechazo antes de implementarla.

## Errores frecuentes

Tratar vacío como fallo; ignorar response.ok; usar no-cors para ocultar un bloqueo; afirmar que la API local viene incluida en el build estático.

## Comprobación para avanzar

Puedes explicar y recuperar carga, datos, vacío y error, y distinguir API de práctica y almacenamiento de tareas.

## Continuar

- [Unidad anterior](../unidad05-react/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad07-proyecto/README.md)
