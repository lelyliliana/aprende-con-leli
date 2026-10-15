# Práctica de la Unidad 07

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Inspeccionar el archivo completo

Lee encuesta.csv con leer_encuesta. Registra nombres, dimensiones, tipos y horas faltantes. Contrasta cada propiedad con el diccionario.

**Pista:** nrow no detecta por sí mismo que un identificador haya perdido representación.

## Paso 2. Exportar y releer una copia

Usa una ruta temporal, row.names=FALSE, na="" y UTF-8. Lee la copia con las mismas reglas y compara contenido. Explica qué pasaría con un ID "007" convertido a número.

**Pista:** Conserva nombres, tipos y ausencias; elimina solo tu archivo temporal al terminar.

## Paso 3. Auditar una conversión fallida

Crea un CSV temporal con encabezado valor y entradas 3 y texto. Declara columna numérica en readr y consulta problems. Identifica el contenido que originó el NA.

**Pista:** La solución captura la advertencia prevista y después comprueba la incidencia; no borra la evidencia.

## Reto de transferencia. Elegir una hoja Excel

Localiza datasets.xlsx incluido en readxl. Consulta sus hojas, exige que exista mtcars y lee cinco filas. Comprueba dimensiones antes de usar los datos.

**Pista:** No supongas que todos los libros tienen las mismas hojas o una única tabla.

## Evidencia de cierre

Entrega las respuestas de los tres pasos y del reto. Incluye entrada, predicción, código o cuenta, salida e interpretación. Explica un caso que falle y qué decisión tomarías. No basta una captura de la ejecución.

## Comprobación antes de avanzar

- [ ] Puedo explicar cada transformación sin leer la solución.
- [ ] Contrasté la salida con una predicción o una cuenta independiente.
- [ ] Distinguí datos, resultados y límites de la interpretación.
- [ ] Respondí la autoevaluación de la lección.

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2007%20%28Importaci%C3%B3n%20y%20exportaci%C3%B3n%20de%20CSV%20y%20Excel%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
