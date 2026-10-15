# Unidad 02. Variables, tipos, constantes y operaciones

[Anterior](../unidad01-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-decisiones/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Convertir unidades.
- Conservar un ID.
- Contrastar divisiones.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Una variable tiene tipo, nombre y valor

int cantidad{3} declara un objeto entero inicializado en 3. double horas{1.5} conserva una cantidad decimal aproximada. bool puede representar true o false y std::string conserva texto cuando incluyes &lt;string&gt;. No elegimos el tipo solo por el aspecto del dato: "007" es un identificador textual aunque contenga dígitos.

### Inicializa antes de leer

Las llaves establecen un valor inicial y ayudan a detectar ciertas conversiones estrechadoras. Leer un entero local no inicializado no es una manera de obtener cero. Inicializa de forma explícita y elige nombres como precio_centavos que comuniquen la unidad. El lenguaje no comprueba automáticamente que hayas multiplicado unidades compatibles.

const declara que no modificarás ese objeto después de inicializarlo. La constante 60 comunica minutos por hora. Tras calcular minutos=horas*60 y cambiar horas, no se actualiza minutos: una asignación conserva el resultado evaluado en ese momento. Sigue el estado de cada nombre en orden.

### El tipo participa en la operación

7/2 utiliza división entera y produce 3. `static_cast<double>`(7)/2 realiza división con un operando double y produce 3.5. Convertir a double después de 7/2 solo convertiría 3, porque la parte fraccionaria ya se perdió. Los paréntesis y el momento de la conversión cambian el resultado.

std::fixed y std::setprecision controlan la presentación del flujo, no convierten una aproximación binaria en aritmética decimal exacta. Para el inventario representamos dinero en centavos enteros y declaramos límites. No tomamos cualquier precio decimal capturado y lo multiplicamos por 100 suponiendo exactitud sin revisar su representación.

### Representación y límites

El tamaño exacto de int depende de la implementación dentro de las garantías del lenguaje. No supongas que toda máquina tiene los mismos límites solo por llamarlo int. std::int64_t, de &lt;cstdint&gt;, ofrece un entero de 64 bits cuando está disponible en las plataformas del curso. La operación debe caber también en sus operandos intermedios: asignar después a un tipo mayor no repara un desbordamiento ocurrido antes.

El desbordamiento de enteros con signo no se utiliza como una técnica para dar la vuelta al máximo. Nuestros ejemplos trabajan con cantidades pequeñas y el proyecto valida dominios para que productos y sumas sean representables. unsigned tampoco significa «rechazar negativos»: convertir una entrada negativa a un tipo sin signo puede cambiar radicalmente su valor.

### Asignar, comparar y deducir

= asigna; == compara valores. auto pide deducir el tipo desde el inicializador y no convierte C++ en un lenguaje sin tipos estáticos. Antes de usarlo, pregunta qué expresión lo inicializa. Empleamos nombres y tipos explícitos al presentar una magnitud para que puedas seguir su significado.

| Objeto | Valor inicial | Papel |
|---|---|---|
| horas | 1.5 | Cantidad de entrada |
| minutos_por_hora | 60 | Factor constante |
| minutos | 90 | Resultado conservado |

Cuando horas pasa a 2, solo cambia esa entrada. El resultado anterior sigue 90 hasta que ejecutes otro cálculo.

## Ejemplo 1. Inicializar y convertir unidades

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    const int minutos_por_hora{60};
    double horas{1.5};
    const double minutos{horas * minutos_por_hora};
    horas = 2.0;
    std::cout << "Minutos calculados: " << minutos << '\n';
    std::cout << "Horas actuales: " << horas << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u02_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u02_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u02_e01.exe` |

Salida esperada:

```text
Minutos calculados: 90
Horas actuales: 2
```

### Lectura paso a paso

El ejemplo declara primero el factor; después calcula 90 minutos y reasigna horas a 2. Las impresiones separan el resultado conservado de la entrada actual. const impide cambiar minutos en esta versión; si quieres otro resultado, crea otro objeto con el cálculo nuevo.

## Ejemplo 2. División entera y decimal

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <iomanip>
#include <cstdint>

int main() {
    const int total{7};
    const int personas{2};
    const std::int64_t precio_centavos{1250};
    std::cout << "División entera: " << total / personas << '\n';
    std::cout << std::fixed << std::setprecision(1);
    std::cout << "División decimal: " << static_cast<double>(total) / personas << '\n';
    std::cout << "Tres unidades en centavos: " << precio_centavos * 3 << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u02_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u02_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u02_e02.exe` |

Salida esperada:

```text
División entera: 3
División decimal: 3.5
Tres unidades en centavos: 3750
```

### Lectura paso a paso

La primera división devuelve 3. La conversión del operando hace que la segunda muestre 3.5. El precio está almacenado en centavos enteros; su producto por 3 es 3750. El formato decimal de la segunda línea no altera ese entero.

## Experimenta

Compara `static_cast<double>`(7/2) con `static_cast<double>`(7)/2 y explica 3 frente a 3.5. Después cambia horas sin recalcular minutos. Escribe una traza que distinga nombre, valor y unidades.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Convertir después de dividir y esperar recuperar la fracción | Convierte un operando antes de la división. |
| Suponer que const actualiza una fórmula | Conserva un resultado; no es una dependencia reactiva. |
| Usar un tipo mayor solo para la variable final | Revisa también el tipo y límites de los operandos intermedios. |

## Autoevaluación

1. ¿auto elimina el tipo?
2. ¿Cambiar horas recalcula minutos?
3. ¿Un entero negativo convertido a unsigned se rechaza?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad01-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-decisiones/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2002%20%28Variables%2C%20tipos%2C%20constantes%20y%20operaciones%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
