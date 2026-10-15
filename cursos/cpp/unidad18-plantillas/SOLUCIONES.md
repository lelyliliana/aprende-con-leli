# Soluciones razonadas de la Unidad 18

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Usar una plantilla

El resultado es 9 de tipo int. La operación condicional selecciona según a&lt;b.

## Paso 2. Probar empate

Devuelve 5. El algoritmo no necesita inventar otro resultado para un empate.

## Paso 3. Comprobar restricción

La condición !`std::integral<double>` es verdadera y permite compilar esa afirmación. No es una validación de un número decimal en ejecución.

## Reto de transferencia. Reutilizar con long

Se obtiene 12 como long. La familia de funciones conserva una intención común sin copiar el cuerpo por cada tipo.

## Respuestas de autoevaluación

1. **¿Un concepto integral exige valor positivo?** No; restringe el tipo, no ese dominio.
2. **¿Qué falta si conoces la declaración pero no enlazas la definición?** La implementación necesaria para completar el programa.
3. **¿Qué protege un include guard?** El procesamiento repetido de esa cabecera dentro de una unidad de traducción.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <concepts>

template<std::integral T>
T mayor(T a, T b) { return a < b ? b : a; }

int main() {
    std::cout << "Paso 1: mayor=" << mayor(4, 9) << '\n';
    std::cout << "Paso 2: empate=" << mayor(5, 5) << '\n';
    static_assert(!std::integral<double>);
    std::cout << "Paso 3: double fuera del concepto integral\n";
    const long a{12};
    const long b{7};
    std::cout << "Reto: misma plantilla con long=" << mayor(a, b) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u18_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u18_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u18_sol.exe` |

Salida esperada:

```text
Paso 1: mayor=9
Paso 2: empate=5
Paso 3: double fuera del concepto integral
Reto: misma plantilla con long=12
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2018%20%28Plantillas%2C%20conceptos%20y%20varios%20archivos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
