# Unidad 03. Condiciones, decisiones y límites

[Anterior](../unidad02-tipos/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-ciclos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Validar 60.
- Clasificar el límite.
- Rechazar 101.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Una decisión convierte una regla en caminos

if recibe una condición y ejecuta un bloque cuando es verdadera. else proporciona otro camino. Antes de escribir una clasificación, declara su dominio: un puntaje debe estar entre 0 y 100. Si primero preguntas si es mayor o igual que 60, 101 quedaría aprobado aunque fuera una entrada imposible bajo ese contrato.

### Ordena las preguntas

La primera condición del ejemplo usa puntaje&lt;0 || puntaje&gt;100. || significa que basta uno de los casos para estar fuera. Solo en el else se clasifica el valor ya admitido. El siguiente umbral, puntaje&gt;=60, incluye exactamente 60. Cambiarlo por&gt;60 modificaría la política en el límite.

| Entrada | Primera decisión | Clasificación posterior |
|---|---|---|
| -1 | Fuera | No se clasifica |
| 59 | Dentro | Por mejorar |
| 60 | Dentro | Aprobado |
| 100 | Dentro | Aprobado |
| 101 | Fuera | No se clasifica |

### Combina sin ocultar la regla

&& exige ambas condiciones. Para admitir horas usamos horas&gt;=0 && horas&lt;=40. ! niega una condición lógica. Los operadores lógicos && y || incorporados realizan evaluación en cortocircuito: si la primera parte basta para decidir, no evalúan la segunda. Esto puede ser necesario para comprobar una precondición antes de una operación que la necesita, como que un denominador sea distinto de cero antes de dividir.

No escribas 0&lt;=horas&lt;=40 esperando la notación matemática encadenada. En C++ no expresa dos comparaciones simultáneas de esa manera. Declara las dos y combínalas. Usa paréntesis para hacer visible una intención que pueda resultar ambigua; no dependas de recordar precedencias en una regla complicada.

### Asignación no es comparación

= cambia un objeto; == compara valores. Un error al escribir la condición puede compilar y alterar una entrada. Las advertencias ayudan, pero debes leer el significado. Un booleano como dentro almacena una respuesta lógica; std::boolalpha permite mostrar true/false en lugar de 1/0 sin cambiar el valor.

### Selecciona categorías discretas

switch compara una expresión con etiquetas case. break termina ese caso; si lo omites puede continuar en el siguiente. default decide qué hacer cuando ninguna etiqueta corresponde. Para A, B y Z, la última debe producir un diagnóstico de opción desconocida en vez de inventar una acción.

switch no sustituye toda regla de rangos. Para puntajes continuos o intervalos con límites, if suele comunicar mejor la decisión. Elige la estructura por la pregunta que responde y no porque su forma sea más corta.

### Revisa fronteras antes de multiplicar casos

Un ejemplo en 80 muestra el camino normal, pero no distingue&gt; de&gt;=. Las pruebas 59/60 y 100/101 investigan precisamente esos límites. Mantener una tabla manual de decisiones permite detectar que el programa implementa una regla distinta de la que escribiste en palabras.

## Ejemplo 1. Validar el rango antes de clasificar

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    const int puntaje{80};
    if (puntaje < 0 || puntaje > 100) {
        std::cout << "Fuera del dominio\n";
    } else if (puntaje >= 60) {
        std::cout << "Aprobado\n";
    } else {
        std::cout << "Por mejorar\n";
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u03_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u03_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u03_e01.exe` |

Salida esperada:

```text
Aprobado
```

### Lectura paso a paso

Con 80 se descarta el bloque fuera de dominio y luego se cumple&gt;=60. Solo se imprime Aprobado. Sigue también 59, 60 y 101 en la tabla antes de editar el ejemplo: la estructura permite explicar qué pregunta se evalúa primero.

## Ejemplo 2. Categorías con switch

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    const char opcion{'B'};
    switch (opcion) {
        case 'A': std::cout << "Consultar\n"; break;
        case 'B': std::cout << "Registrar\n"; break;
        default: std::cout << "Opción desconocida\n"; break;
    }
    const int horas{5};
    const bool dentro{horas >= 0 && horas <= 40};
    std::cout << std::boolalpha << "Horas válidas: " << dentro << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u03_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u03_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u03_e02.exe` |

Salida esperada:

```text
Registrar
Horas válidas: true
```

### Lectura paso a paso

La opción B entra en Registrar y break evita continuar. Después dentro vale true para 5 horas porque cumple ambos límites. El formato boolalpha solo modifica la salida; no cambia la condición.

## Experimenta

Prueba 59, 60, 100 y 101, cambiando una sola entrada. Luego retira break en una copia del switch y observa qué mensaje adicional aparece. Restaura la versión correcta y explica la causa, en vez de concluir que switch imprime al azar.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Comparar un intervalo como 0&lt;=x&lt;=40 | Escribe x&gt;=0 && x&lt;=40. |
| Clasificar antes de validar | Separa dominio y decisión de negocio. |
| Olvidar break | Revisa si una caída al siguiente caso era intencional. |

## Autoevaluación

1. ¿Qué combina &&?
2. ¿Por qué probar 60?
3. ¿Qué hace break en switch?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad02-tipos/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-ciclos/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2003%20%28Condiciones%2C%20decisiones%20y%20l%C3%ADmites%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
