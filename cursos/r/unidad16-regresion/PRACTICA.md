# Práctica de la Unidad 16

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Interpretar y predecir

Construye el caso y=2+3*horas+residuos con horas 0:5 y desviaciones 1, -1, 0, 0, -1, 1. Ajusta lm y reconstruye la predicción en 2.5 horas con su ecuación.

**Pista:** Extrae coeficientes por nombre y separa intercepto de pendiente.

## Paso 2. Cambiar unidad

Convierte horas a minutos, reajusta y predice en 150 minutos. Contrasta con 2.5 horas y explica el cambio de pendiente.

**Pista:** La misma entrada física necesita la unidad del modelo que recibe predict.

## Paso 3. Abrir diagnóstico y revisar rango

Genera un gráfico de residuos, ábrelo y describe qué puedes observar sin certificar supuestos. Identifica rango de horas y clasifica 20 como interpolación oextrapolación.

**Pista:** Una función puede devolver un número fuera del soporte observado.

## Reto de transferencia. Reconstruir los observados

Comprueba para cada fila que ajustado+residuo reproduce el observado dentro de tolerancia. Explica por qué tener residuos no nulos no implica que deban borrarse esas filas.

**Pista:** Usa fitted y residuals con el mismo modelo.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2016%20%28Correlaci%C3%B3n%20y%20regresi%C3%B3n%20lineal%20introductoria%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
