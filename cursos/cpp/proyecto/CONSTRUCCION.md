# Construir el inventario una etapa cada vez

[Proyecto](README.md) · [Unidad 21](../unidad21-proyecto/README.md) · [Curso](../README.md)

La pregunta es calcular subtotales y total de materiales ficticios sin perder códigos ni admitir cantidades inválidas. Cada etapa tiene un programa completo y una versión de biblioteca que incorpora lo necesario hasta ese punto. Puedes construirlas por separado; no dependen de objetos de una ejecución anterior.

Para escribir tu propia versión, duplica la carpeta completa del curso como cpp-practica y abre esa copia. Conserva datos originales y referencias sin cambios. Comprueba la carpeta de trabajo antes de editar o ejecutar. Compara cada archivo con su versión proporcionada solo después de intentarlo.

## Etapa 1. Definir el registro y construir la lectura

Escribe primero el modelo Producto con código, cantidad y precio en centavos. El encabezado declara también las operaciones que se añadirán después. Una declaración no obliga a usar inmediatamente cada operación ni crea su implementación.

[Encabezado compartido](include/inventario.hpp):

```cpp
#ifndef CURSO_CPP_INVENTARIO_HPP
#define CURSO_CPP_INVENTARIO_HPP

#include <cstdint>
#include <filesystem>
#include <string>
#include <vector>

namespace inventario {
struct Producto {
    std::string codigo;
    std::int64_t cantidad;
    std::int64_t precio_centavos;
};
void validar(const std::vector<Producto>& productos);
std::vector<Producto> leer(const std::filesystem::path& entrada);
std::int64_t total(const std::vector<Producto>& productos);
void escribir(const std::filesystem::path& salida, const std::vector<Producto>& productos);
}
#endif
```

La lectura necesita interpretar un entero completo, separar exactamente tres campos, reconocer el encabezado y validar el lote. Lee las funciones auxiliares antes de escribir el ciclo:

1. entero comprueba que exista texto y que from_chars termine sin error justo en el final. Un prefijo numérico no basta.
2. campos busca cada punto y coma. Conserva incluso un campo final vacío para poder rechazar un número incorrecto de campos; no lo pierde por comodidad.
3. quitar_cr contempla el final de línea CRLF sin borrar contenido interior.
4. validar revisa tamaño de lote, formato del código, identidad y dominios numéricos.
5. leer revisa apertura y encabezado, interpreta filas y valida todo antes de devolver el vector.

El namespace sin nombre agrupa auxiliares de esta unidad de traducción. El namespace inventario contiene las operaciones que declara el encabezado. No copies las mismas definiciones en otro archivo que vayas a enlazar dentro de la misma meta.

Esta primera biblioteca todavía no define total ni escribir porque el programa de esta etapa no las utiliza. Es una versión completa para esa meta, no un archivo que debas enlazar junto a la biblioteca final.

[Biblioteca de lectura](etapas/01-lectura.cpp):

