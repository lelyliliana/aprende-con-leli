# Unidad 20. Depuración, sanitizadores y coste de algoritmos

[Anterior](../unidad19-cmake-pruebas/README.md) · [Índice](../README.md) · [Siguiente](../unidad21-proyecto/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Contar recorrido lineal.
- Contrastar binaria.
- Comparar resultado.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Depurar es explicar una diferencia observable

Un programa puede compilar, terminar sin error y calcular algo distinto de lo pedido. La depuración comienza con entrada, esperado y observado. Reduce el problema a un caso que permita seguir estados y decisiones antes de cambiar varias partes a la vez.

### Un caso mínimo de error lógico

El precio es 100, la cantidad 3 y el descuento por unidad 10. La especificación pide (100-10)×3=270. La expresión incorrecta 100×3-10 devuelve 290 porque resta un único descuento total. No existe un fallo de memoria en esa cuenta; el error está en traducir la regla del problema.

El segundo ejemplo conserva esa expresión con el nombre incorrecto para demostrar una prueba que la detecta, y después calcula la corrección. No es un programa de facturación listo para reutilizar: los valores y el descuento tienen un dominio pequeño y explícito de práctica.

### Sigue el programa con un depurador

Construye una configuración Debug. Coloca un punto de interrupción antes del cálculo, inicia la ejecución y consulta precio, cantidad, descuento_por_unidad. Avanza una instrucción y compara incorrecto con esperado. Después de corregir, vuelve a ejecutar el caso y las pruebas relacionadas. Puedes hacerlo desde un editor que integre GDB, LLDB o el depurador de Visual Studio; la ubicación de sus controles varía.

Un punto de interrupción no demuestra corrección de lo que no ejecutaste. Su propósito es observar un recorrido y contrastar una hipótesis sobre el fallo. Conserva el caso que lo detecta para que no dependa de tu memoria la próxima revisión.

### Sanitizadores complementan las pruebas

AddressSanitizer y UndefinedBehaviorSanitizer instrumentan ejecuciones para detectar determinadas condiciones de memoria y comportamiento indefinido. El proyecto permite activar su configuración en un compilador compatible. Un resultado limpio se refiere a los recorridos ejecutados y no certifica que toda entrada sea segura.

No se ejecutan punteros colgantes deliberadamente como parte normal del curso. Estudiamos su causa y alternativas válidas; la instrumentación permite buscar errores accidentales en las rutas comprobadas. Un error lógico de descuento puede no ser detectado por estos sanitizadores porque la operación es válida en términos del lenguaje.

### Coste no es solo tiempo de una ejecución

La búsqueda lineal examina posiciones hasta encontrar el objetivo o terminar. La binaria descarta parte de un rango ordenado en cada vuelta. Su precondición de orden importa: no apliques la segunda a datos arbitrarios porque haya usado menos pasos en una demostración.

El primer ejemplo cuenta posiciones examinadas, no todos los operadores de comparación ni milisegundos. Para 16 valores y objetivo 14, la lineal visita 15 posiciones y la binaria 3. Es una observación de estos algoritmos y este caso. En general se estudian crecimientos lineal y logarítmico, pero eso no promete una aceleración fija para cualquier tamaño, máquina o coste de preparación.

### Elige una medida que responda la pregunta

Si ordenas antes de una sola búsqueda, también debes considerar ese trabajo. Si haces muchas búsquedas sobre una colección ya ordenada, el equilibrio cambia. Medir tiempo exigiría repeticiones, control de ruido, datos representativos y una metodología. No publicamos una razón de rendimiento universal a partir de una medición aislada.

## Ejemplo 1. Contar pasos sin prometer tiempos

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

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
    const std::vector<int> ordenados{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    const auto a{lineal(ordenados, 14)};
    const auto b{binaria(ordenados, 14)};
    if (!a.encontrado || !b.encontrado) { return 1; }
    std::cout << "Lineal: " << a.comparaciones << " posiciones examinadas\n";
    std::cout << "Binaria: " << b.comparaciones << " posiciones examinadas\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u20_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u20_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u20_e01.exe` |

Salida esperada:

```text
Lineal: 15 posiciones examinadas
Binaria: 3 posiciones examinadas
```

### Lectura paso a paso

Se utiliza un rango ordenado de 0 a 15. Cada algoritmo cuenta una posición examinada por paso de su lógica. El recorrido lineal llega a 14 después de 15 posiciones; el binario consulta 8, 12, 14 y termina en 3. No se afirma que haya realizado solo tres operadores primitivos.

## Ejemplo 2. Reducir un error lógico a un caso

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    const int precio{100};
    const int cantidad{3};
    const int descuento_por_unidad{10};
    const int incorrecto{precio * cantidad - descuento_por_unidad};
    const int esperado{270};
    if (incorrecto != esperado) {
        std::cout << "Caso que detecta el error: esperado=" << esperado << "; calculado=" << incorrecto << '\n';
    }
    const int corregido{(precio - descuento_por_unidad) * cantidad};
    if (corregido != esperado) { return 1; }
    std::cout << "Corrección: " << corregido << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u20_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u20_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u20_e02.exe` |

Salida esperada:

```text
Caso que detecta el error: esperado=270; calculado=290
Corrección: 270
```

### Lectura paso a paso

El caso muestra 290 frente a 270 y localiza la diferencia de regla. La versión corregida agrupa el descuento por unidad antes de multiplicar. Un diagnóstico útil relaciona especificación, estado y operación; no solo dice que el resultado salió mal.

## Experimenta

Busca un objetivo ausente y al inicio del rango. Predice qué sucede con el conteo lineal y si ambos deben coincidir en presencia. Luego altera el orden en una copia y explica por qué ya no puedes aplicar la precondición de búsqueda binaria.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Cambiar varias líneas sin un caso reproducible | Conserva entrada, esperado y estado observado. |
| Confundir pasos con milisegundos | Declara exactamente qué instrumentaste. |
| Aplicar búsqueda binaria a datos no ordenados | Comprueba la precondición antes de interpretar su resultado. |

## Autoevaluación

1. ¿Un sanitizador detecta todo error lógico?
2. ¿Qué precondición tiene la binaria?
3. ¿Tres posiciones son tres milisegundos?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad19-cmake-pruebas/README.md) · [Índice](../README.md) · [Siguiente](../unidad21-proyecto/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2020%20%28Depuraci%C3%B3n%2C%20sanitizadores%20y%20coste%20de%20algoritmos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
