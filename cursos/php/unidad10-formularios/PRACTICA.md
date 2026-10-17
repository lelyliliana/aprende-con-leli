# Práctica 10. Formularios y validación en el servidor

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Recibir datos, mostrar errores y preservar entradas válidas.

## Hazlo en tres pasos

1. Prueba títulos de 2, 3, 100 y 101 caracteres.
2. Prueba cupos ausente, cero, 1, 100, 101 y un arreglo.
3. Reto: valida un correo enviado como cadena sin llamar a filter_var sobre un arreglo.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Petición real:** completa el laboratorio 10-formularios y registra una respuesta 200 y otra 422.
2. **Contrato:** envía un input con id pero sin name y compara lo recibido con otro que tenga ambos atributos.
3. **Ataque al supuesto:** envía titulo[] y cupo[] desde una petición de prueba; debe haber un rechazo controlado, sin TypeError ni guardado.
4. **Experiencia:** conserva un título válido cuando el cupo falle, asocia el error al campo y explica por qué no debe borrarse todo el formulario.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [10-formularios](../laboratorios/10-formularios/README.md) y conserva la evidencia indicada allí.
