# Cómo leer el código de los ejemplos

[Curso](../README.md) · [Unidad 01](../unidad01-entorno/README.md) · [Funciones](../unidad06-funciones/README.md)

Consulta una entrada cuando aparezca por primera vez y vuelve a la unidad. No necesitas memorizar este documento antes de empezar. Una función recibe argumentos entre paréntesis; algunos se escriben por posición y otros por nombre. Por ejemplo, mean(x, na.rm = TRUE) pide calcular con x y retirar sus ausencias para ese cálculo. No modifica x.

## Objetos, selecciones y condiciones

| Expresión | Lectura y uso |
|---|---|
| nombre <- valor | Conserva el resultado evaluado con un nombre |
| c(2, 4, 6) | Construye un vector con tres valores |
| x[1] | Selecciona la primera posición de x |
| d[filas, columnas] | Selecciona una parte de una tabla |
| d$horas o d[["horas"]] | Extrae una columna por nombre en estos ejemplos |
| x >= 6 | Compara cada elemento y produce respuestas lógicas |
| x %in% c("A", "B") | Comprueba pertenencia a los valores indicados |
| !is.na(x) | Marca los elementos que no son faltantes |
| a & b | Combina condiciones por elemento exigiendo ambas |
| a \| b | Combina condiciones por elemento aceptando al menos una |
| a && b / a \|\| b | Combina condiciones escalares para control; no filtra columnas completas |

TRUE y FALSE son valores lógicos, no textos entre comillas. sum de una máscara lógica cuenta sus TRUE como unos; si hay NA, debes decidir primero cómo tratar esas respuestas desconocidas. all pregunta si todas las condiciones se cumplen y any si se cumple alguna. Una comprobación debe contemplar el caso faltante, no asumir que cualquier vector lógico está completo.

## Comprobaciones del curso

| Función | Qué comprueba y qué no |
|---|---|
| stopifnot(condición) | Detiene el archivo si la condición no se cumple; no imprime éxito automáticamente |
| identical(a, b) | Compara igualdad estricta de objetos, incluidos tipos y atributos relevantes |
| all.equal(a, b) | Permite comparar resultados con tolerancia; puede devolver TRUE o una descripción de diferencias |
| isTRUE(resultado) | Exige un TRUE escalar, útil al interpretar all.equal |
| anyDuplicated(clave) | Devuelve una posición repetida encontrada o cero si no encuentra repetición |
| anyNA(x) | Detecta si hay algún faltante |
| is.finite(x) | Distingue cantidades finitas de Inf, -Inf y faltantes |
| inherits(resultado, "error") | Comprueba si una condición capturada pertenece a la clase error |

En la Unidad 06 se construyen las funciones y los rechazos. stop crea un error con un mensaje; tryCatch permite observar uno previsto sin terminar todas las pruebas. Un error inesperado debe investigarse. Sustituir cualquier fallo por cero ocultaría la causa y podría generar un resultado falso.

## Presentación, iteración y archivos

print muestra un objeto usando su método de impresión. cat combina texto y cantidades, y \n dentro de una cadena produce un salto de línea. sprintf permite controlar formato, por ejemplo %.3f para tres decimales. unname quita nombres para comparar o presentar valores sin esas etiquetas; no cambia una unidad física.

vapply aplica una función a cada elemento y exige una forma de salida declarada. En vapply(d, typeof, character(1)), cada columna debe producir un texto que describa su tipo. Puedes empezar inspeccionando str(d); el uso de vapply permite conservar esas descripciones en un objeto.

source ejecuta el contenido de un archivo R. Los archivos compartidos del curso definen funciones para usarlas después; por eso cargar src/curso.R no equivale a llamar leer_encuesta. Ejecutar varios source en una consola conserva su estado, mientras Rscript --vanilla abre un proceso sin restaurar el entorno anterior.

tempfile propone un nombre temporal; dir.create crea una carpeta; file.path reúne partes de una ruta; file.exists y file.info revisan existencia y propiedades. unlink elimina la ruta indicada: en los ejemplos solo se utiliza para los recursos temporales que acaba de crear el propio programa.

capture.output conserva como texto una impresión, como sessionInfo. writeLines escribe líneas. invisible devuelve un valor sin imprimirlo automáticamente; por ejemplo, evita que dev.off añada el número del dispositivo a la salida documentada. La ausencia de una impresión no significa que una función no haya devuelto nada.

## Funciones compartidas y paquetes

paquete::funcion identifica el origen de una función. No instala el paquete. La tubería |> pasa la salida de la izquierda como primer argumento de la llamada siguiente; en dplyr, los verbos se explican en la Unidad 09. El signo + de ggplot añade capas y se estudia en la Unidad 12.

Los nombres leer_encuesta, validar_encuesta, limpiar_entrada, resumir_encuesta y figura_encuesta son funciones de este curso, definidas en [src/curso.R](../src/curso.R). No son órdenes incorporadas en R. Consulta sus cuerpos y relaciona cada una con la etapa de lectura, calidad, resumen o figura que ya construiste. Cambiar una regla compartida requiere revisar los ejemplos y el proyecto que dependen de ella.

Si una expresión te sorprende, registra entrada, tipo, salida esperada y salida observada. Reduce la duda a un ejemplo pequeño antes de alterar todo el análisis. Esa práctica ayuda a distinguir un problema de sintaxis, de estructura, de dominio o de interpretación.
