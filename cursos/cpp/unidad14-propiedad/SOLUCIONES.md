# Soluciones razonadas de la Unidad 14

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Crear propietario

El objeto contiene 9 y el propietario tiene la responsabilidad de liberarlo.

## Paso 2. Transferir

El origen queda vacío para unique_ptr. No se intentó crear un segundo dueño independiente.

## Paso 3. Consultar el destino

El entero continúa existiendo bajo el dueño nuevo hasta su liberación. Movimiento de propiedad no significa destrucción inmediata del recurso.

## Reto de transferencia. Componer

Hay dos propietarios y la suma es 10. Las liberaciones siguen la vida útil de los objetos estándar sin un ciclo de delete manual.

## Respuestas de autoevaluación

1. **¿unique_ptr se puede copiar?** No; expresa propiedad exclusiva.
2. **¿Todos los tipos movidos quedan vacíos?** No; depende de las garantías del tipo.
3. **¿Por qué no recorrer unique_ptr por valor?** Eso intentaría una copia del propietario en ese recorrido.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <memory>
#include <utility>
#include <vector>

int main() {
    auto a{std::make_unique<int>(9)};
    std::cout << "Paso 1: valor=" << *a << '\n';
    auto b{std::move(a)};
    std::cout << std::boolalpha << "Paso 2: origen vacío=" << (!a) << '\n';
    std::cout << "Paso 3: destino=" << *b << '\n';
    std::vector<std::unique_ptr<int>> lista;
    lista.push_back(std::move(b));
    lista.push_back(std::make_unique<int>(1));
    int suma{0};
    for (const auto& p : lista) { suma += *p; }
    std::cout << "Reto: propietarios=" << lista.size() << "; suma=" << suma << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u14_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u14_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u14_sol.exe` |

Salida esperada:

```text
Paso 1: valor=9
Paso 2: origen vacío=true
Paso 3: destino=9
Reto: propietarios=2; suma=10
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2014%20%28RAII%2C%20std%3A%3Aunique_ptr%20y%20movimiento%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
