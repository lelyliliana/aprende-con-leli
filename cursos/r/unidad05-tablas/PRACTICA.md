# Práctica de la Unidad 05

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Conservar dos personas con el mismo valor

Crea IDs A, B, C y valores 5, 5, 8. Selecciona todas las filas de valor 5 y conserva sus IDs. Explica por qué no eliminas una.

**Pista:** La identidad está en id, no en que valor sea distinto.

## Paso 2. Conservar forma de tabla

Selecciona valor con drop=FALSE. Comprueba clase, filas y columnas. Contrasta con d[["valor"]].

**Pista:** Pregunta tanto por el contenido como por su estructura.

## Paso 3. Extraer una lista y definir clave

Compara lista["id"] y lista[["id"]] en una lista con texto y mediciones. Construye IDs A, A, B, B con momentos 1, 2, 1, 2 y decide si hay claves compuestas repetidas.

**Pista:** El contenedor de una pieza y su contenido pueden tener clases diferentes.

## Reto de transferencia. Duplicar una medición

Agrega al final una copia de A/momento 1. Identifica la posición de la primera repetición de ID/momento y explica por qué no basta revisar ID solo.

**Pista:** anyDuplicated devuelve la posición de una repetición encontrada o0 si no existe.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2005%20%28Listas%20y%20tablas%20de%20datos%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