```cpp
#include <cstddef>
#include "inventario.hpp"
#include <algorithm>
#include <charconv>
#include <fstream>
#include <limits>
#include <set>
#include <stdexcept>
#include <system_error>

namespace {
std::int64_t entero(const std::string& texto) {
    if (texto.empty()) { throw std::invalid_argument{"Campo entero vacío"}; }
    std::int64_t valor{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), valor)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) {
        throw std::invalid_argument{"Campo entero incompleto o no representable"};
    }
    return valor;
}
std::vector<std::string> campos(const std::string& linea) {
    std::vector<std::string> resultado;
    std::size_t inicio{0};
    while (true) {
        const auto p{linea.find(';', inicio)};
        if (p == std::string::npos) { resultado.push_back(linea.substr(inicio)); break; }
        resultado.push_back(linea.substr(inicio, p - inicio));
        inicio = p + 1;
    }
    if (resultado.size() != 3) { throw std::invalid_argument{"Se requieren tres campos por registro"}; }
    return resultado;
}
void quitar_cr(std::string& linea) {
    if (!linea.empty() && linea.back() == '\r') { linea.pop_back(); }
}
}

namespace inventario {
void validar(const std::vector<Producto>& productos) {
    if (productos.empty() || productos.size() > 10000) {
        throw std::invalid_argument{"Se requieren entre 1 y 10000 productos"};
    }
    std::set<std::string> ids;
    for (const auto& p : productos) {
        if (p.codigo.empty() || p.codigo.size() > 20) { throw std::invalid_argument{"Longitud de código inválida"}; }
        for (const char c : p.codigo) {
            if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-' || c == '_')) {
                throw std::invalid_argument{"Código fuera del formato ASCII declarado"};
            }
        }
        if (!ids.insert(p.codigo).second) { throw std::invalid_argument{"Código duplicado"}; }
        if (p.cantidad < 0 || p.cantidad > 100000) { throw std::invalid_argument{"Cantidad fuera de 0 a 100000"}; }
        if (p.precio_centavos < 0 || p.precio_centavos > 100000000) {
            throw std::invalid_argument{"Precio fuera de 0 a 100000000 centavos"};
        }
    }
}

std::vector<Producto> leer(const std::filesystem::path& entrada) {
    std::ifstream archivo{entrada};
    if (!archivo) { throw std::runtime_error{"No se pudo abrir la entrada"}; }
    std::string linea;
    if (!std::getline(archivo, linea)) { throw std::invalid_argument{"Falta encabezado"}; }
    quitar_cr(linea);
    if (linea.starts_with("\xEF\xBB\xBF")) { linea.erase(0, 3); }
    if (linea != "codigo;cantidad;precio_centavos") { throw std::invalid_argument{"Encabezado inesperado"}; }
    std::vector<Producto> productos;
    while (std::getline(archivo, linea)) {
        quitar_cr(linea);
        if (linea.empty()) { throw std::invalid_argument{"Fila vacía no admitida"}; }
        const auto c{campos(linea)};
        productos.push_back({c.at(0), entero(c.at(1)), entero(c.at(2))});
        if (productos.size() > 10000) { throw std::invalid_argument{"Demasiados productos"}; }
    }
    if (!archivo.eof()) { throw std::runtime_error{"Lectura interrumpida"}; }
    validar(productos);
    return productos;
}

}
```

Construye un programa que llame leer y consulte size. La meta proyecto_paso1 enlaza únicamente la biblioteca de lectura:

```cpp
#include "inventario.hpp"
#include <iostream>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    std::cout << "Etapa 1: " << datos.size() << " productos validados\n";
    return 0;
}
```

```text
cmake --build build --config Debug --target proyecto_paso1
```

Ejecuta build/bin/proyecto_paso1 desde cursos/cpp (en Windows, build\bin\proyecto_paso1.exe).

**Antes de continuar:** debe indicar seis productos validados. Explica por qué una cantidad negativa y un código repetido se rechazan aunque ambos registros puedan leerse como texto. Revisa también la diferencia entre 0 y un campo vacío.

## Etapa 2. Añadir el cálculo con su unidad

Conserva la lectura y añade total dentro del namespace inventario. La cantidad por precio produce centavos. Los límites del diccionario hacen representables los productos del caso; la suma comprueba además su límite antes de acumular. No se calcula primero una suma desbordada para comprobarla después.

[La segunda biblioteca completa](etapas/02-calculo.cpp) conserva lo anterior y añade esta función:

```cpp
std::int64_t total(const std::vector<Producto>& productos) {
    validar(productos);
    std::int64_t acumulado{0};
    for (const auto& p : productos) {
        const auto subtotal{p.cantidad * p.precio_centavos};
        if (acumulado > std::numeric_limits<std::int64_t>::max() - subtotal) {
            throw std::overflow_error{"Total no representable"};
        }
        acumulado += subtotal;
    }
    return acumulado;
}
```

No pegues este fragmento como un programa con main: es la función que se agrega a la biblioteca. Su firma debe coincidir con la declaración. Después construye el programa de etapa:

