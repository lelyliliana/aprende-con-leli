# Soluciones razonadas de la Unidad 02

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Convertir unidades

El resultado es 105 minutos. double representa la entrada elegida; el factor 60 tiene unidad minutos/hora. El nombre no sustituye una explicación de esa operación.

## Paso 2. Conservar un ID

std::string{"007"} conserva la representación; un entero 7 no conserva ceros iniciales. El identificador no se convierte en una magnitud por contener dígitos.

## Paso 3. Contrastar divisiones

La primera produce 3 y la segunda 3.5. No basta que la variable receptora sea double si ambos operandos ya realizaron división entera.

## Reto de transferencia. Calcular en unidades menores

El total es 5997 centavos. No hubo redondeo de un decimal binario en esta operación entera. Para datos externos todavía debes validar dominio y representabilidad.

## Respuestas de autoevaluación

1. **¿auto elimina el tipo?** No; lo deduce desde la expresión inicializadora.
2. **¿Cambiar horas recalcula minutos?** No; debes evaluar de nuevo la operación.
3. **¿Un entero negativo convertido a unsigned se rechaza?** No por esa conversión; valida el dominio antes de cambiar representación.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <string>
#include <cstdint>

int main() {
    const double horas{1.75};
    const double minutos{horas * 60};
    std::cout << "Paso 1: " << minutos << " minutos\n";
    const std::string codigo{"007"};
    std::cout << "Paso 2: ID=" << codigo << '\n';
    std::cout << "Paso 3: 7/2=" << 7 / 2 << "; 7.0/2=" << 7.0 / 2 << '\n';
    const std::int64_t precio{1999};
    const std::int64_t cantidad{3};
    std::cout << "Reto: total=" << precio * cantidad << " centavos\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u02_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u02_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u02_sol.exe` |

Salida esperada:

```text
Paso 1: 105 minutos
Paso 2: ID=007
Paso 3: 7/2=3; 7.0/2=3.5
Reto: total=5997 centavos
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2002%20%28Variables%2C%20tipos%2C%20constantes%20y%20operaciones%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
