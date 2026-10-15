# Consultar la sintaxis sin perder el recorrido

[Curso](../README.md) · [Funciones](../unidad06-funciones/README.md) · [Vida útil](../unidad13-vida-util/README.md)

Busca una expresión cuando aparezca y vuelve al ejemplo. No hace falta memorizar este documento antes de empezar.

| Expresión | Lectura |
|---|---|
| `int cantidad{3};` | Declara e inicializa un entero |
| `const int limite{40};` | Conserva un valor que no se reasigna después |
| `cantidad = 4;` | Asigna otro valor al objeto |
| `cantidad == 4` | Compara valores y produce un booleano |
| `if (condicion) { ... }` | Ejecuta un bloque si se cumple la condición |
| `for (...) { ... }` | Repite bajo las reglas del encabezado |
| `int& alias` | Una referencia vinculada a un entero |
| `const std::string& texto` | Consulta un texto mediante referencia constante |
| `int* p` / `&cantidad` / `*p` | Puntero, obtención de dirección y acceso cuando es válido |
| `nullptr` | Ausencia de objeto observado por ese puntero |
| `objeto.campo` | Acceso a un miembro del objeto |
| `puntero->metodo()` | Acceso a un miembro a través del puntero o propietario apropiado |
| `std::` | Identifica herramientas de la biblioteca estándar |
| `auto valor{expresion};` | Deduce el tipo estático desde la expresión |

## Entrada, salida y códigos

cout presenta salida estándar; cerr presenta diagnósticos. `\n` dentro de una cadena crea un salto de línea. getline captura una línea sin guardar el salto final. El código de terminación es una señal diferente de lo que se imprimió: esta ruta usa 0 para éxito y 2 para rechazos de la aplicación.

Cada ejemplo completo tiene su propio main y su meta de construcción. No pegues varios main en un único archivo. Las funciones auxiliares y bibliotecas pueden no tener main porque se enlazan con un programa que las utiliza.

## Valores, presencia y límites

`optional<int>` puede tener un entero 0 o no tener resultado. Su condición booleana comprueba presencia. El tamaño de una colección y un índice no significan lo mismo: con tamaño 3 existen posiciones 0, 1, 2. std::size_t es un tipo entero sin signo utilizado para tamaños; no lo utilices para representar una cantidad negativa y luego intentar validarla.

find devuelve un iterador que puede ser end. No se desreferencia el límite final. Un puntero no nulo tampoco demuestra por sí mismo que su objeto siga vivo. Conserva las precondiciones y vida útil además de revisar ausencia.

## Errores y recursos

throw interrumpe una operación; catch permite gestionar una excepción compatible. No convierte una entrada rechazada en éxito. Los objetos estándar como string, vector y flujos gestionan sus recursos mediante su vida útil. unique_ptr expresa propiedad exclusiva y move permite utilizar la operación de movimiento del tipo; no es una instrucción universal para copiar ni para dejar vacío cualquier objeto.

## Organización

El encabezado declara una interfaz. La fuente aporta definiciones que deben compilarse y enlazarse según el proyecto. CMake organiza metas y dependencias; CTest comprueba ejecuciones registradas. Una construcción exitosa es necesaria para ejecutar el binario nuevo, pero no demuestra que su resultado corresponda a la pregunta.

Si una expresión te sorprende, anota entrada, tipo, estado anterior, estado posterior y salida. Reduce la duda a un caso pequeño antes de cambiar el programa completo.
