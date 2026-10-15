# Soluciones razonadas de la Unidad 03

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Validar 60

60&gt;=0 &&60&lt;=100 es true. Esa condición admite el dato; no lo clasifica todavía.

## Paso 2. Clasificar el límite

60&gt;=60 es true y debe aprobar. Un ejemplo solo con 80 no descubriría un umbral implementado de forma exclusiva.

## Paso 3. Rechazar 101

101 supera 100 y no se clasifica como aprobado. La solución separa la condición de dominio de la categoría posterior.

## Reto de transferencia. Gestionar una opción desconocida

Z entra en default. Se comunica opción no admitida; no se interpreta como B ni se deja una variable sin inicializar.

## Respuestas de autoevaluación

1. **¿Qué combina &&?** Dos condiciones que deben cumplirse simultáneamente.
2. **¿Por qué probar 60?** Distingue un límite inclusivo de uno exclusivo.
3. **¿Qué hace break en switch?** Sale del switch desde ese caso, evitando continuar por caída.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>

int main() {
    const int puntaje{60};
    if (puntaje >= 0 && puntaje <= 100) {
        std::cout << "Paso 1: puntaje dentro del dominio\n";
    }
    if (puntaje >= 60) {
        std::cout << "Paso 2: el límite 60 se aprueba\n";
    }
    const int fuera{101};
    if (fuera < 0 || fuera > 100) {
        std::cout << "Paso 3: 101 se rechaza antes de clasificar\n";
    }
    const char opcion{'Z'};
    switch (opcion) {
        case 'A': std::cout << "Consultar\n"; break;
        case 'B': std::cout << "Registrar\n"; break;
        default: std::cout << "Reto: Z no es una opción admitida\n"; break;
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u03_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u03_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u03_sol.exe` |

Salida esperada:

```text
Paso 1: puntaje dentro del dominio
Paso 2: el límite 60 se aprueba
Paso 3: 101 se rechaza antes de clasificar
Reto: Z no es una opción admitida
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2003%20%28Condiciones%2C%20decisiones%20y%20l%C3%ADmites%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
