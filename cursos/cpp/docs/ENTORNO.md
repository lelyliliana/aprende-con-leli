# Preparar el entorno una etapa cada vez

[Curso](../README.md) · [Primera ejecución](../unidad01-entorno/README.md)

Necesitas un compilador con las funciones C++20 utilizadas aquí, CMake y un editor de texto. VS Code es una opción de editor; una extensión no instala por sí sola el compilador. No necesitas Python, una cuenta de pago ni una placa electrónica.

## Paso 1. Preparar el compilador de tu sistema

### Windows

Instala las herramientas C++ desde [Visual Studio](https://visualstudio.microsoft.com/downloads/). Puedes elegir Visual Studio Community o Build Tools. En el instalador selecciona la carga **Desarrollo para el escritorio con C++**, con el compilador MSVC y el SDK de Windows propuestos. No basta instalar solo el editor VS Code.

Al terminar abre la **terminal de desarrollo de Visual Studio para x64**. Su nombre puede variar entre versiones (Developer Command Prompt o Developer PowerShell). Allí ejecuta:

```text
cl
```

Debe aparecer la identificación del compilador, aunque también informe que no recibió archivo fuente. Una terminal ordinaria puede no tener sus rutas configuradas. Utiliza la terminal preparada antes de cambiar variables del sistema. Consulta el [recorrido oficial de Microsoft](https://learn.microsoft.com/en-us/cpp/build/walkthrough-compiling-a-native-cpp-program-on-the-command-line).

### macOS

Prepara las herramientas de línea de comandos de Apple siguiendo su [guía oficial](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/). Desde Terminal puedes iniciar su instalación con:

```text
xcode-select --install
```

Completa el instalador y abre una terminal nueva. Después comprueba:

```text
clang++ --version
```

Necesitas herramientas y biblioteca estándar con las funciones C++20 del curso. Si una instalación antigua no las admite, actualiza las herramientas compatibles con tu sistema antes de modificar los ejemplos.

### Linux

Instala el compilador C++ y las herramientas de construcción de tu distribución. El entorno local comprobado utiliza GCC 13.3. En Ubuntu, si todavía no están instalados, primero actualiza el índice:

```text
sudo apt update
```

Después instala las herramientas:

```text
sudo apt install build-essential cmake
```

Comprueba el compilador:

```text
g++ --version
```

Los comandos de instalación de otra distribución pueden ser diferentes; no copies los de Ubuntu como si fueran universales.

## Paso 2. Comprobar CMake

Abre una terminal nueva y ejecuta:

```text
cmake --version
```

El proyecto declara CMake 3.20 como mínimo. Si no está disponible, instala una versión compatible desde [CMake](https://cmake.org/download/). En Windows conviene la versión actual del instalador para reconocer tus herramientas de Visual Studio y habilitar su uso desde PATH. CMake no sustituye al compilador que preparaste en el paso anterior.

## Paso 3. Obtener y abrir el curso

Descarga Aprende con Leli como ZIP desde [GitHub](https://github.com/lelyliliana/aprende-con-leli) y extráelo. También puedes clonarlo si ya utilizas Git. Abre la carpeta cursos/cpp en tu editor y sitúa allí la terminal. Debes ver CMakeLists.txt, datos y las unidades. No trabajes dentro del ZIP sin extraer.

Los ejemplos parten de esa carpeta. No sustituyas rutas compartidas por nombres privados de tu equipo. Si el editor abre una terminal en otra ubicación, corrígela antes de configurar o ejecutar.

## Paso 4. Configurar la construcción

Desde cursos/cpp:

```text
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
```

-S indica las fuentes y -B una carpeta separada para productos de construcción. Debug facilita estudiar estados en un depurador. En Visual Studio, que maneja varias configuraciones, la configuración se elige también al construir con --config; CMAKE_BUILD_TYPE corresponde a generadores de una sola configuración.

Debe terminar la configuración correctamente. Si no encuentra el compilador, vuelve al paso 1 y comprueba la terminal apropiada. No continúes ejecutando un binario anterior después de una construcción fallida.

## Paso 5. Construir solo el primer ejemplo

```text
cmake --build build --config Debug --target u01_e01
```

La meta identifica un programa, no una carpeta que debas escribir completa. Espera a que termine sin errores.

## Paso 6. Ejecutar

| Sistema | Comando desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u01_e01` |
| Windows | `.\build\bin\u01_e01.exe` |

Debe mostrar **Hola, C++**. Esta construcción coloca los ejecutables en build/bin también cuando el generador maneja varias configuraciones. Si cambias de compilador, utiliza otra carpeta de construcción, por ejemplo build-clang; no reutilices una caché que corresponde a otra herramienta.

Si los acentos se ven incorrectos en una consola de Windows, revisa que fuente y terminal utilicen UTF-8. La construcción de MSVC declara /utf-8; una consola antigua puede necesitar seleccionar la página de códigos 65001. Los códigos de datos del proyecto usan ASCII y no dependen de convertir nombres internacionales.

## Paso 7. Estudiar y verificar

Continúa con la lectura del programa en la Unidad 01. Cada ejemplo tiene una meta y una salida. Para construir todo, cuando lo necesites:

```text
cmake --build build --config Debug --parallel 2
```

Después ejecuta las pruebas:

```text
ctest --test-dir build -C Debug --output-on-failure
```

Construir y probar son operaciones diferentes. La Unidad 19 explica esas herramientas; puedes utilizarlas desde el inicio siguiendo las metas sin necesitar escribir todavía su configuración.
