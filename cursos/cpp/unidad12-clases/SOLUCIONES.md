# Soluciones razonadas de la Unidad 12

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Construir

El estado inicial es 5. No se necesita una segunda llamada oculta para establecer la invariante.

## Paso 2. Retirar una cantidad válida

La cantidad pasa a 3. El resultado representa el estado del stock, no una copia que deba asignarse después.

## Paso 3. Rechazar sin alterar

Se observa invalid_argument y el estado sigue 3. Ese caso comprueba la garantía concreta del rechazo.

## Reto de transferencia. Probar el límite

Queda 0 y la invariante sigue cumpliéndose. Un stock agotado no equivale a una cantidad desconocida.

## Respuestas de autoevaluación

1. **¿Qué es una invariante?** Una regla que el objeto válido conserva según su interfaz.
2. **¿Por qué validar antes de restar?** Para no dejar el estado modificado tras un rechazo.
3. **¿Una referencia de consulta prolonga la vida del objeto?** No; el observador necesita que el propietario siga existiendo.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <stdexcept>

class Stock {
    int cantidad_;
public:
    explicit Stock(int n) : cantidad_{n} { if (n < 0) { throw std::invalid_argument{"Negativo"}; } }
    int cantidad() const { return cantidad_; }
    void retirar(int n) {
        if (n < 0 || n > cantidad_) { throw std::invalid_argument{"Retiro inválido"}; }
        cantidad_ -= n;
    }
};

int main() {
    Stock stock{5};
    std::cout << "Paso 1: inicial=" << stock.cantidad() << '\n';
    stock.retirar(2);
    std::cout << "Paso 2: tras retirar 2=" << stock.cantidad() << '\n';
    try { stock.retirar(4); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: rechazo conserva=" << stock.cantidad() << '\n'; }
    stock.retirar(3);
    std::cout << "Reto: retirar exactamente lo disponible deja=" << stock.cantidad() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u12_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u12_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u12_sol.exe` |

Salida esperada:

```text
Paso 1: inicial=5
Paso 2: tras retirar 2=3
Paso 3: rechazo conserva=3
Reto: retirar exactamente lo disponible deja=0
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2012%20%28Clases%2C%20constructores%20e%20invariantes%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
