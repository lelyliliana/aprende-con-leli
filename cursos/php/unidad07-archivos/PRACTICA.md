# Práctica 07. Archivos, CSV y JSON

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Leer y escribir datos con rutas y formatos controlados.

## Hazlo en tres pasos

1. Agrega una propiedad aula al objeto JSON.
2. Incluye una coma y comillas en un título CSV.
3. Reto: escribe y recupera un taller desde un archivo temporal; comprueba los retornos y elimina el archivo.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Formato:** explica qué forma JSON obtiene una lista después de borrar su posición central y cómo recuperar una lista consecutiva.
2. **Importación:** agrega una revisión de título no vacío a titulosDesdeJson y prueba una fila vacía, una válida y una sin la clave.
3. **CSV:** procesa un encabezado titulo,cupo y dos filas, una con coma dentro del título. Usa fgetcsv y cuenta columnas antes de convertir.
4. **Persistencia:** dibuja dos procesos que leen y escriben el mismo archivo; identifica en qué paso se pierde una actualización.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».
