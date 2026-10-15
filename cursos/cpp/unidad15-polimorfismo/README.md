# Unidad 15. Interfaces y polimorfismo con propósito

[Anterior](../unidad14-propiedad/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-mapas/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Calcular un área concreta.
- Usar la interfaz.
- Componer propietarios.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Polimorfismo cuando necesitas sustituir comportamientos

Una interfaz expresa operaciones que varios tipos pueden realizar. No exige que todos tengan el mismo estado interno. Figura declara area; Rectangulo aporta una implementación. El objetivo del ejemplo es utilizar una colección mediante esa operación común, conservando el comportamiento concreto de cada objeto.

### Declara la interfaz

virtual int area() const = 0 declara una función virtual pura. Figura es abstracta y no se construye directamente como una figura completa. El código que recibe una referencia o un puntero a Figura puede solicitar area sin decidir qué implementación concreta habrá detrás.

El destructor virtual permite destruir correctamente los objetos derivados mediante el propietario de tipo base. La colección utiliza `unique_ptr<Figura>`, por lo que esa condición forma parte del diseño de propiedad, no es un adorno de la sintaxis.

### Implementa con un contrato reconocible

Rectangulo hereda públicamente de Figura y define area con override. Esa palabra pide al compilador comprobar que efectivamente sobrescribe una operación virtual compatible. Un nombre o firma equivocados deben diagnosticarse antes de ejecutar, en vez de crear accidentalmente otra función.

Los ejemplos usan dimensiones positivas pequeñas construidas. El tipo mostrado se centra en sustitución y no implementa una validación universal de geometría. Si recibieras dimensiones externas, tendrías que definir dominio, unidad y representación del área antes de construir un objeto aceptado.

### No pierdas el tipo concreto

Al pasar un objeto derivado por valor como una base no abstracta puede ocurrir recorte de su parte derivada. Aquí trabajamos por referencia o puntero, conservando el objeto concreto. El operador -&gt; llama un miembro a través de un puntero o de un propietario que ofrece ese acceso.

En la colección, cada unique_ptr es propietario y la interfaz determina qué operación se puede solicitar. Son responsabilidades distintas: una decide vida útil y otra comportamiento. El recorrido no copia propietarios y no necesita llamar delete manualmente.

### Composición y funciones también son opciones

La segunda jerarquía modela reglas de precio sustituibles. Una función calcular consulta una ReglaPrecio por referencia constante y delega aplicar. El precio normal conserva 100 y el reducido calcula 90 para este dominio pequeño de práctica.

Una jerarquía se justifica cuando necesitas esa sustitución y un contrato común. Si solo quieres agrupar tres campos de una fila, struct puede ser suficiente. Si una operación es una transformación sencilla, una función o lambda puede expresarla mejor. El proyecto de inventario no inventa herencias entre materiales que solo difieren en sus datos.

### Prueba mediante el contrato común

Invoca el área directamente y mediante una referencia a Figura: ambas deben obtener 6 para el rectángulo 2×3. Después añade otra instancia 4×2 y suma 14. El criterio de prueba observa la operación prometida y la vida útil de los propietarios, sin depender de direcciones de memoria que varían entre ejecuciones.

## Ejemplo 1. Una interfaz y dos instancias

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <memory>
#include <vector>

class Figura {
public:
    virtual ~Figura() = default;
    virtual int area() const = 0;
};
class Rectangulo final : public Figura {
    int ancho_;
    int alto_;
public:
    Rectangulo(int ancho, int alto) : ancho_{ancho}, alto_{alto} {}
    int area() const override { return ancho_ * alto_; }
};

int main() {
    std::vector<std::unique_ptr<Figura>> figuras;
    figuras.push_back(std::make_unique<Rectangulo>(2, 3));
    figuras.push_back(std::make_unique<Rectangulo>(4, 2));
    for (const auto& figura : figuras) { std::cout << "Área: " << figura->area() << '\n'; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u15_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u15_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u15_e01.exe` |

Salida esperada:

```text
Área: 6
Área: 8
```

### Lectura paso a paso

La colección contiene dos objetos concretos bajo propietarios de interfaz. Cada llamada virtual solicita su área: 6 y 8. La destrucción se gestiona a través de la base con destructor virtual, conservando la responsabilidad de cada unique_ptr.

## Ejemplo 2. Sustituir una estrategia

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

class ReglaPrecio {
public:
    virtual ~ReglaPrecio() = default;
    virtual int aplicar(int base) const = 0;
};
class PrecioNormal final : public ReglaPrecio {
public: int aplicar(int base) const override { return base; }
};
class PrecioReducido final : public ReglaPrecio {
public: int aplicar(int base) const override { return base * 9 / 10; }
};
int calcular(const ReglaPrecio& regla, int base) { return regla.aplicar(base); }

int main() {
    const PrecioNormal normal;
    const PrecioReducido reducido;
    std::cout << "Normal: " << calcular(normal, 100) << '\n';
    std::cout << "Reducido: " << calcular(reducido, 100) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u15_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u15_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u15_e02.exe` |

Salida esperada:

```text
Normal: 100
Reducido: 90
```

### Lectura paso a paso

calcular acepta la misma interfaz para dos reglas. El resultado cambia por la implementación aplicada, no por una condición dentro de calcular que inspeccione nombres de clases. Las cuentas usan enteros pequeños y una política de redondeo por división entera que tendrías que justificar para dinero real.

## Experimenta

Compara area invocada directamente y por referencia base. Después añade otra figura que implemente la interfaz, con un cálculo pequeño verificable a mano. No elimines override para ocultar un diagnóstico de firma incompatible.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Heredar solo para reutilizar campos | Busca primero composición y funciones. |
| Destruir por una base sin contrato adecuado | La interfaz propietaria de este ejemplo necesita destructor virtual. |
| Copiar objetos base y perder comportamiento | Conserva el objeto concreto mediante referencia o propiedad adecuada. |

## Autoevaluación

1. ¿Qué exige =0 en la interfaz?
2. ¿Qué verifica override?
3. ¿Por qué el proyecto no necesita herencia entre productos?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad14-propiedad/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-mapas/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2015%20%28Interfaces%20y%20polimorfismo%20con%20prop%C3%B3sito%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
