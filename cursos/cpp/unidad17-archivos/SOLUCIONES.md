# Soluciones razonadas de la Unidad 17

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Contar líneas reales

La cuenta es 2. No se añade una línea extra por comprobar eof antes de intentar leer.

## Paso 2. Exportar un resultado

Se escribe 2 y se comprueba el cierre. La salida es de práctica y puede reemplazarse al repetir, según el contrato de este ejemplo.

## Paso 3. Releer

La relectura recupera 2 y permite contrastar el contenido exportado.

## Reto de transferencia. Componer una ruta

La ruta compuesta representa el mismo destino en la plataforma. No se imprime un separador fijo como condición de portabilidad.

## Respuestas de autoevaluación

1. **¿Abrir garantiza escritura completa?** No; las operaciones y el cierre también pueden fallar.
2. **¿Desde dónde se interpreta datos/lectura.txt?** Desde la carpeta de trabajo de la ejecución.
3. **¿La salida de cualquier programa se puede releer con el lector de entrada?** Solo si comparten el esquema y contrato correspondiente.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>

int main() {
    std::ifstream entrada{"datos/lectura.txt"};
    if (!entrada) { return 2; }
    std::string linea;
    int filas{0};
    while (std::getline(entrada, linea)) { ++filas; }
    if (!entrada.eof()) { return 2; }
    std::cout << "Paso 1: líneas=" << filas << '\n';
    std::filesystem::create_directories("salidas");
    const std::filesystem::path ruta{"salidas/practica17.txt"};
    std::ofstream salida{ruta};
    if (!salida) { return 2; }
    salida << filas << '\n';
    salida.close();
    if (!salida) { return 2; }
    std::cout << "Paso 2: resultado escrito\n";
    std::ifstream copia{ruta};
    int recuperado{0};
    if (!(copia >> recuperado) || recuperado != filas) { return 2; }
    std::cout << "Paso 3: resultado releído=" << recuperado << '\n';
    const std::filesystem::path parte{"salidas"};
    const auto compuesta{parte / "practica17.txt"};
    std::cout << std::boolalpha << "Reto: ruta compuesta coincide=" << (compuesta == ruta) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u17_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u17_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u17_sol.exe` |

Salida esperada:

```text
Paso 1: líneas=2
Paso 2: resultado escrito
Paso 3: resultado releído=2
Reto: ruta compuesta coincide=true
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2017%20%28Archivos%2C%20rutas%20y%20persistencia%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
