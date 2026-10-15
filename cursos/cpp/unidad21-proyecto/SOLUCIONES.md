# Soluciones razonadas de la Unidad 21

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Leer y definir

Hay 6 productos con códigos únicos y cantidades y precios conocidos. El cero de CAJA es un stock válido, no una ausencia.

## Paso 2. Calcular en centavos

El total es 55000. Los dominios acotan productos y sumas para su representación; cada término mantiene la unidad monetaria menor.

## Paso 3. Observar un rechazo

La validación interrumpe la operación normal. Las pruebas de CLI comprueban además que no se cree la carpeta nueva para una entrada rechazada.

## Reto de transferencia. Conservar y explicar

Se recupera 55000 sin modificar la fuente. La aplicación es local, con formato delimitado restringido y sin transacciones de archivos ni concurrencia. La explicación debe relacionar esos límites con el uso previsto.

## Respuestas de autoevaluación

1. **¿Por qué no convertir vacío en cero?** Falta un dato requerido; cero afirmaría una cantidad no observada.
2. **¿El reporte tiene el esquema de entrada?** No; añade subtotal y tiene cuatro columnas.
3. **¿Qué indica código 2?** La operación no completó su resultado normal y ofrece un diagnóstico.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include "inventario.hpp"
#include <iostream>
#include <stdexcept>
#include <vector>

int main() {
    const auto productos{inventario::leer("datos/inventario.csv")};
    std::cout << "Paso 1: registros=" << productos.size() << '\n';
    const auto valor{inventario::total(productos)};
    std::cout << "Paso 2: total=" << valor << " centavos\n";
    auto copia{productos};
    copia.at(0).cantidad = -1;
    try { inventario::validar(copia); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: cantidad negativa rechazada\n"; }
    const auto de_nuevo{inventario::leer("datos/inventario.csv")};
    if (inventario::total(de_nuevo) != valor) { return 1; }
    std::cout << "Reto: fuente conservada y cálculo repetible\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u21_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u21_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u21_sol.exe` |

Salida esperada:

```text
Paso 1: registros=6
Paso 2: total=55000 centavos
Paso 3: cantidad negativa rechazada
Reto: fuente conservada y cálculo repetible
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2021%20%28Proyecto%20integrador%3A%20inventario%20explicado%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
