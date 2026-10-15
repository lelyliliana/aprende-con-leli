# Unidad 14. RAII, std::unique_ptr y movimiento

[Anterior](../unidad13-vida-util/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-polimorfismo/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Crear propietario.
- Transferir.
- Consultar el destino.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un recurso debe tener una responsabilidad clara

std::unique_ptr expresa propiedad exclusiva de un objeto dinámico. El propietario libera el objeto cuando termina o se reinicia; no tienes que escribir delete en cada camino normal y de excepción. std::make_unique construye el objeto y devuelve ese propietario mediante una operación adecuada.

### Empieza con un dueño

`make_unique<int>`(7) crea un entero gestionado. primero permite acceder con `*` cuando contiene un objeto. Copiar unique_ptr no está permitido: dos propietarios exclusivos independientes sobre el mismo objeto contradirían su contrato. Si necesitas cambiar quién posee el recurso, transfiere esa responsabilidad.

### Movimiento no es una copia

std::move permite tratar una expresión como candidata a movimiento. La operación concreta del tipo realiza la transferencia; llamar std::move por sí solo no transporta bytes mágicamente. En auto segundo=std::move(primero), el constructor de movimiento de unique_ptr hace que segundo posea el entero y primero quede vacío según la garantía de ese tipo.

No generalices que todo objeto movido queda vacío. Para otros tipos, como string, el estado posterior puede tener garantías distintas. Un objeto movido debe utilizarse según lo que su interfaz permita y no según un valor observado en una implementación.

| Momento | primero | segundo |
|---|---|---|
| Construcción | Posee 7 | Aún no existe |
| Tras transferencia | Vacío | Posee 7 |
| Salida del alcance | Sin recurso | Libera el entero poseído |

### Componer propietarios en contenedores

`vector<unique_ptr<int>>` conserva varios propietarios. push_back acepta la transferencia de un propietario o de un propietario temporal creado con make_unique. Al recorrer con const auto& no intentas copiar el unique_ptr. Se consulta cada entero y la colección gestiona las liberaciones al destruirse.

En el segundo ejemplo hay dos enteros, 3 y 5, y su suma es 8. El vector almacena propietarios de enteros. Para enteros ordinarios, `vector<int>` suele ser suficiente; usamos esta forma para estudiar propiedad y preparar una colección polimórfica posterior, no para afirmar que toda cantidad deba reservarse dinámicamente.

### La regla de cero evita trabajo innecesario

Una clase cuyos miembros string, vector y unique_ptr gestionan sus recursos puede no necesitar destructores de liberación manual. Diseñar destructores, copias y movimientos propios exige mantener su coherencia. Antes de escribirlos, pregunta si una composición de tipos estándar ya expresa el contrato.

shared_ptr representa propiedad compartida, con otros costes y condiciones; no se elige solo para evitar comprender unique_ptr. El curso se centra en propiedad exclusiva y observadores con vida útil válida. Ese modelo basta para los ejemplos y el proyecto, que conserva registros por valor.

### Verifica uso posterior a transferencia

Comprobar que el origen queda vacío es válido aquí por la especificación de unique_ptr. No lo desreferencies para comprobar su antiguo valor. El objeto gestionado puede seguir existiendo bajo otro propietario, aunque el nombre original ya no permita acceder a él.

## Ejemplo 1. Transferir un propietario exclusivo

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <memory>
#include <utility>

int main() {
    auto primero{std::make_unique<int>(7)};
    auto segundo{std::move(primero)};
    std::cout << std::boolalpha << "Origen vacío: " << (!primero) << '\n';
    std::cout << "Destino: " << *segundo << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u14_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u14_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u14_e01.exe` |

Salida esperada:

```text
Origen vacío: true
Destino: 7
```

### Lectura paso a paso

El entero nace con un propietario. Después del movimiento, la comprobación de origen muestra true para vacío y el destino permite leer 7. No hay dos copias del entero ni un delete compartido entre ambos nombres.

## Ejemplo 2. Un contenedor conserva propietarios

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <memory>
#include <vector>

int main() {
    std::vector<std::unique_ptr<int>> valores;
    valores.push_back(std::make_unique<int>(3));
    valores.push_back(std::make_unique<int>(5));
    int suma{0};
    for (const auto& propietario : valores) { suma += *propietario; }
    std::cout << "Propietarios: " << valores.size() << "; suma=" << suma << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u14_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u14_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u14_e02.exe` |

Salida esperada:

```text
Propietarios: 2; suma=8
```

### Lectura paso a paso

Dos propietarios entran en el vector. El recorrido por referencia evita intentar copiarlos y la suma consulta 3 y 5. Al finalizar el vector, sus unique_ptr se destruyen y liberan sus objetos. El programa no necesita una llamada manual por cada elemento.

## Experimenta

En una copia, intenta copiar un unique_ptr y lee el diagnóstico de compilación sin convertirlo en una prueba de ejecución. Después transfiérelo con move y comprueba presencia en origen y destino. Recupera la versión compilable del curso.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Pensar que std::move siempre mueve por sí mismo | La operación del tipo decide la transferencia. |
| Copiar un propietario exclusivo | Transfiere o elige otro diseño de propiedad justificado. |
| Desreferenciar después de traspasar unique_ptr | Comprueba el estado y utiliza el nuevo propietario. |

## Autoevaluación

1. ¿unique_ptr se puede copiar?
2. ¿Todos los tipos movidos quedan vacíos?
3. ¿Por qué no recorrer unique_ptr por valor?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad13-vida-util/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-polimorfismo/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2014%20%28RAII%2C%20std%3A%3Aunique_ptr%20y%20movimiento%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
