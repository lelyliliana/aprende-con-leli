# Soluciones razonadas de la Unidad 13

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Vincular una referencia

cantidad vale 6; no se creó una copia independiente para ese alias.

## Paso 2. Observar por puntero

El entero queda 7. El puntero es observador, no dueño de la variable automática.

## Paso 3. Representar ausencia

El puntero deja de observar; cantidad conserva 7 hasta que termine su vida útil.

## Reto de transferencia. Observar después decrecer

Tras finalizar el crecimiento, se obtiene un observador del estado actual y se lee 1. No se usa una dirección guardada antes de una modificación que pudiera invalidarla.

## Respuestas de autoevaluación

1. **¿Un puntero siempre es dueño?** No; puede ser un observador no propietario.
2. **¿nullptr detecta todos los accesos inválidos?** No; un puntero colgante puede ser no nulo.
3. **¿Qué muestra el destructor del recurso?** El momento deliberación ligado ala salida del bloque en ese recorrido.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <vector>

int main() {
    int cantidad{5};
    int& alias{cantidad};
    alias = 6;
    std::cout << "Paso 1: referencia=" << cantidad << '\n';
    int* p{&cantidad};
    if (p != nullptr) { *p = 7; }
    std::cout << "Paso 2: observador=" << cantidad << '\n';
    p = nullptr;
    std::cout << std::boolalpha << "Paso 3: puntero vacío=" << (p == nullptr) << '\n';
    std::vector<int> valores{1, 2};
    valores.push_back(3);
    const int* actual{&valores.at(0)};
    std::cout << "Reto: observador obtenido después de modificar vector=" << *actual << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u13_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u13_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u13_sol.exe` |

Salida esperada:

```text
Paso 1: referencia=6
Paso 2: observador=7
Paso 3: puntero vacío=true
Reto: observador obtenido después de modificar vector=1
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2013%20%28Alcance%2C%20punteros%20y%20vida%20%C3%BAtil%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
