# Unidad 17. Archivos, rutas y persistencia

[Anterior](../unidad16-mapas/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-plantillas/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Contar líneas reales.
- Exportar un resultado.
- Releer.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un archivo necesita estructura, ruta y gestión de fallos

std::ifstream lee y std::ofstream escribe. Ambos gestionan el recurso mediante su vida útil. Abrir un archivo no garantiza que toda lectura o escritura posterior tenga éxito: revisa el estado en los puntos que importan para tu entrega.

### Resuelve la ruta desde el lugar correcto

datos/lectura.txt se interpreta desde la carpeta de trabajo, no desde el lugar donde está el ejecutable. Los comandos de esta ruta parten de cursos/cpp. Las pruebas copian sus datos a una carpeta aislada de ejecución y trabajan desde allí. Ningún ejemplo necesita una ruta privada del computador de la autora.

std::filesystem::path representa rutas y el operador/ compone partes sin escribir manualmente el separador específico del sistema. La ruta puede ser válida como texto y apuntar a un archivo ausente o inaccesible: son condiciones que se investigan al abrir.

### Lee mediante la operación

while(getline(entrada, linea)) solo utiliza líneas leídas. Después se distingue final esperado de una interrupción de lectura con la revisión del estado. No uses while(!eof()) para procesar una última línea que quizá no exista. El archivo docente tiene dos registros pequeños para que puedas contrastar la cuenta.

La lectura de líneas puede recibir finales LF o CRLF. El ejemplo retira un CR final cuando está presente. Eso no elimina espacios internos de un campo ni implementa un analizador general de CSV. Separar líneas es solo una parte del contrato de un formato.

### Escribe en un lugar de resultados

El segundo programa crea salidas y escribe un archivo de práctica. Esa ruta puede reemplazar el resultado de una ejecución anterior: no la utilices para un documento personal. El archivo de entrada permanece separado. La aplicación final tendrá una política adicional que rechazará una salida existente.

Después de escribir se llama close y se consulta el estado para observar errores que puedan manifestarse al finalizar. El destructor sigue siendo quien gestiona el recurso al salir del alcance, pero una entrega necesita decidir cómo comunicar un cierre fallido, no asumir que todo salió bien porque se abrió inicialmente.

### Relee para verificar el producto

Conservar un resultado en memoria no demuestra que se haya exportado. La relectura de esta práctica comprueba el contenido guardado. El formato de salida debe estar definido; si tiene columnas distintas de la entrada, no se le aplica automáticamente el mismo lector.

### Acota las garantías

Una validación previa evita producir resultados de una entrada rechazada. No vuelve transaccional una secuencia de escrituras ante un corte de energía. Esta ruta enseña una aplicación local pequeña: control de concurrencia, recuperación y copias persistentes exigirían otro diseño. Los mensajes y códigos de terminación permiten distinguir una entrega realizada de un fallo observado.

## Ejemplo 1. Leer líneas y distinguir fallo de apertura

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream entrada{"datos/lectura.txt"};
    if (!entrada) { std::cerr << "No se pudo abrir datos/lectura.txt\n"; return 2; }
    std::string linea;
    int filas{0};
    while (std::getline(entrada, linea)) {
        if (!linea.empty() && linea.back() == '\r') { linea.pop_back(); }
        ++filas;
        std::cout << filas << ": " << linea << '\n';
    }
    if (!entrada.eof()) { std::cerr << "Lectura interrumpida\n"; return 2; }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u17_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u17_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u17_e01.exe` |

Salida esperada:

```text
1: SENSOR;5
2: CABLE;12
```

### Lectura paso a paso

Se abre una ruta relativa, se comprueba apertura y se procesan dos líneas. Cada contador se incrementa tras una lectura exitosa. Al final se espera eof; otra interrupción debe comunicarse como fallo en lugar de fingir un conjunto completo.

## Ejemplo 2. Escribir un resultado y volver a leerlo

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>

int main() {
    std::filesystem::create_directories("salidas");
    const std::filesystem::path ruta{"salidas/unidad17.txt"};
    {
        std::ofstream salida{ruta};
        if (!salida) { return 2; }
        salida << "Resumen de práctica\n";
        salida.close();
        if (!salida) { return 2; }
    }
    std::ifstream entrada{ruta};
    std::string linea;
    if (!std::getline(entrada, linea)) { return 2; }
    std::cout << "Leído de la salida: " << linea << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u17_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u17_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u17_e02.exe` |

Salida esperada:

```text
Leído de la salida: Resumen de práctica
```

### Lectura paso a paso

La escritura sucede en un bloque para delimitar su recurso. Después se abre otra entrada sobre ese resultado y se compara el mensaje recuperado. Crear la carpeta y abrir el archivo son efectos que deben estar explicados en el contrato.

## Experimenta

Desde la raíz, identifica las dos líneas originales y predice el contador. Luego ejecuta el mismo binario desde otra carpeta sin datos y explica por qué puede fallar la ruta aunque el ejecutable exista. Regresa a la carpeta del curso antes de seguir.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Creer que una ruta relativa parte del ejecutable | Comprueba la carpeta de trabajo. |
| Usar eof como promesa de una lectura futura | Evalúa el resultado de getline. |
| Comprobar solo apertura de salida | Revisa escritura/cierre y relee el producto cuando corresponda. |

## Autoevaluación

1. ¿Abrir garantiza escritura completa?
2. ¿Desde dónde se interpreta datos/lectura.txt?
3. ¿La salida de cualquier programa se puede releer con el lector de entrada?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad16-mapas/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-plantillas/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2017%20%28Archivos%2C%20rutas%20y%20persistencia%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
