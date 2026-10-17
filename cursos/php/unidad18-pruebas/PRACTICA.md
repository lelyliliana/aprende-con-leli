# Práctica 18. Pruebas automatizadas y casos límite

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Comprobar resultados, fallos y persistencia con evidencias reproducibles.

## Hazlo en tres pasos

1. Modifica una copia de total para que sume y observa el fallo.
2. Agrega una comprobación para un solo producto.
3. Reto: comprueba resultados para cantidades 0, 1 y 3 en una tabla de casos.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Tabla:** diseña cinco entradas de título que cubran límites y tipo, indicando qué diferencia detecta cada una.
2. **Mutación:** sigue el laboratorio y demuestra un fallo al excluir el cupo 100; restaura después la función correcta.
3. **Persistencia:** crea una base temporal, inserta, cierra la conexión y abre otra; comprueba la fila por ID.
4. **Niveles:** clasifica verificar formato de fecha, comprobar CHECK SQL y comprobar 403 sin token como pruebas de regla, integración o HTTP.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [18-pruebas](../laboratorios/18-pruebas/README.md) y conserva la evidencia indicada allí.
