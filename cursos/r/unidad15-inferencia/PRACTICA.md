# Práctica de la Unidad 15

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Interpretar una media y un intervalo

Para 8, 9, 10, 11, 12 registra n, media e IC 95%. Explica el parámetro del intervalo y por qué no describe al 95% de individuos. Interpreta p=1 sin afirmar igualdad demostrada.

**Pista:** Separa dato individual, estimación y procedimiento de cobertura.

## Paso 2. Completar la salida de Welch

Usa x=12, 13, 11, 16, 14 ey=8, 9, 10, 7, 12, 8. Registra dirección x-y, tamaños, diferencia e intervalo. Explica qué supuesto de igualdad no requiere y qué condiciones siguen importando.

**Pista:** Guarda la respuesta de t.test y consulta conf.int; el mensaje del ejemplo no muestra todos los campos.

## Paso 3. Respetar los pares

Construye los seis pares de la solución con el archivo después en orden inverso. Une por ID, calcula diferencias y prueba paired=TRUE. Explica por qué no son 12 unidades independientes.

**Pista:** Valida una fila antes y después por persona antes de restar.

## Reto de transferencia. Reconstruir Welch

Calcula su error estándar como raíz de s_x²/n_x+s_y²/n_y. Usa los grados de libertad de Welch explicados en la solución y contrasta el intervalo manual con conf.int.

**Pista:** El reto extiende el cálculo de una media; no introduce una selección universal de pruebas.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2015%20%28Intervalos%2C%20contrastes%20y%20dise%C3%B1o%20de%20comparaci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
