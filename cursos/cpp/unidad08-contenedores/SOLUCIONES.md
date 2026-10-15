# Soluciones razonadas de la Unidad 08

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Resumir una colección

El tamaño es 4 y la suma 20. Recorrer sin referencia modificable conserva el contenido original.

## Paso 2. Seleccionar sin borrar

La selección contiene 6, 8 y el original mantiene sus cuatro elementos. No se asume que seleccionar equivale a eliminar filas del origen.

## Paso 3. Modificar la copia

La copia queda 12, 16 y el origen conserva 6, 8 en sus últimas posiciones. Cambiar una copia de vector no modifica automáticamente otra colección.

## Reto de transferencia. Elegir un tamaño fijo

El array tiene exactamente dos elementos. No se eligió porque sea siempre mejor que vector, sino porque esa estructura requiere dos límites conocidos.

## Respuestas de autoevaluación

1. **¿reserve crea elementos?** No; prepara capacidad, no modifica size.
2. **¿Qué índices existen con size 3?** 0, 1, 2.
3. **¿Puede push_back invalidar referencias?** Sí, cuando ocurre una reasignación; no conserves observadores sin revisar esa posibilidad.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <vector>
#include <array>

int main() {
    std::vector<int> x{2, 4, 6, 8};
    int suma{0};
    for (const int valor : x) { suma += valor; }
    std::cout << "Paso 1: tamaño=" << x.size() << "; suma=" << suma << '\n';
    std::vector<int> seleccion;
    for (const int valor : x) { if (valor >= 6) { seleccion.push_back(valor); } }
    std::cout << "Paso 2: seleccionados=" << seleccion.at(0) << ',' << seleccion.at(1) << '\n';
    for (int& valor : seleccion) { valor *= 2; }
    std::cout << "Paso 3: copia=" << seleccion.at(0) << ',' << seleccion.at(1) << "; original=" << x.at(2) << ',' << x.at(3) << '\n';
    const std::array<int, 2> limites{0, 40};
    std::cout << "Reto: intervalo fijo=" << limites.at(0) << ',' << limites.at(1) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u08_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u08_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u08_sol.exe` |

Salida esperada:

```text
Paso 1: tamaño=4; suma=20
Paso 2: seleccionados=6,8
Paso 3: copia=12,16; original=6,8
Reto: intervalo fijo=0,40
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2008%20%28std%3A%3Aarray%20y%20std%3A%3Avector%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
