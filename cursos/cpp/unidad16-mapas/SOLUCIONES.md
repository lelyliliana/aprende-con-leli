# Soluciones razonadas de la Unidad 16

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Construir un catálogo

Hay dos claves, no cinco productos distintos ni una sola cantidad conocida.

## Paso 2. Consultar cero

S02 está registrado con cero unidades. No debe interpretarse como clave desconocida.

## Paso 3. Investigar ausencia

S03 está ausente y el mapa sigue teniendo dos claves. Esa cuenta ayuda a detectar efectos no deseados de una consulta.

## Reto de transferencia. Detectar repetición

Se detecta una repetición. El ejemplo la cuenta; el proyecto la rechazará bajo su contrato, sin inventar una consolidación.

## Respuestas de autoevaluación

1. **¿Qué puede hacer [] con una clave ausente?** Insertarla con un valor inicializado.
2. **¿Un set resuelve una contradicción de cantidades?** No; puede detectar identidad repetida, pero la política requiere una decisión.
3. **¿Qué representan 3 observaciones y 2 etiquetas?** El tamaño del recorrido y el número de categorías distintas, respectivamente.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

int main() {
    std::map<std::string, int> stock{{"S01", 5}, {"S02", 0}};
    std::cout << "Paso 1: claves=" << stock.size() << '\n';
    const auto cero{stock.find("S02")};
    if (cero == stock.end()) { return 1; }
    std::cout << "Paso 2: S02 tiene cero=" << cero->second << '\n';
    const auto ausente{stock.find("S03")};
    std::cout << std::boolalpha << "Paso 3: S03 ausente=" << (ausente == stock.end()) << "; claves=" << stock.size() << '\n';
    std::set<std::string> ids;
    const std::vector<std::string> entrada{"S01", "S02", "S01"};
    int duplicados{0};
    for (const auto& id : entrada) { if (!ids.insert(id).second) { ++duplicados; } }
    std::cout << "Reto: repeticiones detectadas=" << duplicados << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u16_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u16_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u16_sol.exe` |

Salida esperada:

```text
Paso 1: claves=2
Paso 2: S02 tiene cero=0
Paso 3: S03 ausente=true; claves=2
Reto: repeticiones detectadas=1
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2016%20%28Mapas%2C%20conjuntos%20e%20identidad%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
