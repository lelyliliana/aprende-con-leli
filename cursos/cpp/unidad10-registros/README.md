# Unidad 10. Registros, enumeraciones y modelos

[Anterior](../unidad09-algoritmos/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-errores/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Construir un producto.
- Calcular subtotal.
- Modelar un estado.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un registro conserva datos que pertenecen juntos

Si guardas códigos, cantidades y precios en vectores separados, ordenar solo uno puede asignar un precio al material equivocado. struct Producto reúne esos campos en una unidad. Un `vector<Producto>` conserva registros completos y permite ordenar o recorrer sin separar su identidad.

### Declara campos y construye instancias

La definición struct contiene nombres y tipos y termina con punto y coma después de la llave. Producto{"S01", 2, 1500} inicializa los campos en el orden declarado. sensor.codigo accede al campo de esa instancia. El tipo define estructura; el objeto tiene valores concretos.

El ejemplo conserva precio en centavos por unidad. cantidad*precio_centavos produce un subtotal. Dos registros podrían compartir precio legítimamente; no representan un duplicado por ese motivo. El código decidirá identidad en el proyecto y deberá ser único bajo su contrato.

### Estructura no equivale a validación

Un struct con int cantidad todavía podría contener -1. El compilador comprueba compatibilidad de tipos, pero no conoce automáticamente el dominio de un inventario. En la Unidad 11 escribirás rechazos y en la 12 encapsularás reglas cuando un objeto deba conservarlas al cambiar.

No presentes una inicialización exitosa como prueba de que el registro describe algo real. La calidad requiere revisar origen, campos obligatorios, unidades y relaciones. Aquí todos los materiales son ficticios y los números están elegidos para seguir cuentas manuales.

### Un enum class expresa alternativas

Disponible, prestado y mantenimiento son estados distintos. enum class los agrupa bajo un tipo y permite escribir Estado::prestado. Eso comunica más que números 1, 2, 3 sin nombre. No se convierte implícitamente en un entero ordinario para mezclarlo con cualquier cantidad.

switch puede presentar una acción según ese estado. Los estados del ejemplo están cerrados a los valores definidos en su construcción. Datos externos todavía requerirían interpretar texto y rechazar etiquetas desconocidas antes de convertirlas en una alternativa admitida.

| Idea | Herramienta | Responsabilidad pendiente |
|---|---|---|
| Agrupar campos | struct | Comprobar dominio e identidad |
| Limitar alternativas del modelo | enum class | Interpretar etiquetas externas |
| Conservar varias instancias | vector | Definir políticas de duplicación |

### Define qué modifica cada operación

for(const auto& p: productos) consulta cada registro sin copiar sus cadenas ni permitir modificación mediante esa referencia. p.cantidad y p.precio_centavos pertenecen al mismo producto. El acumulador recibe sus subtotales y conserva la unidad monetaria menor.

La estructura se deriva de la pregunta, no de obligar a todo modelo a tener una clase con herencia. Una tabla de datos sin comportamiento protegido puede ser un buen uso de struct; una regla permanente de objeto pedirá otras decisiones.

## Ejemplo 1. Agrupar datos que pertenecen al mismo registro

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>
#include <vector>

struct Producto {
    std::string codigo;
    int cantidad;
    int precio_centavos;
};

int main() {
    const std::vector<Producto> productos{ {"S01", 2, 1500}, {"S02", 3, 2000}};
    for (const auto& p : productos) {
        std::cout << p.codigo << ": " << p.cantidad * p.precio_centavos << " centavos\n";
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u10_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u10_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u10_e01.exe` |

Salida esperada:

```text
S01: 3000 centavos
S02: 6000 centavos
```

### Lectura paso a paso

S01 produce 3000 y S02 produce 6000 centavos. El ciclo recibe cada registro completo por referencia constante. No se emparejan columnas por un orden externo que pudiera haberse perdido.

## Ejemplo 2. Un conjunto cerrado de estados

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

enum class Estado { disponible, prestado, mantenimiento };

int main() {
    const Estado estado{Estado::prestado};
    switch (estado) {
        case Estado::disponible: std::cout << "Disponible\n"; break;
        case Estado::prestado: std::cout << "Prestado\n"; break;
        case Estado::mantenimiento: std::cout << "En mantenimiento\n"; break;
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u10_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u10_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u10_e02.exe` |

Salida esperada:

```text
Prestado
```

### Lectura paso a paso

Estado::prestado selecciona su caso y presenta Prestado. El nombre del estado no es un texto de archivo ni una cantidad; es una alternativa del tipo. La representación de entrada se convertiría mediante una política explícita.

## Experimenta

Cambia el precio de S02 dejando su código fijo y predice su subtotal. Después crea dos registros con precio igual: explica por qué eso no demuestra duplicación. Compara dos códigos iguales bajo el contrato del proyecto.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Ordenar solo precios separados de sus códigos | Conserva los campos en registros completos. |
| Olvidar; tras la definición del struct | La declaración del tipo necesita cierre completo. |
| Suponer que int excluye negativos | El dominio requiere validación además del tipo. |

## Autoevaluación

1. ¿struct valida cantidades automáticamente?
2. ¿Un precio repetido duplica identidad?
3. ¿Qué comunica enum class?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad09-algoritmos/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-errores/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2010%20%28Registros%2C%20enumeraciones%20y%20modelos%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
