# Retos de comprensión

[Volver al laboratorio](../README.md)

## Reto 1. Seguir un dato

Crea un producto y registra la petición HTTP. Explica cómo el valor de precio pasa del input a JSON, a la entidad y de vuelta al catálogo. ¿Por qué se convierte con Number? ¿Quién impide un precio negativo si se evita el formulario?

## Reto 2. Leer una página

Cambia el tamaño a dos productos en src/api.js. Comprueba las páginas y el total. Explica por qué no puedes hacer productos.map directamente sobre el objeto completo de GET.

## Reto 3. Interpretar 204

Localiza la rama de request que evita leer un cuerpo cuando el estado es 204. Explica qué error introducirías si llamaras response.json sin comprobarlo. Ejecuta las pruebas antes y después de tu modificación y restaura el comportamiento correcto.

## Reto 4. Defender una actualización

Provoca el conflicto desde dos pestañas. Explica por qué el cliente no debe incrementar version por su cuenta ni reintentar PUT con la versión nueva automáticamente.

## Reto 5. Diseñar un cambio propio

Añade un indicador visual con el estado activo devuelto por la API, sin inventar un endpoint para modificarlo. Comprueba el texto y la accesibilidad. Para convertirlo en editable, describe primero qué contrato y pruebas necesitarías en el backend.

## Reto 6. Conservar datos

Usa H2 en archivo y demuestra con dos reinicios que un producto continúa guardado. Explica qué sucedería si iniciaras Java desde otra carpeta con la misma ruta relativa.

[Ver soluciones después de intentar](SOLUCIONES.md)
