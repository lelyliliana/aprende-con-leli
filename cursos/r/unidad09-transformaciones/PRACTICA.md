# Práctica de la Unidad 09

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Filtrar y conservar entrada

Filtra puntajes>=80 de la encuesta y ordena por ID. Comprueba condición, identidad y que el original mantiene 36 filas.

**Pista:** Asigna el resultado a otro nombre.

## Paso 2. Contrastar una segunda implementación

Obtén los mismos IDs con selección de R base. Ordena ambas salidas y compara. Explica qué propiedad investigas sin copiar el resultado del primer filtro.

**Pista:** La misma condición sobre la misma entrada debería seleccionar las mismas identidades.

## Paso 3. Resumir y estudiar un caso sin horas

Genera n, n_horas y media por grupo. En una copia deja todas las horas de A como NA y repite. Comprueba n_horas, media y agrupación residual.

**Pista:** El resumen del caso vacío debe comunicar ausencia de información, no una media cero.

## Reto de transferencia. Transformar unidades conservando filas

Añade minutos_semana a partir de horas. Comprueba el tamaño, las ausencias y la igualdad de conversión solo donde hay cantidades conocidas.

**Pista:** mutate conserva personas; multiplicar NA no crea una medición conocida.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2009%20%28Transformar%20y%20resumir%20con%20dplyr%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
