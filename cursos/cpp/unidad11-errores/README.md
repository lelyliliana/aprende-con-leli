# Unidad 11. Errores, std::optional y excepciones

[Anterior](../unidad10-registros/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-clases/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Conservar cero.
- Rechazar sufijo.
- Validar dominio.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un error necesita una representación y una política

Una función que interpreta un entero puede obtener 0 legítimo, no encontrar un número o descubrir un dato fuera de dominio. Devolver 0 para todos esos casos destruye información. `std::optional<int>` permite expresar una cantidad presente o una ausencia de resultado; una excepción comunica un fallo que debe gestionar el nivel adecuado.

### optional distingue presencia de valor

El primer ejemplo usa std::from_chars sobre el rango de texto. Su resultado informa código de error y posición donde terminó. Deben cumplirse ambas cosas: sin error y consumo completo. "7 abc" no se acepta solo porque tiene un prefijo 7. Esta función no descarta espacios automáticamente; su contrato es distinto del flujo de la Unidad 05.

Si falla se devuelve std::nullopt. Si funciona se devuelve el entero. if(cero) pregunta si el optional tiene valor, no si ese valor es distinto de 0. Solo después de esa revisión se utiliza*cero. has_value responde la misma pregunta de presencia de forma explícita.

| Texto | ¿Hay valor? | Resultado |
|---|---|---|
| 0 | Sí | Entero 0 |
| 7 abc | No | nullopt |
| Vacío | No | nullopt |
| Entero no representable | No | nullopt |

### Convertir no es validar el problema

from_chars puede interpretar 41 como entero representable. Si hablamos de horas 0 a 40, necesitamos después una regla de dominio. Separar conversión y validación permite saber si falló la representación o el significado admitido por el análisis.

### throw interrumpe la operación fallida

validar_horas lanza std::invalid_argument cuando incumple el rango. El flujo no continúa por la siguiente instrucción normal de esa llamada. try delimita el intento y catch recibe la excepción compatible. Capturar por const referencia evita copiar la condición y permite consultar what para explicar su mensaje.

Captura donde puedas responder, registrar o terminar con una señal coherente. Un catch vacío que finja éxito puede generar un reporte inválido. No uses excepciones para esconder una precondición que sabías incumplida ni devuelvas una cantidad anterior como si fuese el dato nuevo.

### Los recursos necesitan conservarse ante fallos

Al salir de un alcance por una excepción, se destruyen objetos automáticos construidos que deban finalizar en ese recorrido. Esa propiedad será parte de RAII. No necesitas escribir un delete manual por cada ruta de error para gestionar cadenas, vectores y archivos de estos ejemplos.

### Elige una interfaz que se pueda interpretar

optional es útil cuando la falta de un resultado es esperable y no necesitas por sí sola un diagnóstico detallado. Una excepción puede comunicar una operación rechazada cuyo resultado normal no existe. Ninguna elección sustituye documentar dominio y causas. En el proyecto las entradas inválidas se rechazarán con una explicación antes de escribir resultados.

## Ejemplo 1. Distinguir ausencia de un cero válido

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <optional>
#include <string>
#include <charconv>
#include <system_error>

std::optional<int> entero(const std::string& texto) {
    int valor{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), valor)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) { return std::nullopt; }
    return valor;
}

int main() {
    const auto cero{entero("0")};
    const auto fallo{entero("7abc")};
    if (cero) { std::cout << "Cero conocido: " << *cero << '\n'; }
    std::cout << std::boolalpha << "Texto inválido tiene resultado: " << fallo.has_value() << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u11_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u11_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u11_e01.exe` |

Salida esperada:

```text
Cero conocido: 0
Texto inválido tiene resultado: false
```

### Lectura paso a paso

entero compara código y final de conversión. "0"produce un optional presente con valor 0. "7 abc"produce ausencia por caracteres sobrantes. La salida demuestra que presencia y contenido no son la misma condición lógica.

## Ejemplo 2. Rechazar y observar una precondición

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <stdexcept>

int validar_horas(int horas) {
    if (horas < 0 || horas > 40) { throw std::invalid_argument{"Horas fuera de 0 a 40"}; }
    return horas;
}

int main() {
    std::cout << "Válido: " << validar_horas(0) << '\n';
    try {
        const int resultado{validar_horas(-1)};
        std::cout << resultado << '\n';
        return 1;
    } catch (const std::invalid_argument& error) {
        std::cout << "Rechazo: " << error.what() << '\n';
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u11_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u11_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u11_e02.exe` |

Salida esperada:

```text
Válido: 0
Rechazo: Horas fuera de 0 a 40
```

### Lectura paso a paso

Se acepta el límite 0. La llamada con-1 lanza antes de retornar una cantidad; catch muestra el mensaje y el programa comprueba que ese rechazo previsto ocurrió. No es un cero de horas ni un cálculo exitoso.

## Experimenta

Prueba "0", "41", "7 abc ", "" y una cadena demasiado larga para int. Separa qué entradas convierten y cuáles satisfarían después el dominio 0 a 40. Conserva el texto para poder explicar cada rechazo.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Confundir optional presente con número no cero | if(optional) comprueba presencia. |
| Aceptar solo el prefijo de from_chars | Revisa también el puntero final. |
| Capturar cualquier fallo y seguir como éxito | Comunica la operación rechazada y su causa. |

## Autoevaluación

1. ¿Un optional con 0 es falso?
2. ¿Qué revisas tras from_chars?
3. ¿Qué evita un catch que finge éxito?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad10-registros/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-clases/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2011%20%28Errores%2C%20std%3A%3Aoptional%20y%20excepciones%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
