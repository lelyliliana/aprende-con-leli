# Unidad 07. Texto con std::string y contratos de formato

[Anterior](../unidad06-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-contenedores/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Conservar 007.
- Separar dos campos.
- Gestionar ausencia de separador.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Texto es una representación, no una cantidad

std::string gestiona una secuencia de elementos char y su almacenamiento. Una literal como "007" permite conservar el identificador con ceros iniciales. Su tamaño es 3 en este caso ASCII. Un entero 7 tiene otro significado y no recuerda cómo se escribió el código original.

### Busca antes de separar

`find(';')` devuelve una posición cuando encuentra el separador y std::string::npos cuando no existe. No sumes 1 a una posición sin comprobar primero que la búsqueda tuvo éxito. substr(0, posicion) obtiene el prefijo; substr(posicion+1) obtiene el resto después del separador.

| Texto | Posición del `;` | Prefijo | Sufijo |
|---|---|---|---|
| S01; 5 | 3 | S01 | 5 |
| S01 | npos | No se separa | No se separa |

En C++ las posiciones comienzan en 0. S01 ocupa 0, 1, 2 y el separador está en 3. La longitud del prefijo es 3, aunque su última posición sea 2. Distinguir longitud y posiciones evita errores al recortar.

### Declara qué caracteres admite un código

El segundo ejemplo define una regla ASCII: letras A a Z, dígitos 0 a 9 y guion. Una cadena vacía no identifica un registro. Cada carácter se contrasta con esa política. La regla es una decisión del ejercicio, no una definición de todo identificador posible. El proyecto ampliará el formato con guion bajo y longitud máxima declarada.

Comparar "A" y "a" no normaliza mayúsculas. Si necesitas convertir, elige una política y conserva el origen cuando la equivalencia importe. No elimines espacios interiores automáticamente sin saber si forman parte de la identidad o son errores de captura.

### Bytes y caracteres humanos no son lo mismo

Para una cadena UTF-8, size cuenta unidades char, que en las plataformas del curso corresponden a bytes. Una letra acentuada puede utilizar varios bytes y no debe recorrerse como si cada byte fuera una letra completa. Los ejemplos de formato restringen sus códigos a ASCII para que la regla sea explícita; los mensajes en español no se usan como claves numéricas.

std::string no proporciona por sí sola normalización Unicode, conteo de grafemas o detección del idioma. Si una aplicación necesita nombres de personas o títulos internacionales, el contrato y las herramientas deben ampliarse. No presentes el validador ASCII como solución universal para textos.

### Copias y modificaciones

substr produce una cadena nueva. Comparar cadenas no cambia el original. Cuando trabajes con datos externos, conservar línea y campos ayuda a informar dónde falló una conversión. El proyecto de archivos distinguirá estructura, representación entera y dominio en vez de considerar que toda línea con `;` es un registro válido.

## Ejemplo 1. Comparar texto y buscar un separador

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>

int main() {
    const std::string codigo{"007"};
    const std::string linea{"S01;5"};
    const auto posicion{linea.find(';')};
    if (posicion == std::string::npos) { return 1; }
    std::cout << "ID: " << codigo << "; bytes: " << codigo.size() << '\n';
    std::cout << "Antes: " << linea.substr(0, posicion) << '\n';
    std::cout << "Después: " << linea.substr(posicion + 1) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u07_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u07_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u07_e01.exe` |

Salida esperada:

```text
ID: 007; bytes: 3
Antes: S01
Después: 5
```

### Lectura paso a paso

El identificador se imprime sin conversión. La búsqueda detecta posición 3 y luego se obtienen S01 y 5 como textos. El sufijo todavía no es un entero; aplicar operaciones numéricas requerirá una interpretación posterior.

## Ejemplo 2. Recorrer bytes ASCII con una regla explícita

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>

int main() {
    const std::string codigo{"S01-A"};
    bool valido{!codigo.empty()};
    for (const char c : codigo) {
        const bool permitido{(c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-'};
        if (!permitido) { valido = false; }
    }
    std::cout << std::boolalpha << "Código ASCII admitido: " << valido << '\n';
    std::cout << "Mayúsculas y minúsculas son distintas: " << (std::string{"A"} != "a") << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u07_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u07_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u07_e02.exe` |

Salida esperada:

```text
Código ASCII admitido: true
Mayúsculas y minúsculas son distintas: true
```

### Lectura paso a paso

El ciclo recorre cada byte ASCII y comprueba la regla. std::boolalpha muestra true para S01-A. La comparación deA ya demuestra que no se asumió equivalencia de mayúsculas. No se aplica este recorrido como analizador Unicode.

## Experimenta

Prueba S01-A, S01 A y s 01. Predice cuáles cumplen la política. Después quita el separador del primer ejemplo y comprueba que debes manejar npos antes de substr. Conserva los datos originales en otra cadena.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Confundir posición 3 con cuarto carácter siempre ausente | Los índices empiezan en 0. |
| Usar find sin revisar npos | Trata explícitamente la búsqueda fallida. |
| Contar letras internacionales con size | size no cuenta automáticamente caracteres percibidos en UTF-8. |

## Autoevaluación

1. ¿El sufijo 12 ya es un número?
2. ¿Qué representa npos?
3. ¿size cuenta grafemas UTF-8?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad06-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-contenedores/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2007%20%28Texto%20con%20std%3A%3Astring%20y%20contratos%20de%20formato%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
