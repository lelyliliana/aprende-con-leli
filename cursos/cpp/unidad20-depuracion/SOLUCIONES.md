# Soluciones razonadas de la Unidad 20

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Contar recorrido lineal

Se examinan 15 posiciones contando desde 0. El contador no es el índice ni una medida directa de tiempo.

## Paso 2. Contrastar binaria

Se visitan 8, 12, 14: tres posiciones. La implementación evita calcular medio como una suma potencialmente grande y usa inicio+(fin-inicio)/2.

## Paso 3. Comparar resultado

Las dos devuelven encontrado=true. Sus costes observados difieren en este caso, pero no se deduce una velocidad universal.

## Reto de transferencia. Gestionar ausencia

El resultado es false. Lo prueba un caso de ausencia además del caso exitoso; no se interpreta el fin del rango como un valor encontrado.

## Respuestas de autoevaluación

1. **¿Un sanitizador detecta todo error lógico?** No; una fórmula válida puede expresar mal la pregunta.
2. **¿Qué precondición tiene la binaria?** Un rango ordenado de forma compatible con sus comparaciones.
3. **¿Tres posiciones son tres milisegundos?** No; son la medida instrumentada en este programa.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <vector>
#include <cstddef>

struct Resultado { bool encontrado; std::size_t comparaciones; };
Resultado lineal(const std::vector<int>& valores, int objetivo) {
    std::size_t comparaciones{0};
    for (const int valor : valores) {
        ++comparaciones;
        if (valor == objetivo) { return {true, comparaciones}; }
    }
    return {false, comparaciones};
}
Resultado binaria(const std::vector<int>& valores, int objetivo) {
    std::size_t inicio{0};
    std::size_t fin{valores.size()};
    std::size_t comparaciones{0};
    while (inicio < fin) {
        const auto medio{inicio + (fin - inicio) / 2};
        ++comparaciones;
        if (valores.at(medio) == objetivo) { return {true, comparaciones}; }
        if (valores.at(medio) < objetivo) { inicio = medio + 1; }
        else { fin = medio; }
    }
    return {false, comparaciones};
}

int main() {
    const std::vector<int> datos{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    const auto a{lineal(datos, 14)};
    const auto b{binaria(datos, 14)};
    std::cout << "Paso 1: lineal=" << a.comparaciones << '\n';
    std::cout << "Paso 2: binaria=" << b.comparaciones << '\n';
    if (a.encontrado != b.encontrado) { return 1; }
    std::cout << "Paso 3: ambas encuentran el objetivo\n";
    const auto ausente{binaria(datos, 20)};
    std::cout << std::boolalpha << "Reto: objetivo ausente encontrado=" << ausente.encontrado << '\n';
    return ausente.encontrado ? 1 : 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u20_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u20_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u20_sol.exe` |

Salida esperada:

```text
Paso 1: lineal=15
Paso 2: binaria=3
Paso 3: ambas encuentran el objetivo
Reto: objetivo ausente encontrado=false
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2020%20%28Depuraci%C3%B3n%2C%20sanitizadores%20y%20coste%20de%20algoritmos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
