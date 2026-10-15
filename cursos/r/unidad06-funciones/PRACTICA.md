# Práctica de la Unidad 06

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Construir validar_horas por etapas

Escribe una función que admita una única cantidad numérica, conocida y finita entre 0 y 40. Revisa tipo antes de longitud y contenido. Devuelve el valor aceptado y usa mensajes para los rechazos.

**Pista:** Comienza con una condición por if; no compactes todas antes de comprender el orden.

## Paso 2. Probar límites y rechazos

Acepta 0 y 40. Prueba-1, 41, NA, "5" y c(1, 2). Registra qué regla incumple cada entrada y comprueba que la llamada termina con error.

**Pista:** tryCatch permite observar un rechazo previsto sin detener todas las pruebas.

## Paso 3. Reconstruir una media con ciclo

Recorre 3, NA, 5, 7 y registra por vuelta suma y n_observados. Compara el resultado con mean. Añade un rechazo cuando ningún valor sea observado.

**Pista:** Inicializa acumuladores antes del for y actualiza ambos dentro del caso observado.

## Reto de transferencia. Reutilizar una validación

Construye minutos_validos(horas) que primero llame validar_horas y después convierta a minutos. Comprueba 1.5 y rechaza Inf.

**Pista:** Validar y convertir son responsabilidades que puedes conectar sin duplicar las reglas.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2006%20%28Funciones%2C%20decisiones%20y%20repetici%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
