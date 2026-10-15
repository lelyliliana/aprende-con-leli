# Soluciones razonadas de la Unidad 01

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Identificar los archivos

El fuente es ejemplos/01.cpp; el ejecutable u01_e01 está bajo build/bin y lleva .exe en Windows. La configuración no es el ejecutable ni el archivo .cpp se transforma por cambiar su extensión.

## Paso 2. Leer el punto de entrada

include aporta declaraciones; main inicia; las llaves forman el cuerpo; cout recibe la cadena; return 0 comunica éxito. La salida estándar puede redirigirse y no equivale necesariamente a una ventana gráfica.

## Paso 3. Predecir precedencia

3*4=12 y luego 2+12=14. La solución conserva un programa completo que compila; no depende de una consola con objetos anteriores.

## Reto de transferencia. Modificar el orden de la cuenta

El resultado es 20 porque primero se suma 2+3. La diferencia con 14 procede de la expresión. Debes guardar, reconstruir y ejecutar para observar el cambio.

## Respuestas de autoevaluación

1. **¿Compilar es ejecutar?** No; compilar traduce fuente y ejecutar utiliza el binario generado.
2. **¿Qué crea el salto visible?** \n dentro de la cadena, no la línea del editor.
3. **¿Qué debes hacer al cambiar el fuente?** Guardar y reconstruir antes de ejecutar el resultado nuevo.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>

int main() {
    std::cout << "Paso 1: este archivo es el código fuente.\n";
    std::cout << "Paso 2: main es el punto de entrada.\n";
    std::cout << "Paso 3: 2 + 3 * 4 = " << 2 + 3 * 4 << '\n';
    std::cout << "Reto: (2 + 3) * 4 = " << (2 + 3) * 4 << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u01_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u01_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u01_sol.exe` |

Salida esperada:

```text
Paso 1: este archivo es el código fuente.
Paso 2: main es el punto de entrada.
Paso 3: 2 + 3 * 4 = 14
Reto: (2 + 3) * 4 = 20
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2001%20%28Compilar%20y%20ejecutar%20el%20primer%20programa%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
