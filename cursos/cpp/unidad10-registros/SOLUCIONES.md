# Soluciones razonadas de la Unidad 10

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Construir un producto

El código identifica, cantidad cuenta unidades y precio_centavos describe una unidad monetaria menor por unidad. Son campos relacionados, no nombres intercambiables.

## Paso 2. Calcular subtotal

El subtotal es 3000 centavos. El cálculo usa un dominio pequeño construido; para datos externos deberán revisarse rango y representación.

## Paso 3. Modelar un estado

Estado::disponible comunica la alternativa sin usar un número arbitrario. La comparación devuelve true para ese estado concreto.

## Reto de transferencia. Resumir dos registros

Los subtotales 3000 y 6000 producen 9000 centavos. Mantener código, cantidad y precio juntos permite revisar cada término.

## Respuestas de autoevaluación

1. **¿struct valida cantidades automáticamente?** No; declara campos y tipos.
2. **¿Un precio repetido duplica identidad?** No; la identidad depende de la clave elegida.
3. **¿Qué comunica enum class?** Un tipo con alternativas nombradas y acotadas en el modelo.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <string>
#include <vector>

struct Producto { std::string codigo; int cantidad; int precio_centavos; };
enum class Estado { disponible, prestado };

int main() {
    const Producto sensor{"S01", 2, 1500};
    std::cout << "Paso 1: ID=" << sensor.codigo << '\n';
    std::cout << "Paso 2: subtotal=" << sensor.cantidad * sensor.precio_centavos << '\n';
    const Estado estado{Estado::disponible};
    std::cout << std::boolalpha << "Paso 3: disponible=" << (estado == Estado::disponible) << '\n';
    const std::vector<Producto> todos{sensor, {"S02", 3, 2000}};
    int total{0};
    for (const auto& p : todos) { total += p.cantidad * p.precio_centavos; }
    std::cout << "Reto: total=" << total << " centavos\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u10_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u10_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u10_sol.exe` |

Salida esperada:

```text
Paso 1: ID=S01
Paso 2: subtotal=3000
Paso 3: disponible=true
Reto: total=9000 centavos
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2010%20%28Registros%2C%20enumeraciones%20y%20modelos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
