# Soluciones razonadas de la Unidad 19

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Comprobar un caso

3×2=6. La prueba no deriva su referencia repitiendo la implementación bajo evaluación.

## Paso 2. Añadir un límite

El resultado debe ser 0. Este caso investiga el límite elegido y se mantiene activo sin depender de assert.

## Paso 3. Recorrer casos

Los tres casos deben coincidir. Si cambias el orden de uno de los arrays sin el otro, la tabla deja de representar las parejas que definiste.

## Reto de transferencia. Demostrar un fallo observable

Se observa runtime_error. El caso demuestra que una condición falsa no se ignora silenciosamente bajo Release.

## Respuestas de autoevaluación

1. **¿CTest compila por sí solo?** La suite de este curso requiere construir antes sus metas.
2. **¿Por qué evitar assert como única prueba activa?** Puede deshabilitarse según NDEBUG.
3. **¿Qué necesita una buena expectativa?** Una justificación independiente y un caso que investigue una condición concreta.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <cstddef>
#include <iostream>
#include <array>
#include <stdexcept>

int doble(int n) { return n * 2; }
void exigir(bool condicion) { if (!condicion) { throw std::runtime_error{"No se cumple"}; } }

int main() {
    exigir(doble(3) == 6);
    std::cout << "Paso 1: caso normal comprobado\n";
    exigir(doble(0) == 0);
    std::cout << "Paso 2: límite cero comprobado\n";
    const std::array<int, 3> entradas{-2, 1, 4};
    const std::array<int, 3> esperados{-4, 2, 8};
    for (std::size_t i{0}; i < entradas.size(); ++i) { exigir(doble(entradas.at(i)) == esperados.at(i)); }
    std::cout << "Paso 3: tres casos adicionales comprobados\n";
    try { exigir(false); return 1; }
    catch (const std::runtime_error&) { std::cout << "Reto: una comprobación falsa produce fallo\n"; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u19_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u19_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u19_sol.exe` |

Salida esperada:

```text
Paso 1: caso normal comprobado
Paso 2: límite cero comprobado
Paso 3: tres casos adicionales comprobados
Reto: una comprobación falsa produce fallo
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2019%20%28CMake%2C%20CTest%20y%20pruebas%20reproducibles%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
