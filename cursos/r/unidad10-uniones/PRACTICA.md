# Práctica de la Unidad 10

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Verificar y unir el catálogo

Lee grupos.csv y comprueba que grupo no falte ni se repita. Une modalidad a la encuesta por grupo con relación muchos a uno. Predice cuántas filas debe devolver.

**Pista:** Dos personas de A pueden encontrar la misma fila de catálogo sin duplicarlo.

## Paso 2. Detectar multiplicación

Comprueba filas, IDs en orden y modalidades ausentes. En una copia del catálogo repite A e intenta la misma unión. Registra el rechazo y su razón.

**Pista:** No retires relationship para hacer desaparecer una comprobación incumplida.

## Paso 3. Investigar una clave desconocida

Introduce C en la primera fila de una copia de encuesta. Compara anti_join, inner_join y left_join. Identifica la fila que cada operación conserva u omite.

**Pista:** Esta copia es un escenario de auditoría, no una encuesta válida bajo el diccionario A/B.

## Reto de transferencia. Invertir el catálogo

Invierte sus dos filas y vuelve a unir con la encuesta original. Compara ID y modalidad con la primera unión.

**Pista:** La correspondencia se debe a la clave, no al lugar que ocupa en el archivo.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2010%20%28Unir%20tablas%20sin%20perder%20el%20control%20de%20las%20filas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
