# Unidad 19. CMake, CTest y pruebas reproducibles

[Anterior](../unidad18-plantillas/README.md) · [Índice](../README.md) · [Siguiente](../unidad20-depuracion/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Comprobar un caso.
- Añadir un límite.
- Recorrer casos.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Construir y probar son etapas distintas

Hasta ahora utilizaste metas preparadas para concentrarte en el lenguaje. Esta unidad explica cómo se organizan. CMake configura un proyecto y genera reglas para un sistema de construcción; ese sistema invoca compilador y enlazador. CTest ejecuta pruebas registradas y recoge sus resultados.

### Configurar no compila todos los programas

cmake -S . -B build identifica fuentes y carpeta de construcción. Detecta herramientas y procesa CMakeLists.txt. cmake --build build construye las metas; --target permite elegir una sola. ctest --test-dir build ejecuta las pruebas disponibles y no sustituye una construcción previa del binario que necesitan.

La opción --config Debug selecciona configuración en generadores que conservan varias. En los de una sola configuración, CMAKE_BUILD_TYPE se elige al configurar. La guía ofrece órdenes compatibles con el proyecto y explica dónde quedan los ejecutables; no supongas que todos los generadores organizan carpetas igual sin declararlo.

### Registra dependencias

add_executable declara una meta con fuentes. add_library crea la biblioteca de inventario. target_link_libraries expresa qué ejecutables la necesitan. target_compile_features solicita C++20 y las opciones de advertencias dependen del compilador. Un cambio de cabecera o fuente debe llegar a las metas dependientes mediante esa construcción.

### Prueba contra una expectativa independiente

exigir recibe una condición y lanza runtime_error cuando no se cumple. La primera prueba compara doble(3) con 6, doble(0) con 0 y doble(-2) con -4. Los esperados proceden de cuentas conocidas, no de llamar otra vez a la misma función como supuesto oráculo.

assert puede deshabilitarse cuando está definido NDEBUG, como ocurre en configuraciones habituales de Release. Por eso las comprobaciones de este curso que deben seguir activas no dependen de ese mecanismo: usan condiciones explícitas, excepciones o comparación de salida y estado.

### Casos normales, límites y rechazos

Una tabla de casos guarda entrada y resultado esperado. Para el rango 0 a 40, los límites 0/40 y los exteriores -1/41 investigan decisiones que un único caso 5 no distingue. Cada caso debe tener una razón; añadir cientos de repeticiones idénticas no explora nuevas condiciones.

| Evidencia | Qué puede detectar |
|---|---|
| Compilación con advertencias | Incompatibilidades y señales estáticas observadas |
| Comparación de stdout | Un resultado comunicado diferente del esperado |
| Código de terminación | Un fallo o éxito incoherente con el caso |
| Contratos del proyecto | Identidad, dominio, formato y límites de entradas concretas |

### Repite sin contaminar fuentes

Las pruebas de salida preparan carpetas bajo build/ejecuciones y copian allí los datos necesarios. Eso evita que un programa escriba sobre los ejemplos originales durante la verificación y permite repetir sin depender de productos anteriores. Los finales de línea y espacios finales se normalizan al comparar texto; los números y mensajes no se reemplazan para obtener un aprobado.

Una suite aprobada aporta evidencia sobre sus casos y entornos. No demuestra que todo diseño sea correcto ni que cualquier entrada futura esté cubierta. Cuando aparece un fallo nuevo, conserva un caso pequeño que lo detecte y comprueba la corrección junto con lo que ya funcionaba.

## Ejemplo 1. Comprobar sin depender de assert

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <stdexcept>

int doble(int n) { return n * 2; }
void exigir(bool condicion, const char* mensaje) {
    if (!condicion) { throw std::runtime_error{mensaje}; }
}

int main() {
    exigir(doble(3) == 6, "Caso normal");
    exigir(doble(0) == 0, "Caso cero");
    exigir(doble(-2) == -4, "Caso negativo");
    std::cout << "Tres comprobaciones activas también en Release\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u19_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u19_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u19_e01.exe` |

Salida esperada:

```text
Tres comprobaciones activas también en Release
```

### Lectura paso a paso

Las tres condiciones se evalúan también cuando el ejecutable se construye en Release. Si una es falsa, exigir lanza y no se muestra el mensaje final como si todo estuviera correcto. El ejemplo no usa assert como única evidencia de prueba.

## Ejemplo 2. Recorrer una tabla de casos

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <array>
#include <stdexcept>

struct Caso { int entrada; bool esperado; };

int main() {
    const std::array<Caso, 4> casos{ { {0, true}, {40, true}, {-1, false}, {41, false}}};
    for (const auto& caso : casos) {
        const bool admitido{caso.entrada >= 0 && caso.entrada <= 40};
        if (admitido != caso.esperado) { throw std::runtime_error{"Caso no coincide"}; }
    }
    std::cout << "Cuatro casos: dos límites admitidos y dos rechazos\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u19_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u19_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u19_e02.exe` |

Salida esperada:

```text
Cuatro casos: dos límites admitidos y dos rechazos
```

### Lectura paso a paso

La tabla contiene dos límites válidos y dos rechazos. El ciclo compara cada decisión con una expectativa escrita antes. Su estructura permite añadir un caso distinto y explicar qué condición adicional investiga.

## Experimenta

En una copia cambia un esperado correcto por otro incorrecto y observa que la prueba falla. Recupera el esperado justificado y vuelve a ejecutar. No modifiques un esperado para aceptar una implementación equivocada sin investigar su causa.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Ejecutar CTest sin construir los binarios | Construye las metas que la suite necesita. |
| Confiar en assert como prueba activa en cualquier configuración | Revisa NDEBUG y el mecanismo usado. |
| Generar esperados llamando a la misma función | Usa una cuenta o criterio independiente para cada caso. |

## Autoevaluación

1. ¿CTest compila por sí solo?
2. ¿Por qué evitar assert como única prueba activa?
3. ¿Qué necesita una buena expectativa?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad18-plantillas/README.md) · [Índice](../README.md) · [Siguiente](../unidad20-depuracion/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2019%20%28CMake%2C%20CTest%20y%20pruebas%20reproducibles%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
