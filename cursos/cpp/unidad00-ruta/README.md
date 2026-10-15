# Unidad 00. Preguntas, algoritmos y ruta de aprendizaje

[Índice](../README.md) · [Siguiente](../unidad01-entorno/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Definir una entrada.
- Calcular y explicar.
- Definir rechazos.

No necesitas otro lenguaje. Comienza con una pregunta, cuentas pequeñas y archivos de texto.

## Una pregunta que termina en un programa

Imagina un inventario con código de material, cantidad y precio por unidad. Antes de elegir una instrucción, decide qué necesitas: leer registros, rechazar cantidades imposibles, calcular subtotales y producir un reporte ordenado. Ese recorrido es un algoritmo cuando sus pasos y decisiones están suficientemente definidos para ejecutarlos.

### Entrada, proceso y salida

Para SENSOR, cantidad 2 y precio 1500 centavos, el subtotal es 3000 centavos. La entrada no es el resultado y una etiqueta no es una cantidad. Un código "007" identifica, por lo que debe conservar sus ceros. Una cantidad 0 puede indicar existencia agotada; una celda vacía no informa lo mismo. El proyecto exigirá cantidades conocidas y declarará su dominio.

| Pieza | Ejemplo | Pregunta de revisión |
|---|---|---|
| Entrada | SENSOR; 2; 1500 | ¿Qué representa cada campo? |
| Proceso | 2×1500 | ¿Qué unidad produce la operación? |
| Salida | SENSOR; 3000 | ¿Cómo podrá comprobarla otra persona? |

### Especificar antes de implementar

«Calcular un total» deja decisiones abiertas: ¿qué pasa con un ID repetido, texto donde esperabas número, un archivo vacío o un resultado fuera de representación? Una especificación pequeña declara qué acepta, qué devuelve y qué rechaza. Las pruebas permiten contrastar casos concretos contra esa intención; pasar una prueba no demuestra corrección para toda entrada posible.

### Qué aporta C++ y qué tendrás que aprender

C++ es un lenguaje compilado con tipos, control directo de recursos y una biblioteca estándar. Escribirás código fuente y un compilador lo transformará para la plataforma elegida. Un ejecutable de Windows no se convierte automáticamente en uno de macOS: la portabilidad del código se comprueba compilándolo en cada entorno.

No necesitas conocer C ni otro lenguaje. Sí necesitas manejar carpetas, editar archivos de texto y comprender cuentas aritméticas básicas. Comenzaremos con mensajes, variables y decisiones. Después añadiremos funciones, contenedores y objetos. La vida útil y la propiedad de recursos se explicarán antes de usarlas en diseños más grandes.

### Alcance de esta ruta

Usamos C++20 como base de compilación. El curso recorre fundamentos hasta nivel intermedio, con introducciones a conceptos genéricos y coste de algoritmos. El proyecto es una aplicación de consola con archivos locales; no es un sistema comercial multiusuario. Interfaces gráficas, motores de juegos, programación de microcontroladores, concurrencia y metaprogramación avanzada requieren rutas adicionales.

Los datos son ficticios y los precios expresan una unidad monetaria de práctica. No se incluyen nombres de estudiantes ni marcas institucionales. El objetivo es que puedas explicar y reconstruir una solución, sin depender de una asesoría para obtener el programa que falta.

### Método de estudio

Lee la pregunta y predice un resultado pequeño. Ejecuta un ejemplo completo y sigue sus valores. Cambia una sola decisión y explica lo observado. Resuelve la práctica antes de consultar las soluciones. Si un error aparece, registra mensaje, entrada y paso donde ocurrió; cambiar líneas al azar impide aprender qué lo causó.

## Experimenta

Con dos registros A; 2; 100 y B; 3; 200 calcula subtotales y total. Luego cambia la cantidad de B por vacío: escribe qué información falta en vez de sustituirla por cero.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Confundir filas con productos distintos | Revisa la clave código y la política de repetición. |
| Elegir una herramienta antes de la pregunta | Especifica entrada, transformación y salida. |
| Considerar un caso exitoso como validación universal | Añade límites y casos que deban rechazarse. |

## Autoevaluación

1. ¿Qué distingue entrada de salida?
2. ¿Qué no demuestra una sola prueba?
3. ¿Necesitas aprender C antes?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Índice](../README.md) · [Siguiente](../unidad01-entorno/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2000%20%28Preguntas%2C%20algoritmos%20y%20ruta%20de%20aprendizaje%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
