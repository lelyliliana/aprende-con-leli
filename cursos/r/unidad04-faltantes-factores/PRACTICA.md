# Práctica de la Unidad 04

[Lección](README.md) · [Soluciones](SOLUCIONES.md)

Trabaja un paso cada vez. Guarda una predicción antes de ejecutar y comprueba su resultado antes de continuar. Las pistas orientan; la solución completa está en un archivo separado.

## Paso 1. Contar antes de promediar

Para 0, NA, 20 calcula media observada, cantidad total y cantidad conocida. Conserva el cero y explica por qué entra en el cálculo.

**Pista:** Utiliza is.na y su negación para contar observados.

## Paso 2. Investigar todo faltante

Calcula mean(c(NA_real_, NA_real_), na.rm=TRUE). Comprueba is.nan e is.na y explica por qué no es una media cero.

**Pista:** Retirar ambos faltantes deja un vector sin observaciones.

## Paso 3. Detectar etiqueta desconocida

Usa baja, media, alta, desconocida. Conserva los textos, identifica valores fuera del diccionario y construye un factor ordenado con los tres niveles admitidos.

**Pista:** Contrasta la máscara de desconocidos con la de faltantes del factor.

## Reto de transferencia. Fechas y etiquetas numéricas

Calcula días entre 15/01/2026 y 18/01/2026 con formato explícito. Con un factor de etiquetas 10, 20 compara as.numeric directo y conversión pasando por as.character.

**Pista:** Los códigos internos del factor no son necesariamente las cantidades de sus etiquetas.

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

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2004%20%28Datos%20faltantes%2C%20factores%20y%20fechas%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
