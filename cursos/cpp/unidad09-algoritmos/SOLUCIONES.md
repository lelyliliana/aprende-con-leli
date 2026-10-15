# Soluciones razonadas de la Unidad 09

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Ordenar conservando

La copia queda 2, 4, 6, 8 y el primer valor original sigue 8. La conservación se comprueba sobre la fuente, no solo sobre el tamaño.

## Paso 2. Buscar con límite

Se encuentra 6. Si buscaras 99, no se leería el iterador de final. El significado de ausencia se decide antes de utilizar la posición.

## Paso 3. Contar una regla

Cumplen 6 y 8: dos elementos. El conteo no es la suma 14 de sus cantidades; son preguntas distintas.

## Reto de transferencia. Sumar y contrastar

La suma es 20 y el original conserva 8 primero. El resultado sirve para contrastar efectos, sin pretender una prueba universal para cualquier tipo numérico.

## Respuestas de autoevaluación

1. **¿end es el último elemento?** No; señala el límite excluido posterior.
2. **¿Qué captura[umbral]?** Una copia del valor usado al construir la lambda.
3. **¿Por qué importa el inicial de accumulate?** Su tipo participa en el acumulador y su representación.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

int main() {
    const std::vector<int> original{8, 2, 6, 4};
    auto ordenada{original};
    std::sort(ordenada.begin(), ordenada.end());
    std::cout << "Paso 1: orden=";
    for (const int x : ordenada) { std::cout << x << ' '; }
    std::cout << '\n';
    const auto p{std::find(ordenada.begin(), ordenada.end(), 6)};
    if (p == ordenada.end()) { return 1; }
    std::cout << "Paso 2: encontrado=" << *p << '\n';
    const auto cantidad{std::count_if(ordenada.begin(), ordenada.end(), [](int x) { return x >= 6; })};
    std::cout << "Paso 3: cumplen=" << cantidad << '\n';
    std::cout << "Reto: suma=" << std::accumulate(ordenada.begin(), ordenada.end(), 0) << "; original primero=" << original.at(0) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u09_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u09_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u09_sol.exe` |

Salida esperada:

```text
Paso 1: orden=2 4 6 8
Paso 2: encontrado=6
Paso 3: cumplen=2
Reto: suma=20; original primero=8
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2009%20%28Iteradores%2C%20algoritmos%20y%20lambdas%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
