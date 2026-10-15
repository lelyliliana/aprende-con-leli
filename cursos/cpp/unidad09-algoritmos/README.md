# Unidad 09. Iteradores, algoritmos y lambdas

[Anterior](../unidad08-contenedores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-registros/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Ordenar conservando.
- Buscar con límite.
- Contar una regla.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un algoritmo trabaja sobre un recorrido

La biblioteca estándar ofrece ordenación, búsqueda, conteo y acumulación. Antes de reescribir un ciclo, identifica si una operación existente expresa tu intención. La elección todavía requiere entender qué rango recibe, qué modifica y qué devuelve.

### Lee begin y end como límites

begin apunta conceptualmente al primer elemento y end señala una posición posterior al último. El rango[begin, end) incluye el primero y excluye ese final. Un iterador permite recorrer posiciones; el operador* accede al elemento que observa cuando es válido. No desreferencies end: es una señal de terminación, no un dato adicional.

std::find devuelve el iterador de una coincidencia o end si no encuentra. Por eso el ejemplo compara antes de usar*. La ausencia de un valor no debe convertirse en acceso a la última posición disponible ni en un cero inventado.

### Ordena una copia cuando debes conservar entrada

std::sort modifica el rango que recibe. La copia ordenada del ejemplo pasa a 2, 4, 6, 8, mientras original mantiene 8 como primer elemento. Para registros más complejos, ordenaremos la fila completa y conservaremos su código junto a la cantidad.

El comparador define una relación estricta: para orden ascendente se usa a<b, no a<=b. Un criterio incoherente incumple precondiciones del algoritmo. std::sort no garantiza conservar el orden relativo de elementos equivalentes; si ese orden importa, necesitas otra elección y una justificación.

### Expresa una condición como función pequeña

Una lambda es un objeto invocable que puedes definir en el lugar de uso. `[umbral](int valor) { return valor >= umbral; }` captura una copia de umbral para consultar en su cuerpo. Esa condición pasa a count_if, que cuenta elementos que la satisfacen. La captura por valor no cambia después porque reasignes el objeto exterior.

La captura por referencia necesita que el objeto referido siga existiendo y puede introducir efectos. En esta primera condición usamos una copia deliberadamente. No guardes una lambda con referencias a locales que desaparecieron al terminar una función.

### Acumula con el tipo correcto

std::accumulate recibe un valor inicial cuyo tipo influye en el acumulador. El 0 entero del ejemplo es apropiado para estas cantidades pequeñas. Para sumas mayores declara un acumulador de representación suficiente desde el inicio; un tipo de salida grande no repara un desbordamiento intermedio.

| Pregunta | Operación | ¿Cambia el rango? |
|---|---|---|
| Ordenar | sort | Sí |
| Buscar una coincidencia | find | No en este uso |
| Contar una condición | count_if | No |
| Sumar | accumulate | No en este uso |

Un algoritmo más compacto no elimina la necesidad de revisar límites, unidad e identidad. Su ventaja aparece cuando la operación y su contrato se entienden mejor que el ciclo equivalente.

## Ejemplo 1. Ordenar una copia y encontrar una identidad

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    const std::vector<int> original{8, 2, 6, 4};
    auto ordenada{original};
    std::sort(ordenada.begin(), ordenada.end());
    for (const int valor : ordenada) { std::cout << valor << ' '; }
    std::cout << '\n';
    const auto encontrado{std::find(ordenada.begin(), ordenada.end(), 6)};
    if (encontrado != ordenada.end()) { std::cout << "Encontrado: " << *encontrado << '\n'; }
    std::cout << "Original primero: " << original.at(0) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u09_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u09_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u09_e01.exe` |

Salida esperada:

```text
2 4 6 8
Encontrado: 6
Original primero: 8
```

### Lectura paso a paso

Se copia y ordena; después find localiza 6 y se comprueba que no sea end. La salida del original conserva 8. Esa revisión detectaría si hubieras ordenado directamente la entrada en lugar de la copia.

## Ejemplo 2. Nombrar una condición con una lambda

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

int main() {
    const std::vector<int> horas{2, 6, 4, 8};
    int umbral{5};
    const auto cumple{[umbral](int valor) { return valor >= umbral; }};
    const auto cantidad{std::count_if(horas.begin(), horas.end(), cumple)};
    const int suma{std::accumulate(horas.begin(), horas.end(), 0)};
    std::cout << "Al menos 5: " << cantidad << "; suma=" << suma << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u09_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u09_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u09_e02.exe` |

Salida esperada:

```text
Al menos 5: 2; suma=20
```

### Lectura paso a paso

La lambda pregunta por valores&gt;=5. Con 2, 6, 4, 8 cumplen dos; la suma es 20. La captura conserva el umbral de este objeto invocable y el algoritmo recorre el mismo rango para cada operación.

## Experimenta

Busca 99 y predice que find devolverá end, sin desreferenciarlo. Después cambia el umbral de la lambda a 6: escribe cuáles cumplen y cuántos. Compara count_if con un ciclo que incremente un contador bajo la misma condición.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Desreferenciar find sin comprobar end | Gestiona explícitamente el caso ausente. |
| Ordenar y esperar conservar el original | Crea una copia antes de sort. |
| Usar&lt;= como comparador de sort | El orden debe ser estricto y coherente. |

## Autoevaluación

1. ¿end es el último elemento?
2. ¿Qué captura[umbral]?
3. ¿Por qué importa el inicial de accumulate?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad08-contenedores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-registros/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2009%20%28Iteradores%2C%20algoritmos%20y%20lambdas%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
