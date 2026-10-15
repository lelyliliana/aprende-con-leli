# Soluciones razonadas de la Unidad 05

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Conservar la entrada

La cadena original queda "7". No se sustituye por un entero hasta definir una interpretación; puedes registrar el texto si algo falla.

## Paso 2. Interpretar el entero

El valor es 7, está en 0 a 40 y no quedan caracteres no blancos. El programa puede calcular con esa cantidad admitida.

## Paso 3. Producir minutos

Se obtienen 420 minutos. No se hace el cálculo cuando una precondición de lectura o dominio falla.

## Reto de transferencia. Rechazar un prefijo engañoso

La extracción puede obtener 7, pero la revisión posterior detecta abc. Se rechaza la línea completa en vez de presentar 420 minutos para un texto no admitido.

## Respuestas de autoevaluación

1. **¿getline conserva espacios internos?** Sí; lee una línea completa sin su delimitador de salto.
2. **¿Una conversión numérica exitosa valida el rango?** No; 41 se interpreta como entero pero incumple el dominio de este ejemplo.
3. **¿Por qué probar caracteres sobrantes?** Para no aceptar solamente un prefijo numérico de una entrada inválida.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <string>
#include <sstream>

int main() {
    const std::string linea{"7"};
    std::istringstream lector{linea};
    int horas{0};
    if (!(lector >> horas)) { return 1; }
    lector >> std::ws;
    if (!lector.eof() || horas < 0 || horas > 40) { return 1; }
    std::cout << "Paso 1: la línea conservada es " << linea << '\n';
    std::cout << "Paso 2: entero interpretado=" << horas << '\n';
    std::cout << "Paso 3: minutos=" << horas * 60 << '\n';
    std::istringstream con_sufijo{"7abc"};
    int candidato{0};
    if (!(con_sufijo >> candidato)) { return 1; }
    con_sufijo >> std::ws;
    if (!con_sufijo.eof()) {
        std::cout << "Reto: 7abc se rechaza porque sobran caracteres\n";
    } else { return 1; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u05_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u05_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u05_sol.exe` |

Salida esperada:

```text
Paso 1: la línea conservada es 7
Paso 2: entero interpretado=7
Paso 3: minutos=420
Reto: 7abc se rechaza porque sobran caracteres
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2005%20%28Entrada%20de%20texto%20y%20conversi%C3%B3n%20controlada%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
