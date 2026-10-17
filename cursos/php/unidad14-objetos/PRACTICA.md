# Práctica 14. Objetos, interfaces y composición

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Encapsular reglas y sustituir dependencias con contratos pequeños.

## Hazlo en tres pasos

1. Intenta construir un Taller con cupo cero y captura la excepción.
2. Explica qué dependencia recibiría un repositorio SQL.
3. Reto: implementa Contador con una lista recibida por constructor.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Modelo:** diseña un Taller que rechace título vacío y cupo fuera de 1 a 100 al construirse.
2. **Estado:** reproduce el tercer ejemplo y explica por qué la asignación no actúa igual que una copia de arreglo con enteros.
3. **Contrato:** define una interfaz que ofrezca solo contar talleres y crea implementaciones fija y en memoria con la misma promesa de retorno.
4. **Diseño:** justifica por qué un servicio que necesita PDO debe recibirlo o recibir un repositorio en vez de heredar de PDO.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».
