# Unidad 18. Plantillas, conceptos y varios archivos

[Anterior](../unidad17-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-cmake-pruebas/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Usar una plantilla.
- Probar empate.
- Comprobar restricción.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Reutilizar un algoritmo y organizar una construcción

Una plantilla describe una familia de definiciones parametrizada por tipos u otros parámetros admitidos. No convierte una función en un programa que acepte cualquier objeto sin reglas. El algoritmo debe tener sentido para las operaciones que utiliza y para el contrato que comunica.

### Un parámetro de tipo

`template<std::integral T>` introduce T restringido por el concepto integral. mayor recibe dos valores del mismo T y devuelve uno de ese tipo. La llamada con int utiliza esa especialización; con long, otra instancia apropiada. El cuerpo compara a&lt;b y el operador condicional devuelve b si se cumple o a en otro caso.

std::integral verifica una propiedad del tipo durante compilación. No comprueba que una cantidad sea positiva, que un ID sea único ni que un número describa una medición real. Un concepto expresa requisitos de interfaz/tipo, mientras el dominio del problema puede necesitar comprobaciones en ejecución.

static_assert realiza una comprobación en compilación. El ejemplo afirma que int cumple integral y double no. No hay una instrucción ejecutable que imprima esos resultados: si la condición fuera falsa, no se produciría el programa esperado.

### Deduce sin borrar las diferencias

mayor(3, 7) deduce T=int. Mezclar tipos puede requerir una elección explícita de representación o un diseño distinto; no lo resuelvas convirtiendo todo a un tipo que pierda información. La plantilla pequeña sirve para entender deducción y restricciones antes de diseñar bibliotecas genéricas.

### Una cabecera declara una interfaz

El segundo ejemplo separa operaciones.hpp y operaciones.cpp. La cabecera declara int sumar(int, int), informando la firma al archivo que llama. La fuente aporta la definición. #include incorpora texto durante preprocesamiento; no enlaza por sí mismo la definición de otra fuente ya compilada.

La meta u18_e02 compila su main y operaciones.cpp y enlaza ambas piezas. Si compilaras solo el main, podrías conocer la declaración y aun así fallar al enlazar por una definición ausente. Distingue ese error de un include cuyo archivo no existe.

### Evita definiciones incompatibles

Las protecciones de inclusión impiden procesar repetidamente el contenido de una cabecera dentro de una unidad de traducción. No autorizan múltiples definiciones ordinarias incompatibles repartidas por el programa. En este diseño la función no inline se define una vez en su fuente.

Las definiciones de plantillas utilizadas mediante instanciación suelen mantenerse visibles en cabeceras, salvo diseños que controlen explícitamente sus instancias. Separar una plantilla en un cpp sin considerar esa visibilidad puede producir fallos de enlace. Aquí estudiamos una plantilla pequeña y una separación ordinaria antes de combinar ambas técnicas.

### Haz visible la dependencia

La biblioteca del proyecto declara Producto y sus operaciones en inventario.hpp y las define en inventario.cpp. main depende de esa interfaz. Cambiar una implementación no exige copiarla en cada ejemplo; las metas enlazan la misma biblioteca y las pruebas contrastan su comportamiento.

## Ejemplo 1. Una función genérica restringida

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <concepts>

template<std::integral T>
T mayor(T a, T b) { return a < b ? b : a; }

int main() {
    std::cout << "Mayor entero: " << mayor(3, 7) << '\n';
    static_assert(std::integral<int>);
    static_assert(!std::integral<double>);
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u18_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u18_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u18_e01.exe` |

Salida esperada:

```text
Mayor entero: 7
```

### Lectura paso a paso

mayor(3, 7) devuelve 7. Las dos comprobaciones static_assert se resuelven al compilar. El ejemplo introduce una familia acotada a tipos integrales y no pretende modelar todas las comparaciones posibles entre cantidades.

## Ejemplo 2. Separar declaración y definición

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include "operaciones.hpp"

int main() {
    std::cout << "Total enlazado: " << sumar(3, 4) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u18_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u18_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u18_e02.exe` |

Salida esperada:

```text
Total enlazado: 7
```

### Lectura paso a paso

La declaración vive en operaciones.hpp y la definición en operaciones.cpp. La construcción del curso registra ambas fuentes para u18_e02; el ejecutable imprime 7. Abre los tres archivos para reconocer qué se declara, qué se define y qué se llama.

## Los archivos que completa la segunda meta

El programa anterior incluye una declaración y enlaza su definición. Estos fragmentos son archivos auxiliares de u18_e02, no programas independientes con main:

[operaciones.hpp](ejemplos/operaciones.hpp)

```cpp
#ifndef CURSO_CPP_OPERACIONES_HPP
#define CURSO_CPP_OPERACIONES_HPP
int sumar(int a, int b);
#endif
```

[operaciones.cpp](ejemplos/operaciones.cpp)

```cpp
#include "operaciones.hpp"
int sumar(int a, int b) { return a + b; }
```

## Experimenta

Cambia las dos entradas de mayor por long del mismo tipo y comprueba la deducción. Después, en una copia de práctica, observa el diagnóstico al intentar double. No elimines el concepto para esconder un requisito incumplido sin decidir qué algoritmo quieres ofrecer.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Confundir concepto con validación de dominio | Revisa por separado tipo y valor. |
| Creer que include enlaza otra fuente | Registra las definiciones requeridas en la construcción. |
| Definir una función ordinaria varias veces | Separa interfaz y definición respetando sus reglas. |

## Autoevaluación

1. ¿Un concepto integral exige valor positivo?
2. ¿Qué falta si conoces la declaración pero no enlazas la definición?
3. ¿Qué protege un include guard?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad17-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-cmake-pruebas/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2018%20%28Plantillas%2C%20conceptos%20y%20varios%20archivos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
