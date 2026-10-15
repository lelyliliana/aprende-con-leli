# Unidad 05. Entrada de texto y conversión controlada

[Anterior](../unidad04-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-funciones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Conservar la entrada.
- Interpretar el entero.
- Producir minutos.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Capturar texto y decidir cómo interpretarlo

Una entrada del teclado no es automáticamente una cantidad válida. La persona puede escribir un nombre con espacios, una línea vacía, un número fuera del dominio o un texto que solo empieza por dígitos. Separar captura y conversión conserva la representación original para explicar un rechazo.

### Lee una línea completa

std::getline(std::cin, nombre) lee hasta el salto de línea y lo extrae sin guardarlo en la cadena. Si escribes Leli Liliana, la variable conserva ambas palabras. Leer con `>>` sobre una cadena suele detenerse ante espacio: es una operación distinta. El estado del flujo indica si la lectura se pudo realizar.

No uses while(!entrada.eof()) como forma de garantizar una lectura. El final se conoce cuando una operación intenta leer y lo alcanza. Evaluar la lectura como condición permite utilizar el resultado solo cuando existe. En el primer ejemplo un fallo comunica diagnóstico por std::cerr y devuelve 2.

### Interpreta en otro flujo

std::istringstream, de `<sstream>`, presenta el texto conservado como un flujo de entrada. Extraer horas con `>>` intenta interpretar un entero. Si no puede, la condición de fallo lo detecta. El entero se inicializa antes y no se utiliza como si fuera una captura exitosa cuando la extracción falló.

### No aceptes solo el prefijo

La extracción numérica puede leer 7 de 7 abc y dejar abc pendiente. Por eso se consume el espacio final con std::ws y se exige llegar al final del flujo. Esta política admite espacios alrededor de un entero pero rechaza caracteres sobrantes. No equivale al contrato más estricto de from_chars que estudiarás después.

| Línea | Conversión inicial | Revisión posterior |
|---|---|---|
| 5 | Entero 5 | Dentro de 0 a 40 |
| 41 | Entero 41 | Fuera del dominio |
| texto | Falla | No se calcula |
| 7 abc | Prefijo 7 | Rechazo por caracteres sobrantes |

### Separa error sintáctico y dominio

41 tiene sintaxis numérica correcta pero no se admite como horas en este contrato. Un entero tan largo que no cabe en int también debe producir una extracción fallida. El programa no debe continuar con una cantidad anterior ni asumir 0 porque una lectura no produjo dato.

En los ejemplos no se imprimen preguntas previas para simplificar la comparación automatizada. Al ejecutar desde la terminal, escribe la línea cuando el proceso espere y pulsar Enter termina esa captura. La prueba utiliza un archivo de entrada con la misma línea para que el resultado sea repetible.

### Decide cómo recuperarte

Esta versión termina ante un dato inválido con código 2. Una aplicación interactiva podría repetir la solicitud, pero debe conservar un estado de flujo coherente y una salida posible ante fin de entrada. No añadas un ciclo infinito que vuelva a leer el mismo fallo sin cambiar sus condiciones.

## Ejemplo 1. Leer una línea completa

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>

int main() {
    std::string nombre;
    if (!std::getline(std::cin, nombre)) {
        std::cerr << "No se recibió una línea\n";
        return 2;
    }
    std::cout << "Hola, " << nombre << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u05_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u05_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u05_e01.exe` |

Escribe esta línea cuando el programa espere entrada y pulsa Enter. La prueba utiliza el [mismo texto](ejemplos/01.entrada.txt):

```text
Leli Liliana
```

Salida esperada:

```text
Hola, Leli Liliana
```

### Lectura paso a paso

getline recibe toda la línea, incluidos los espacios internos. Para la entrada de prueba Leli Liliana, el saludo incluye el nombre completo. Si no hay línea disponible, se utiliza stderr y no se presenta un saludo vacío como captura correcta.

## Ejemplo 2. Separar texto de conversión

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>
#include <sstream>

int main() {
    std::string linea;
    if (!std::getline(std::cin, linea)) {
        std::cerr << "No se recibió una línea\n";
        return 2;
    }
    std::istringstream lector{linea};
    int horas{0};
    if (!(lector >> horas)) {
        std::cerr << "Se requiere un entero\n";
        return 2;
    }
    lector >> std::ws;
    if (!lector.eof() || horas < 0 || horas > 40) {
        std::cerr << "Se requiere un entero completo entre 0 y 40\n";
        return 2;
    }
    std::cout << "Minutos: " << horas * 60 << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u05_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u05_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u05_e02.exe` |

Escribe esta línea cuando el programa espere entrada y pulsa Enter. La prueba utiliza el [mismo texto](ejemplos/02.entrada.txt):

```text
5
```

Salida esperada:

```text
Minutos: 300
```

### Lectura paso a paso

Se conserva la línea, se intenta extraer el entero, se comprueba que no sobren caracteres y luego se valida rango. Solo después se multiplica por 60. El orden de esas revisiones protege el significado de Minutos: 300.

## Experimenta

Ejecuta el segundo programa con 0, 40, 41, texto y 7 abc. Predice cuáles terminan con 0 y cuáles con 2. El primer código significa éxito; el número de horas 0 es una entrada válida y no debe confundirse con un fallo.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Usar una variable después de fallar la extracción | Comprueba el estado antes de calcular. |
| Aceptar 7 abc porque empieza por un entero | Exige consumo completo según tu contrato. |
| Mezclar&gt;&gt; y getline sin pensar en el salto pendiente | Elige una estrategia de captura coherente por línea. |

## Autoevaluación

1. ¿getline conserva espacios internos?
2. ¿Una conversión numérica exitosa valida el rango?
3. ¿Por qué probar caracteres sobrantes?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad04-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-funciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2005%20%28Entrada%20de%20texto%20y%20conversi%C3%B3n%20controlada%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
