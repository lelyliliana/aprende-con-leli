# Soluciones razonadas de la Unidad 04

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Sumar 1 a 5

Se obtienen 1, 3, 6, 10, 15 y el final 15. El contador y el acumulador no representan la misma magnitud.

## Paso 2. Terminar una cuenta regresiva

Después de tres decrementos queda 0. Si no reduces el contador dentro del while, esa condición no cambia por sí sola.

## Paso 3. Contar [0, 5)

Son cinco valores: 0, 1, 2, 3, 4. La condición se comprueba otra vez con 5 y no ejecuta ese cuerpo.

## Reto de transferencia. Sumar pares hasta 10

2+4+6+8+10=30. Se recorren diez valores, se seleccionan cinco y se suma treinta; las tres cuentas deben distinguirse.

## Respuestas de autoevaluación

1. **¿Puede while ejecutar cero veces?** Sí, si su condición inicial es falsa.
2. **¿Dónde inicializas una suma persistente?** Antes del ciclo.
3. **¿Qué diferencia break y continue?** break sale del ciclo; continue pasa a la siguiente vuelta.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>

int main() {
    int suma{0};
    for (int n{1}; n <= 5; ++n) { suma += n; }
    std::cout << "Paso 1: suma de 1 a 5=" << suma << '\n';
    int contador{3};
    while (contador > 0) { --contador; }
    std::cout << "Paso 2: contador final=" << contador << '\n';
    int cantidad{0};
    for (int n{0}; n < 5; ++n) { ++cantidad; }
    std::cout << "Paso 3: [0,5) tiene " << cantidad << " iteraciones\n";
    int suma_pares{0};
    for (int n{1}; n <= 10; ++n) {
        if (n % 2 == 0) { suma_pares += n; }
    }
    std::cout << "Reto: pares entre 1 y 10 suman " << suma_pares << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u04_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u04_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u04_sol.exe` |

Salida esperada:

```text
Paso 1: suma de 1 a 5=15
Paso 2: contador final=0
Paso 3: [0,5) tiene 5 iteraciones
Reto: pares entre 1 y 10 suman 30
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2004%20%28Ciclos%2C%20acumuladores%20y%20trazas%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
