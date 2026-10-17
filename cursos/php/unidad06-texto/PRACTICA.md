# Práctica 06. Texto, fechas y validación

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Normalizar entradas sin confundir validación, conversión y escape.

## Hazlo en tres pasos

1. Prueba una cadena vacía y otra con espacios.
2. Contrasta filter_var con "0", "5" y "abc".
3. Reto: acepta una cantidad entre 0 y 20 y explica por qué no basta convertir a int.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Fronteras:** diseña una tabla con entrada original, normalizada, validación y valor de dominio para un título y un cupo.
2. **Texto:** compara strlen y mb_strlen de Programación; explica qué mide cada resultado, sin declarar que una de las funciones está equivocada.
3. **Calendario:** prueba días bisiestos, mes 13, día cero y un formato sin ceros iniciales con el tercer ejemplo.
4. **Dominio:** amplía la regla de fecha para que el taller esté entre una fecha de referencia fija y 30 días después. Evita depender del día en que corras la prueba.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».