```cpp
#include "inventario.hpp"
#include <iostream>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    const auto valor{inventario::total(datos)};
    std::cout << "Etapa 2: " << valor << " centavos\n";
    return 0;
}
```

```text
cmake --build build --config Debug --target proyecto_paso2
```

Ejecuta build/bin/proyecto_paso2 desde cursos/cpp (en Windows, build\bin\proyecto_paso2.exe).

**Antes de continuar:** reconstruye 55000 a mano: SENSOR 3000, CABLE 6000, PLACA 25000, MOTOR 20000, LED 1000 y CAJA 0. La suma es de subtotales, no de precios solos ni de códigos. La cantidad 0 de CAJA no desaparece del inventario.

## Etapa 3. Ordenar para comunicar, sin separar columnas

Reutiliza la segunda biblioteca. Ordena una copia de los registros completos por código y muestra sus subtotales. El comparador usa&lt; y no&lt;=. Cada precio permanece con su código; no ordenes solo la columna de precios.

```cpp
#include "inventario.hpp"
#include <iostream>
#include <algorithm>
int main() {
    auto datos{inventario::leer("datos/inventario.csv")};
    std::sort(datos.begin(), datos.end(), [](const auto& a, const auto& b) { return a.codigo < b.codigo; });
    for (const auto& p : datos) { std::cout << p.codigo << ";" << p.cantidad * p.precio_centavos << "\n"; }
    return 0;
}
```

```text
cmake --build build --config Debug --target proyecto_paso3
```

Ejecuta build/bin/proyecto_paso3 desde cursos/cpp (en Windows, build\bin\proyecto_paso3.exe).

**Antes de continuar:** la primera identidad debe ser CABLE y la última SENSOR. Explica por qué ordenar cambia la presentación pero no el total. Esta etapa todavía no escribe un reporte persistente.

## Etapa 4. Añadir la escritura y revisar el producto

La biblioteca final añade escribir. Valida y calcula antes de abrir el producto. Después exige una ruta que todavía no exista y ordena una copia. El archivo de reporte tiene cuatro columnas: es otro esquema y no se entrega al lector original de tres.

La función usa escritura directa, comprueba cierre y comunica fallos. No implementa transacciones ni bloqueo concurrente. Las comprobaciones de existencia y rutas protegen el uso local previsto; no representan un protocolo para varios procesos compitiendo por el mismo archivo.

```cpp
void escribir(const std::filesystem::path& salida, const std::vector<Producto>& productos) {
    validar(productos);
    const auto valor{total(productos)};
    (void)valor;
    if (std::filesystem::exists(salida)) { throw std::runtime_error{"La salida ya existe; elige otra ruta"}; }
    auto ordenados{productos};
    std::sort(ordenados.begin(), ordenados.end(), [](const Producto& a, const Producto& b) { return a.codigo < b.codigo; });
    std::ofstream archivo{salida};
    if (!archivo) { throw std::runtime_error{"No se pudo abrir la salida"}; }
    archivo << "codigo;cantidad;precio_centavos;subtotal_centavos\n";
    for (const auto& p : ordenados) {
        archivo << p.codigo << ';' << p.cantidad << ';' << p.precio_centavos << ';' << p.cantidad * p.precio_centavos << '\n';
    }
    archivo.close();
    if (!archivo) { throw std::runtime_error{"Escritura incompleta"}; }
}
```

El programa de etapa crea su carpeta solo después de la lectura validada y llama a la escritura:

```cpp
#include "inventario.hpp"
#include <iostream>
#include <filesystem>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    std::filesystem::create_directories("salidas/construccion");
    inventario::escribir("salidas/construccion/reporte.csv", datos);
    std::cout << "Etapa 4: reporte generado sin cambiar la entrada\n";
    return 0;
}
```

```text
cmake --build build --config Debug --target proyecto_paso4
```

Ejecuta build/bin/proyecto_paso4 desde cursos/cpp (en Windows, build\bin\proyecto_paso4.exe).

