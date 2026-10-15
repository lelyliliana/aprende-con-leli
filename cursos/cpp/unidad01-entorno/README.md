# Unidad 01. Compilar y ejecutar el primer programa

[Anterior](../unidad00-ruta/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-tipos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Identificar los archivos.
- Leer el punto de entrada.
- Predecir precedencia.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Del archivo de texto a un ejecutable

Antes de comenzar prepara el entorno con la [guía de instalación](../docs/ENTORNO.md). Completa un paso cada vez: compilador, CMake, proyecto y primera construcción. Un editor permite escribir; el compilador traduce; CMake organiza la construcción. Instalar una extensión del editor no sustituye el compilador.

### Lee el primer programa por piezas

#include &lt;iostream&gt; incorpora declaraciones de entrada/salida de la biblioteca estándar. int main() define el punto de entrada. Las llaves delimitan su cuerpo. std::cout representa la salida estándar y `<<` envía un texto a ese flujo. "Hola, C++" es un literal de texto; \n dentro de la cadena produce un salto de línea. El punto y coma termina la instrucción.

std:: indica el espacio de nombres de la biblioteca estándar. Lo escribimos explícitamente para reconocer de dónde viene cada herramienta. No necesitas crear ese espacio ni memorizar todos sus componentes. return 0 comunica terminación exitosa del programa; escribir un mensaje que diga «correcto» y devolver un código de fallo sería una señal contradictoria para una automatización.

### Distingue tres momentos

El archivo 01.cpp es fuente. Al compilar y enlazar aparece un ejecutable en build/bin. Ejecutarlo muestra el mensaje. Cambiar el fuente no cambia un ejecutable ya construido: debes volver a construir. En C++ una orden de ejecución no interpreta automáticamente el texto .cpp.

| Etapa | Entrada | Resultado |
|---|---|---|
| Compilación | Código fuente y cabeceras | Código objeto para esa implementación |
| Enlace | Objetos y bibliotecas requeridas | Ejecutable |
| Ejecución | Ejecutable y entradas | Salida, código de terminación o efectos |

Un error de sintaxis aparece antes de ejecutar. Una definición ausente puede aparecer durante el enlace. Un archivo que no se puede abrir aparece al ejecutar. Clasificar el momento evita buscar una corrección en el lugar equivocado.

### Construye una sola meta

La configuración del curso registra muchos programas, pero puedes construir solo u01_e01. Los ejemplos tienen main separados y no deben pegarse juntos en un único archivo. Las órdenes bajo cada ejemplo indican su meta y cómo ejecutarla según el sistema.

### Conserva una ejecución limpia

Guarda el archivo antes de construir. Si una compilación falla, no ejecutes un binario anterior creyendo que corresponde al cambio reciente. Lee el primer diagnóstico y comprueba archivo y línea. La numeración exacta y el texto del compilador pueden variar; la causa debe investigarse con la misma entrada.

En el segundo ejemplo hay dos instrucciones de salida: se evalúan en el orden del cuerpo de main. La separación en líneas del archivo facilita leer el programa; el salto visible en su resultado procede de `\n`, no de cómo acomodaste la instrucción en el editor.

## Ejemplo 1. Del código fuente al mensaje

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    std::cout << "Hola, C++\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u01_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u01_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u01_e01.exe` |

Salida esperada:

```text
Hola, C++
```

### Lectura paso a paso

La cabecera debe aparecer antes del uso de std::cout. main entra una vez y la instrucción envía el saludo; return 0 termina. El programa no lee un teclado ni utiliza un archivo externo, por lo que las mismas fuentes deben producir el mismo mensaje en las plataformas comprobadas.

## Ejemplo 2. Dos instrucciones en orden

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    std::cout << "Primero leo la pregunta.\n";
    std::cout << "Después ejecuto el programa.\n";
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u01_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u01_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u01_e02.exe` |

Salida esperada:

```text
Primero leo la pregunta.
Después ejecuto el programa.
```

### Lectura paso a paso

Las dos cadenas se muestran en dos líneas porque cada una contiene\n. Predice su orden antes de ejecutar. Compara salida y código de terminación: son evidencias distintas que las pruebas revisan.

## Experimenta

En una copia cambia el saludo y vuelve a construir. Después invierte las dos instrucciones del segundo ejemplo: predice el orden de salida. No añadas otro main al mismo programa.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Ejecutar 01.cpp como si fuera un programa | Construye primero y ejecuta la meta generada. |
| Ver el mensaje anterior tras editar | Guarda y vuelve a compilar antes de ejecutar. |
| Pegar dos ejemplos completos juntos | Cada uno tiene su propio main y su propia meta. |

## Autoevaluación

1. ¿Compilar es ejecutar?
2. ¿Qué crea el salto visible?
3. ¿Qué debes hacer al cambiar el fuente?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad00-ruta/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-tipos/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2001%20%28Compilar%20y%20ejecutar%20el%20primer%20programa%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
