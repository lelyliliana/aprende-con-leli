# Práctica 13. CRUD, búsqueda y paginación

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Aplicar altas, cambios y bajas usando identificadores estables.

## Hazlo en tres pasos

1. Explica qué cambia si omites WHERE en el ejemplo de actualización.
2. Calcula el inicio de páginas 1, 2 y 3 con tamaño 10.
3. Reto: elimina solo el taller con ID 1 y verifica el número de filas.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Matriz:** enumera datos, método, estado esperado y cambio de base para crear válido, editar inexistente, borrar inválido y consultar vacío.
2. **Navegación:** crea doce registros en el laboratorio CRUD, ve a la segunda página y aplica un filtro; explica cómo conservas o reinicias la página.
3. **Rechazo:** intenta editar un ID ausente y demuestra que no se crea una fila nueva ni cambia otra.
4. **Concurrencia:** dibuja dos ediciones del mismo taller y diseña una regla con columna version para detectar que el formulario quedó desactualizado.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [13-crud](../laboratorios/13-crud/README.md) y conserva la evidencia indicada allí.
