# Unidad 16. Mapas, conjuntos e identidad

[Anterior](../unidad15-polimorfismo/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-archivos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Construir un catálogo.
- Consultar cero.
- Investigar ausencia.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Buscar por identidad en vez de posición

Un vector ordena elementos por posiciones. Un map relaciona claves con valores y permite consultar una identidad sin suponer dónde está. En `map<string, int>`, el código es clave y la cantidad es valor. Que la cantidad sea 0 no significa que la clave esté ausente.

### Consulta sin crear registros

find devuelve un iterador cuando la clave existe y end cuando falta. La comprobación debe preceder al acceso. encontrado-&gt;first es clave y encontrado-&gt;second es su valor asociado. contains, disponible en nuestra base C++20, responde directamente si está presente.

El operador[] de map puede insertar una clave que falta con un valor inicializado. Es útil para contar frecuencias pero no para una consulta que prometa conservar el catálogo. Preguntar stock["S03"] podría crear S03 con 0 y confundir una ausencia con una existencia agotada.

| Clave | ¿Existe? | Cantidad |
|---|---|---|
| S01 | Sí | 5 |
| S02 | Sí | 0 |
| S03 | No | No hay cantidad registrada |

### Orden e identidad son decisiones distintas

std::map conserva sus claves en el orden de su comparador. La comparación predeterminada de las claves ASCII del ejemplo permite una salida determinista. Buscar e insertar tienen complejidad logarítmica en el tamaño para estas operaciones de mapa; eso no es una promesa de tiempo fijo en milisegundos.

unordered_map tiene otro contrato de organización y complejidad y no debe usarse esperando el mismo orden de recorrido. En este curso elegimos map cuando su semántica y el orden declarado aportan claridad, sin afirmar que una estructura sea siempre más rápida para cualquier problema.

### Un set puede investigar repetición

set conserva claves únicas. insert devuelve información sobre el elemento y si fue insertado. Si insert(id).second es false, esa clave ya estaba en el conjunto. Eso permite detectar la repetición en una entrada antes de decidir qué hacer con la fila.

Eliminar repetidos no es una política universal de limpieza. Dos registros del mismo código con cantidades incompatibles requieren una regla. El proyecto rechaza duplicación de identidad en su lote, en lugar de conservar el primero o sumar sin explicar.

### Conteos y consultas utilizan efectos diferentes

En frecuencias[grupo] el valor inicial 0 de una clave nueva es deliberado: luego se incrementa porque encontramos una observación de esa categoría. En stock.find, la ausencia debe conservarse como tal. El mismo operador puede ser apropiado para un conteo e incorrecto para una consulta de inventario.

La descomposición const auto&[grupo, n] da nombres a las dos partes del par durante el recorrido. No crea dos columnas independientes ni modifica claves. La introducimos sobre una estructura conocida para que puedas reconocer la relación entre código y valor.

## Ejemplo 1. Buscar sin insertar una clave

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <map>
#include <string>

int main() {
    std::map<std::string, int> stock{ {"S01", 5}, {"S02", 0}};
    const auto encontrado{stock.find("S02")};
    if (encontrado != stock.end()) { std::cout << "S02 presente con cantidad=" << encontrado->second << '\n'; }
    std::cout << std::boolalpha << "S03 presente: " << stock.contains("S03") << '\n';
    std::cout << "Claves: " << stock.size() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u16_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u16_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u16_e01.exe` |

Salida esperada:

```text
S02 presente con cantidad=0
S03 presente: false
Claves: 2
```

### Lectura paso a paso

S02 existe y su cantidad es 0. contains de S03 devuelve false y el mapa conserva dos claves. La salida demuestra una consulta que no muta el conjunto de identidades.

## Ejemplo 2. Contar etiquetas y detectar repetición

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

int main() {
    const std::vector<std::string> grupos{"A", "B", "A"};
    std::map<std::string, int> frecuencias;
    std::set<std::string> vistos;
    for (const auto& grupo : grupos) { ++frecuencias[grupo]; vistos.insert(grupo); }
    for (const auto& [grupo, n] : frecuencias) { std::cout << grupo << ": " << n << '\n'; }
    std::cout << "Etiquetas distintas: " << vistos.size() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u16_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u16_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u16_e02.exe` |

Salida esperada:

```text
A: 2
B: 1
Etiquetas distintas: 2
```

### Lectura paso a paso

Los grupos A, B, A producen frecuencias A: 2 y B: 1. El set conserva dos etiquetas distintas. Contar tres observaciones y dos categorías son preguntas diferentes, igual que ocurría con cantidad y suma.

## Experimenta

Consulta una clave desconocida con find y comprueba size antes y después. En una copia utiliza [] con esa misma clave y observa el cambio. Explica por qué una consulta que inserta podría falsear un catálogo.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Usar [] para buscar sin modificar | Usa find, contains o una operación apropiada al contrato. |
| Confundir cero con ausencia | Comprueba la clave además del valor. |
| Eliminar filas por ID repetido sin una política | Detecta y justifica el tratamiento de contradicciones. |

## Autoevaluación

1. ¿Qué puede hacer [] con una clave ausente?
2. ¿Un set resuelve una contradicción de cantidades?
3. ¿Qué representan 3 observaciones y 2 etiquetas?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad15-polimorfismo/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-archivos/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2016%20%28Mapas%2C%20conjuntos%20e%20identidad%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
