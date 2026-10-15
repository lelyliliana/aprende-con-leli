# Unidad 00. Punto de entrada, preguntas y alcance

[Índice](../README.md) · [Siguiente](../unidad01-entorno/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones (después de intentar)](SOLUCIONES.md)

## Objetivos

- Reconocer qué aprenderás y qué conocimientos se necesitan.
- Distinguir registro, variable, población, muestra y pregunta de análisis.
- Elegir un recorrido inicial sin depender de Python.

## Clase guiada. Del archivo a una pregunta que se pueda responder

Imagina una hoja con cuatro columnas: ID, grupo, horas y puntaje. Antes de calcular, explica una fila completa: «P01 pertenece al grupo A, declaró dos horas semanales y obtuvo 70 puntos». Esa frase identifica la persona, las variables, las unidades y un resultado observado. Un número separado de ese contexto puede inducir una interpretación equivocada.

### 1. Identifica la unidad de observación

La unidad es aquello sobre lo que se registra una medición. En una encuesta de una sola aplicación puede ser una persona. Si se aplica antes y después, una fila puede representar una persona en un momento. Por eso preguntar «¿cuántas filas hay?» y «¿cuántas personas hay?» no siempre produce la misma respuesta.

| ID | Momento | Horas semanales |
|---|---|---|
| P01 | Antes | 2 |
| P01 | Después | 4 |
| P02 | Antes | 6 |

Hay tres mediciones y dos personas. La combinación ID y momento distingue las mediciones. Borrar la segunda fila solo porque vuelve a aparecer P01 destruiría una observación prevista. En cambio, dos filas P01/Antes necesitarían revisión. Una clave representa una decisión del estudio, no una instrucción para borrar repeticiones automáticamente.

### 2. Distingue variable, valor y unidad

«Horas semanales» es una variable; 2 es un valor; horas por semana es su unidad. Grupo es una categoría, no una cantidad que debas promediar. El ID identifica y no mide: calcular su media carece de sentido aunque esté compuesto por dígitos. Una celda vacía significa que falta información según la convención del archivo; no afirma que la cantidad sea cero.

### 3. Formula una pregunta descriptiva

«¿Cómo se distribuyen los puntajes por grupo en este archivo?» especifica una variable, una agrupación y un alcance. «¿La modalidad provoca mejores resultados?» introduce causalidad y necesita un diseño que esta tabla ficticia no proporciona. Aprender a ejecutar un contraste no resuelve esa diferencia.

Población es el conjunto sobre el que querrías conocer algo; muestra es el subconjunto observado mediante un mecanismo de selección. El archivo docente es construido, por lo que no lo presentaremos como una muestra real de estudiantes. Más adelante simularemos una población artificial para entender el procedimiento.

### 4. Haz primero una cuenta pequeña

Para 2, 4 y 6 horas, suma 12 y divide entre tres: media 4. Si el último dato falta, suma los dos conocidos (6) y divide entre dos: media observada 3. El segundo resultado no estima qué respondió la tercera persona ni recupera la media completa. Esta distinción será importante en cada resumen.

## Experimenta sin programar

Agrega a la tabla una fila P02/Después con horas vacías. Cuenta personas, mediciones previstas y valores observados. Obtienes dos personas, cuatro mediciones y tres cantidades conocidas. Escribe los tres denominadores con su nombre; conservar solo el número «4» no comunica qué contaste.

## Errores frecuentes

| Confusión | Cómo revisarla |
|---|---|
| Cada fila es una persona distinta | Comprueba si hay momentos o visitas repetidas |
| Un espacio vacío equivale a cero | Consulta la convención de faltantes del diccionario |
| Una diferencia demuestra una causa | Revisa selección, asignación y variables no medidas |
| El archivo ficticio representa una población real | Declara su origen docente y limita la interpretación |

## Autoevaluación antes de continuar

1. ¿Por qué pueden existir cuatro filas y solo dos personas?
2. ¿Qué cambia en la media cuando excluyes un faltante?
3. ¿Qué debe contener una pregunta para saber qué tabla y resumen necesitas?

Comprueba las respuestas en las soluciones después de escribir las tuyas. Puedes avanzar cuando distingas pregunta, unidad, variable, clave y denominador con un ejemplo propio.


## Una pregunta antes de elegir una función

El curso parte de esta pregunta: ¿cómo se distribuyen los puntajes de dos grupos de una encuesta de práctica? Para responder necesitamos saber qué representa cada fila, qué mide cada columna, qué valores faltan y de dónde salieron los registros. Una tabla que se abre sin errores todavía no garantiza un análisis válido.

El archivo de encuesta contiene 36 participantes ficticios, un registro por participante. grupo es una categoría; puntaje es una medición de 0 a 100; horas_semana es otra medición que admite faltantes. El diccionario explica las decisiones. Los casos ambientales utilizan registros ficticios por estación y fecha: allí una misma estación aparece varias veces porque la unidad de observación es diferente.

## Qué necesitas y qué se enseñará

Necesitas manejar archivos y carpetas y comprender operaciones aritméticas, porcentajes y lectura de tablas. No necesitas conocer Python, programar antes ni dominar estadística. La ruta enseña objetos, funciones, tablas y los conceptos estadísticos usados en los ejemplos. Si una proporción o una media todavía te cuesta, calcula primero los ejemplos pequeños a mano.

El recorrido tiene cinco tramos: fundamentos de R; archivos y calidad; transformación y visualización; estadística introductoria; proyecto e informe reproducible. Las unidades son secuenciales: inferencia presupone entender faltantes, denominadores, variación y diseño de recolección.

## Alcance del resultado final

Terminarás con un proyecto que lee datos, valida su diccionario, produce un resumen y un gráfico y los comunica en un informe Quarto. Podrás seguir la lógica y adaptar una decisión con pruebas. La ruta introduce regresión lineal simple; métodos avanzados, modelos de aprendizaje automático, encuestas complejas y aplicaciones Shiny requieren otras decisiones y quedan fuera de esta primera versión.

Los datos son ficticios y se entregan con el curso. No representan resultados de personas, instituciones ni monitoreos reales. Sirven para aprender procedimientos y sus límites, no para sostener conclusiones sustantivas sobre una población.

## Comprobación de entrada

Una media de 2, 4 y 6 es 4. Si falta un dato, no sabemos que sea cero. Si una persona aparece dos veces por error, contar ambas filas puede alterar un resumen. Si son dos mediciones legítimas de esa misma persona, borrarla como duplicado puede destruir información. Estas preguntas guían la ruta.

Puedes comenzar desde la Unidad 01. Si ya usas R, revisa las salidas de fundamentos antes de pasar a datos; no necesitas repetir una instalación que ya funciona.

## Para avanzar

Resuelve la [práctica](PRACTICA.md), compara el resultado con tu predicción y justifica la decisión antes de consultar las soluciones. Si modificas código, repite la [verificación del curso](../docs/VERIFICACION.md).

[Índice](../README.md) · [Siguiente](../unidad01-entorno/README.md)

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2000%20%28Punto%20de%20entrada%2C%20preguntas%20y%20alcance%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
