# Unidad 12. Clases, constructores e invariantes

[Anterior](../unidad11-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-vida-util/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Construir.
- Retirar una cantidad válida.
- Rechazar sin alterar.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Una clase protege una regla durante sus cambios

Un struct de producto puede contener datos sin imponer un procedimiento de cambio. Cuando un stock debe permanecer no negativo, una clase puede concentrar la construcción y las operaciones que conservan esa regla. La regla permanente se llama invariante: debe cumplirse para los objetos válidos en los puntos donde su interfaz promete utilizarlos.

### Construye un estado admitido

Stock tiene un campo cantidad_ privado. Su constructor recibe inicial y lo inicializa mediante la lista tras los dos puntos. Después rechaza negativos. Si la construcción falla, no entregamos un Stock que parezca válido con cantidad negativa. explicit evita ciertas conversiones implícitas desde un entero que podrían ocultar la intención de construir.

private es el acceso predeterminado de class; public anuncia las operaciones disponibles fuera. La encapsulación requiere que esas operaciones respeten la regla, no solo poner campos detrás de una palabra reservada. Un método público que asignara cualquier negativo rompería la misma invariante.

### Consulta sin modificar

int cantidad() const devuelve la cantidad y promete no modificar miembros ordinarios a través de ese método const. No significa que todo el programa sea inmutable ni que no exista ningún efecto externo posible. En este diseño es una consulta pequeña y su resultado puede usarse en una comprobación.

### Valida antes de cambiar

retirar(n) comprueba que n no sea negativo ni exceda lo disponible. Solo después resta. Con stock 5, retirar 2 deja 3; retirar 4 se rechaza y conserva 3. Esa conservación ante el rechazo es una garantía concreta de esta operación. Si restaras primero y validaras después, la excepción podría dejar un estado que ya incumplió el contrato.

| Operación | Antes | Resultado |
|---|---|---|
| Construir 5 | No existe instancia | Stock 5 |
| Retirar 2 | Stock 5 | Stock 3 |
| Retirar 4 | Stock 3 | Rechazo, conserva 3 |
| Retirar 3 | Stock 3 | Stock 0 |

### Composición antes de jerarquías

Equipo contiene dos cadenas, código y nombre. Eso es composición: el objeto agrupa piezas con sus propias responsabilidades. Los parámetros por valor se copian a los miembros en esta versión sencilla. Estudiaremos movimiento después; no hace falta introducir propiedad compartida para guardar dos textos.

Las consultas devuelven referencias constantes a cadenas del objeto. Evitan copiar esos textos, pero no extienden la vida útil de Equipo. No guardes la referencia para usarla después de destruir su propietario. Esa relación se desarrolla en la siguiente unidad.

### Evita objetos que dependan de una llamada olvidada

Un constructor que establece las condiciones necesarias permite usar la instancia inmediatamente. Pedir construir, después inicializar y después validar en un orden externo difícil de recordar abre estados incompletos. Define una interfaz pequeña y prueba los límites antes de añadir funcionalidades.

El proyecto final usa registros más un validador porque representa filas leídas en un lote. No convierte cada fila en una jerarquía artificial: el diseño se elige por sus reglas y operaciones, no por la cantidad de clases.

## Ejemplo 1. Una clase conserva una regla

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <stdexcept>

class Stock {
    int cantidad_;
public:
    explicit Stock(int inicial) : cantidad_{inicial} {
        if (inicial < 0) { throw std::invalid_argument{"Stock negativo"}; }
    }
    int cantidad() const { return cantidad_; }
    void retirar(int n) {
        if (n < 0 || n > cantidad_) { throw std::invalid_argument{"Retiro inválido"}; }
        cantidad_ -= n;
    }
};

int main() {
    Stock sensor{5};
    sensor.retirar(2);
    std::cout << "Stock: " << sensor.cantidad() << '\n';
    try { sensor.retirar(4); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Rechazo sin cambiar stock: " << sensor.cantidad() << '\n'; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u12_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u12_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u12_e01.exe` |

Salida esperada:

```text
Stock: 3
Rechazo sin cambiar stock: 3
```

### Lectura paso a paso

El constructor acepta 5. La retirada válida deja 3; la siguiente se rechaza antes de tocar cantidad_. El catch previsto permite consultar después y confirmar conservación. Revisa el orden de condición y resta para entender por qué se cumple.

## Ejemplo 2. Componer objetos y consultar sin modificar

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>
#include <utility>

class Equipo {
    std::string codigo_;
    std::string nombre_;
public:
    Equipo(std::string codigo, std::string nombre) : codigo_{codigo}, nombre_{nombre} {}
    const std::string& codigo() const { return codigo_; }
    const std::string& nombre() const { return nombre_; }
};

int main() {
    const Equipo equipo{"S01", "Sensor"};
    std::cout << equipo.codigo() << ": " << equipo.nombre() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u12_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u12_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u12_e02.exe` |

Salida esperada:

```text
S01: Sensor
```

### Lectura paso a paso

El objeto const contiene sus propias cadenas. codigo() y nombre() permiten leerlas; no proporcionan una asignación externa a los miembros. Su referencia requiere que el objeto siga existiendo durante su uso.

## Experimenta

Prueba construcción con 0 y con-1. Después retira exactamente lo disponible y predice 0, que es válido. Contrasta con retirar una unidad más del stock sin modificar antes la entrada.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Validar después de modificar | Comprueba precondiciones antes de cambiar el estado. |
| Creer que private garantiza toda invariante | Revisa cada operación pública. |
| Conservar una referencia más que su objeto | Relaciona observador y vida útil del propietario. |

## Autoevaluación

1. ¿Qué es una invariante?
2. ¿Por qué validar antes de restar?
3. ¿Una referencia de consulta prolonga la vida del objeto?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad11-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-vida-util/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2012%20%28Clases%2C%20constructores%20e%20invariantes%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
