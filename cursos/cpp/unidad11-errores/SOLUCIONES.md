# Soluciones razonadas de la Unidad 11

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Conservar cero

Hay valor y es 0. No se usa el número 0 como marca de conversión fallida.

## Paso 2. Rechazar sufijo

Se rechaza aunque el prefijo 7 sea representable. La cadena completa incumple el contrato.

## Paso 3. Validar dominio

41 puede ser entero pero no horas admitidas. El catch previsto confirma que no se continuó con un resultado normal.

## Reto de transferencia. Revisar ausencia y rango de tipo

Ambos producen ausencia en esta interfaz. La solución no inventa un valor para seguir calculando.

## Respuestas de autoevaluación

1. **¿Un optional con 0 es falso?** No; su conversión a bool representa presencia.
2. **¿Qué revisas tras from_chars?** Código de error y consumo completo.
3. **¿Qué evita un catch que finge éxito?** Nada útil: puede ocultar una entrada rechazada; conserva un diagnóstico coherente.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <optional>
#include <string>
#include <charconv>
#include <system_error>
#include <stdexcept>

std::optional<int> entero(const std::string& texto) {
    int n{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), n)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) { return std::nullopt; }
    return n;
}
void validar(int n) { if (n < 0 || n > 40) { throw std::invalid_argument{"Fuera de dominio"}; } }

int main() {
    const auto a{entero("0")};
    if (!a || *a != 0) { return 1; }
    std::cout << "Paso 1: cero es un valor presente\n";
    if (entero("7abc")) { return 1; }
    std::cout << "Paso 2: sufijo inválido rechazado\n";
    try { validar(41); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: 41 fuera del dominio\n"; }
    if (entero("") || entero("9999999999999999999999999")) { return 1; }
    std::cout << "Reto: vacío y entero fuera de representación rechazados\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u11_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u11_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u11_sol.exe` |

Salida esperada:

```text
Paso 1: cero es un valor presente
Paso 2: sufijo inválido rechazado
Paso 3: 41 fuera del dominio
Reto: vacío y entero fuera de representación rechazados
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2011%20%28Errores%2C%20std%3A%3Aoptional%20y%20excepciones%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
