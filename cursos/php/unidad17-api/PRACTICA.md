# Práctica 17. APIs JSON y contratos HTTP

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Exponer datos estructurados y distinguir estados de respuesta.

## Hazlo en tres pasos

1. Describe una respuesta 401 y otra 404.
2. Prueba un JSON mal formado y uno válido con estructura incorrecta.
3. Reto: genera un error JSON con un código estable y un mensaje para título ausente.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Contrato:** completa el laboratorio JSON y anota método, ruta, estado y cuerpo para cada caso de su tabla.
2. **Forma:** filtra una lista dejando solo la segunda fila y comprueba que la respuesta siga utilizando un arreglo JSON.
3. **Errores:** distingue JSON mal formado, lista donde se exige objeto y objeto con cupo cero. Explica por qué son comprobaciones diferentes.
4. **Cliente:** diseña cómo mostrarías 200 con lista vacía, 401 y 500 en una interfaz; evita mostrar «sin talleres» ante un fallo del servidor.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [17-api](../laboratorios/17-api/README.md) y conserva la evidencia indicada allí.
