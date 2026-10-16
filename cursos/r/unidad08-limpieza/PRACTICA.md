# Práctica de la Unidad 08

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Clasificar las ocho filas

Lee encuesta_sucia.csv como texto y clasifica a mano cada fila: válida, equivalente repetida o inválida con motivo. Distingue ausencia de horas permitida y edad no convertible.

**Pista:** Usa una tabla con número de fila, ID y motivo antes de ejecutar limpiar_entrada.

## Paso 2. Contrastar auditoría y original

Ejecuta limpiar_entrada. Compara tu clasificación con incidencias y validas. Verifica el texto «7,5» original, el número 7.5 aceptado y las horas faltantes de S05.

**Pista:** La fila del archivo y la posición en la tabla de válidas no tienen por qué coincidir.

## Paso 3. Crear una contradicción en una copia

En un CSV temporal cambia a 81 el puntaje de la segunda aparición de S02. Predice el rechazo y comprueba su causa sin modificar la fuente original.

**Pista:** Si el mismo ID tiene dos respuestas incompatibles, conservar primero no resuelve la contradicción.

## Reto de transferencia. Separar tres situaciones

Convierte el vector de texto NA, "texto", "0". Construye una máscara de fallos de conversión y explica por qué solo debe marcar una posición.

**Pista:** Una ausencia original, una conversión fallida y un cero son casos diferentes.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2008%20%28Calidad%2C%20limpieza%20y%20trazabilidad%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
