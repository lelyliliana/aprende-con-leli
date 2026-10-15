# Unidad 21. Proyecto integrador: inventario explicado

[Anterior](../unidad20-depuracion/README.md) · [Índice](../README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Leer y definir.
- Calcular en centavos.
- Observar un rechazo.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Construir una entrega que otra persona pueda revisar

El proyecto responde una pregunta concreta: ¿qué subtotal corresponde a cada material y cuál es el valor total del inventario ficticio? Integra lectura, validación, identidad, cálculo, orden y reporte. Completa la [construcción por etapas](../proyecto/CONSTRUCCION.md) antes de ejecutar la aplicación terminada.

### Define entrada y esquema

El archivo utiliza punto y coma y tres columnas: codigo, cantidad, precio_centavos. Es un formato delimitado restringido, no un lector universal de todas las variantes de CSV. No admite comillas, campos multilínea, ausencias ni columnas adicionales. El código admite letras ASCII mayúsculas, dígitos, guion y guion bajo. Los otros dos campos deben interpretarse completos como enteros.

El diccionario declara longitudes y límites. La cantidad 0 representa stock agotado conocido. Una celda vacía se rechaza porque falta una cantidad requerida. Repetir un código también se rechaza: el programa no elige primero, último o una suma sin una política del problema.

### Compón responsabilidades

inventario.hpp declara Producto y las operaciones. inventario.cpp define lectura, validación, cálculo y escritura. main.cpp interpreta argumentos y organiza la ejecución. Las funciones conservan propósitos reconocibles y las pruebas utilizan la misma biblioteca que la aplicación.

La aplicación recibe dos rutas mediante argumentos. argc incluye el nombre del programa y argv contiene los textos correspondientes. Solo se consultan argv[1] y argv[2] después de exigir tres argumentos contados con el programa. Las rutas relativas se interpretan desde la carpeta de trabajo; no desde la ubicación del ejecutable.

### Valida antes de generar resultados

Primero se lee y valida el conjunto completo. Después se calcula el total. Solo entonces se crean carpetas y se abre el reporte. Una cantidad negativa debe terminar con código 2 sin crear la carpeta nueva de resultados. También se protege el origen si entrada y salida representan el mismo archivo, y se rechaza una salida existente.

Esas garantías se comprueban con casos concretos. No constituyen un protocolo de concurrencia ni una escritura atómica ante cortes. Es una aplicación local de un proceso con un formato declarado. Si el entorno falla al escribir, puede quedar un producto parcial que necesita revisión.

### Contrasta números e identidades

Los seis registros producen 55000 centavos de total. El reporte ordena por código y conserva cantidad, precio y subtotal. CAJA permanece con cantidad 0; no se descarta por aportar cero al total. La unidad monetaria es de práctica y no se utilizan decimales flotantes para estas cuentas enteras.

El reporte tiene cuatro columnas, por lo que no se vuelve a leer automáticamente con el esquema de entrada de tres. Revisa su formato con la muestra y las pruebas de CLI. Poder abrir un archivo como texto no demuestra que satisfaga el contrato de otro lector.

### Defiende el resultado

Explica pregunta, esquema, dominios, rechazos, cálculos y unidades. Muestra comandos, versiones y resultados de pruebas. La evaluación combina productos y razones: una captura final sin fuentes no permite reconstruir el proceso.

Una ampliación empieza por especificar el cambio. Un campo nuevo o una regla de préstamos exige revisar diccionario, interfaz, implementación y pruebas de manera coherente. Cambiar solo el nombre o extensión del archivo no adapta el programa a cualquier dominio.

## Ejemplo 1. Leer el inventario validado

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include "inventario.hpp"
#include <iostream>

int main() {
    const auto productos{inventario::leer("datos/inventario.csv")};
    std::cout << "Registros: " << productos.size() << '\n';
    std::cout << "Total: " << inventario::total(productos) << " centavos\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u21_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u21_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u21_e01.exe` |

Salida esperada:

```text
Registros: 6
Total: 55000 centavos
```

### Lectura paso a paso

leer devuelve un vector validado y total utiliza ese contrato. El primer ejemplo muestra 6 registros y 55000 centavos. Leer y calcular no escriben un reporte: los efectos permanecen separados.

## Ejemplo 2. Una entrada contradictoria se rechaza

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include "inventario.hpp"
#include <iostream>
#include <stdexcept>
#include <vector>

int main() {
    const std::vector<inventario::Producto> productos{ {"S01", 2, 1500}, {"S01", 3, 1500}};
    try { inventario::validar(productos); return 1; }
    catch (const std::invalid_argument&) { std::cout << "ID duplicado rechazado antes del resumen\n"; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u21_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u21_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u21_e02.exe` |

Salida esperada:

```text
ID duplicado rechazado antes del resumen
```

### Lectura paso a paso

Dos códigos S01 en el mismo lote incumplen identidad. La validación lanza invalid_argument y no produce un resumen válido. El caso no decide cuál fila real sería correcta: pide revisar la fuente.

## Experimenta

Calcula a mano el subtotal afectado antes de cambiar un dato. Haz el cambio en una copia del CSV y utiliza una salida nueva. Después prueba una cantidad negativa y comprueba el rechazo previo a generar resultados.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Tratar el lector como un CSV universal | Respeta el formato restringido y su diccionario. |
| Reutilizar el reporte como entrada idéntica | Los dos formatos tienen columnas y contratos distintos. |
| Entregar solo un binario | Conserva fuentes, datos de práctica, comandos y pruebas. |

## Autoevaluación

1. ¿Por qué no convertir vacío en cero?
2. ¿El reporte tiene el esquema de entrada?
3. ¿Qué indica código 2?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad20-depuracion/README.md) · [Índice](../README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2021%20%28Proyecto%20integrador%3A%20inventario%20explicado%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
