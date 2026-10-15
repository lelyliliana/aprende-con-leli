# Soluciones desarrolladas de la Unidad 06

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Tres escenarios

Normal devuelve 200 con dos recursos; vacío devuelve 200 con []; error devuelve 503. El cliente presenta lista, mensaje de ausencia y error con reintento, respectivamente. Registra respuesta y pantalla por separado.

## Ejercicio 2. response.ok

Fetch puede resolver con una Response aunque el HTTP sea 503. La referencia comprueba ok y lanza un error antes de usar ese cuerpo como colección. El catch de un fallo de red no sustituye esa condición.

## Ejercicio 3. Orden de respuestas

Controla los tiempos para una observación útil. Inicia una consulta, cambia modo y retrasa la primera más que la segunda. La elección anterior no debe reemplazar el resultado actual. La función de limpieza y la comprobación de signal actúan sobre ese recorrido.

## Reto desarrollado: responsabilidades

Recursos recibe una función alAgregar(nombre). App calcula una tarea nueva con agregar y se encarga de setTareas, guardar y mensajes. Añade una acción explícita; no conviertas todos los recursos automáticamente en tareas al ejecutar el efecto. Prueba una incorporación válida y un rechazo por límite de cien, y conserva las tareas previas ante el rechazo.

## Reintento y recuperación

Reintentar con modo error puede volver a producir 503. Eso no significa que el botón no actuó. Comprueba otra petición y después selecciona normal para demostrar recuperación. No borres el plan local al tratar un fallo de recursos.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
