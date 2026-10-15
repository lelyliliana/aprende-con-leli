# Soluciones razonadas de la Unidad 07

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Conservar 007

Se conservan los tres bytes ASCII y la representación 007. Su función es identificar, no expresar siete unidades.

## Paso 2. Separar dos campos

El prefijo es S01 y el sufijo 12 como texto. El separador no forma parte de ninguno de los dos campos.

## Paso 3. Gestionar ausencia de separador

find devuelve npos. La decisión debe rechazar la estructura o elegir otra interpretación; no se fabrica un segundo campo.

## Reto de transferencia. Aplicar formato declarado

La cadena se rechaza por su espacio interior. Esta política se refiere aun código ASCII, no ala validez general de una frase en español.

## Respuestas de autoevaluación

1. **¿El sufijo 12 ya es un número?** No; substr devuelve texto.
2. **¿Qué representa npos?** Que no se encontró la búsqueda en la cadena.
3. **¿size cuenta grafemas UTF-8?** No; cuenta elementos char, bytes en las plataformas utilizadas.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <string>

int main() {
    const std::string codigo{"007"};
    std::cout << "Paso 1: " << codigo << " conserva " << codigo.size() << " bytes ASCII\n";
    const std::string linea{"S01;12"};
    const auto p{linea.find(';')};
    if (p == std::string::npos) { return 1; }
    std::cout << "Paso 2: " << linea.substr(0, p) << " / " << linea.substr(p + 1) << '\n';
    const std::string sin_separador{"S01"};
    std::cout << std::boolalpha << "Paso 3: separador ausente=" << (sin_separador.find(';') == std::string::npos) << '\n';
    const std::string invalido{"S 01"};
    bool valido{!invalido.empty()};
    for (const char c : invalido) {
        if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-')) { valido = false; }
    }
    std::cout << "Reto: código con espacio admitido=" << valido << '\n';
    return valido ? 1 : 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u07_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u07_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u07_sol.exe` |

Salida esperada:

```text
Paso 1: 007 conserva 3 bytes ASCII
Paso 2: S01 / 12
Paso 3: separador ausente=true
Reto: código con espacio admitido=false
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2007%20%28Texto%20con%20std%3A%3Astring%20y%20contratos%20de%20formato%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