Abre salidas/construccion/reporte.csv y compáralo con la [muestra](muestra/reporte.csv). Si repites directamente esa etapa y la salida ya existe, se rechazará según su política. Conserva tus evidencias y elige otra ruta en tu copia; CTest prepara una carpeta aislada nueva al repetir sus pruebas.

**Antes de continuar:** comprueba encabezado, seis filas ordenadas, subtotal de cada código y conservación de CAJA. Un archivo existente no demuestra por sí mismo que sus números sean correctos.

## Etapa 5. Convertir el flujo en una aplicación con argumentos

Abre main.cpp. La aplicación exige entrada y salida; comprueba argc antes de consultar argv. Un try concentra el flujo completo y un catch comunica el fallo con código 2. La entrada se lee y valida antes de crear carpetas. Si ambas rutas representan el mismo archivo, se rechaza la operación.

```cpp
#include "inventario.hpp"
#include <exception>
#include <stdexcept>
#include <system_error>
#include <filesystem>
#include <iostream>

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Uso: inventario entrada.csv salida.csv\n";
        return 2;
    }
    try {
        const std::filesystem::path entrada{argv[1]};
        const std::filesystem::path salida{argv[2]};
        const auto productos{inventario::leer(entrada)};
        const auto valor{inventario::total(productos)};
        std::error_code error;
        const bool mismo_archivo{std::filesystem::equivalent(entrada, salida, error)};
        if (mismo_archivo || std::filesystem::weakly_canonical(entrada) == std::filesystem::weakly_canonical(salida)) {
            throw std::runtime_error{"Entrada y salida deben ser archivos distintos"};
        }
        // La entrada se validó antes de crear carpetas o abrir productos de salida.
        if (!salida.parent_path().empty()) { std::filesystem::create_directories(salida.parent_path()); }
        inventario::escribir(salida, productos);
        std::cout << "Registros: " << productos.size() << '\n';
        std::cout << "Total: " << valor << " centavos\n";
        std::cout << "Reporte generado sin modificar la entrada\n";
        return 0;
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << '\n';
        return 2;
    }
}
```

Construye la aplicación:

```text
cmake --build build --config Debug --target inventario
```

Desde cursos/cpp, elige una ruta de salida nueva:

| Sistema | Ejecutar |
|---|---|
| Linux/macOS | `./build/bin/inventario datos/inventario.csv salidas/mi-reporte.csv` |
| Windows | `.\build\bin\inventario.exe datos/inventario.csv salidas/mi-reporte.csv` |

Debe informar 6 registros, 55000 centavos y reporte generado. Si la salida ya existe, elige otra ruta; no borres un archivo personal para conseguir que la prueba pase.

## Evaluar con evidencia

| Criterio | Producto verificable (10 puntos) | Explicación (10 puntos) |
|---|---|---|
| Pregunta y modelo | Datos, diccionario y clave identificados | Unidades y alcance ficticio justificados |
| Calidad | Casos de formato, dominio e identidad | Rechazos y conservación de fuente razonados |
| Diseño | Funciones y archivos construidos | Responsabilidad de cada parte y dependencias claras |
| Resultados | Subtotales, reporte y código de terminación correctos | Cuenta independiente y revisión del producto |
| Reproducción | Comandos, entorno y pruebas | Otra persona puede reconstruir el flujo |

Anota qué evidencia falta antes de asignarte los puntos. Una captura sin fuentes o una prueba sin explicación no cubre las dos mitades de un criterio. La rúbrica orienta una revisión, no una certificación automática.

## Probar y transferir

Construye todo y ejecuta CTest con la guía de verificación. La suite investiga límites, duplicados, conversión parcial, CRLF, BOM, reporte, rutas y rechazo previo. Una ampliación como préstamos necesita una especificación nueva antes de cambiar datos y clases. Conserva estos casos y añade el que represente la decisión nueva.

[Volver al proyecto](README.md) · [Práctica final](../unidad21-proyecto/PRACTICA.md) · [Soluciones](../unidad21-proyecto/SOLUCIONES.md)
