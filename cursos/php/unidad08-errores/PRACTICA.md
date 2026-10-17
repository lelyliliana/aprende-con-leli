# Práctica 08. Errores, excepciones y depuración

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Distinguir errores de sintaxis, fallos esperados y errores de programación.

## Hazlo en tres pasos

1. Introduce un error de sintaxis en una copia y usa php -l.
2. Prueba subtotal con cero y con un negativo.
3. Reto: crea una función para dividir que rechace divisor cero.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Clasificación:** reúne un ejemplo de sintaxis inválida, uno de excepción de dominio y uno de cálculo equivocado sin excepción.
2. **Propagación:** modifica el tercer ejemplo para distinguir JsonException e InvalidArgumentException con mensajes distintos.
3. **Limpieza:** crea un temporal, lanza una excepción después de escribir y demuestra que finally lo elimina.
4. **Regresión:** conserva una entrada que reveló un error y escribe una comprobación que falle si vuelves a introducirlo.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».
