# Soluciones desarrolladas de la Unidad 04

[Unidad](README.md) · [Construcción paso a paso](DESARROLLO.md)

Intenta primero los ejercicios. Compara el razonamiento y las condiciones, además del resultado visible.

## Ejercicio 1. Recargar

En paso 4 se guarda un documento versionado tras la acción. Si guardar tuvo éxito, recargar lo vuelve a leer. El paso 3 no escribe: recargarlo empieza vacío por diseño. Compara ambos bajo el mismo origen.

## Ejercicio 2. JavaScript a React

Para la construcción, crea en 04-guardado y abre 05-react después de cerrar la otra página. Para la aplicación principal, utiliza javascript.html y react.html. Cada pareja comparte una clave propia; no se importan automáticamente datos entre ambas prácticas.

## Ejercicio 3. Otro puerto

El origen incluye protocolo, host y puerto. 5174 y 4174 pertenecen a orígenes distintos. Ver una lista vacía en preview no demuestra que se borraron los datos de dev. Vuelve al origen original para contrastarlo.

## Reto desarrollado: lectura inválida

Copia el valor de leli.frontend.construccion.v1. Sustitúyelo por texto roto y recarga paso 4: se informa el error, el botón queda deshabilitado y el texto original roto sigue ahí para analizarlo. Restaura la copia válida y recarga. Repite con un documento que contenga ids duplicados: JSON válido no garantiza un esquema aceptable.

## Una escritura que falla

Con Storage bloqueado o sin espacio, la UI puede mostrar la tarea nueva y un aviso de que no se guardó. No afirmes respaldo remoto ni cierres la sesión suponiendo que el mensaje de agregado demuestra persistencia. El proyecto no dispone de cuenta o sincronización entre equipos.

[Volver al desarrollo](DESARROLLO.md) · [Volver a la unidad](README.md)
