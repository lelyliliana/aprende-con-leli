# Soluciones razonadas de la Unidad 15

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Calcular un área concreta

El área es 6 unidades cuadradas en este caso construido. El resultado procede de la implementación concreta.

## Paso 2. Usar la interfaz

La referencia conserva el comportamiento concreto y devuelve 6. El objeto original sigue siendo quien posee su estado.

## Paso 3. Componer propietarios

La suma es 14. La colección administra propietarios exclusivos y la interfaz permite la operación común.

## Reto de transferencia. Liberar la colección

Quedan cero propietarios en la colección y sus recursos se liberan mediante los destructores correspondientes. Eso no destruye el rectángulo automático independiente creado al inicio.

## Respuestas de autoevaluación

1. **¿Qué exige =0 en la interfaz?** Que exista una implementación concreta para usar una instancia no abstracta.
2. **¿Qué verifica override?** Que la función sobrescribe una operación virtual compatible.
3. **¿Por qué el proyecto no necesita herencia entre productos?** Su diferencia está en datos; registros y funciones expresan su contrato sin una jerarquía artificial.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <memory>
#include <vector>

class Figura {
public:
    virtual ~Figura() = default;
    virtual int area() const = 0;
};
class Rectangulo final : public Figura {
    int ancho_;
    int alto_;
public:
    Rectangulo(int ancho, int alto) : ancho_{ancho}, alto_{alto} {}
    int area() const override { return ancho_ * alto_; }
};

int main() {
    const Rectangulo rectangulo{2, 3};
    std::cout << "Paso 1: área concreta=" << rectangulo.area() << '\n';
    const Figura& interfaz{rectangulo};
    std::cout << "Paso 2: área por interfaz=" << interfaz.area() << '\n';
    std::vector<std::unique_ptr<Figura>> figuras;
    figuras.push_back(std::make_unique<Rectangulo>(2, 3));
    figuras.push_back(std::make_unique<Rectangulo>(4, 2));
    int total{0};
    for (const auto& f : figuras) { total += f->area(); }
    std::cout << "Paso 3: suma=" << total << '\n';
    figuras.clear();
    std::cout << "Reto: propietarios restantes=" << figuras.size() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u15_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u15_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u15_sol.exe` |

Salida esperada:

```text
Paso 1: área concreta=6
Paso 2: área por interfaz=6
Paso 3: suma=14
Reto: propietarios restantes=0
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2015%20%28Interfaces%20y%20polimorfismo%20con%20prop%C3%B3sito%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
