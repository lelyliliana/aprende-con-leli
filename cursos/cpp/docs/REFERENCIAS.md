# Referencias y cómo utilizarlas

[Curso](../README.md)

Las explicaciones, ejemplos y datos del curso están escritos para esta ruta. Las fuentes siguientes permiten contrastar reglas y herramientas; no sustituyen el desarrollo progresivo de cada unidad.

| Fuente primaria | Uso en el curso |
|---|---|
| [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines) | Contratos pequeños, propiedad, RAII e interfaces |
| [Borrador público de C++](https://eel.is/c++draft/) | Consultar reglas del lenguaje y biblioteca; el borrador evoluciona y puede incluir funciones posteriores a C++20 |
| [Estado de C++ en GCC](https://gcc.gnu.org/projects/cxx-status.html) | Contrastar soporte del compilador, sin asumir que todo C++20 se usa aquí |
| [Documentación de Clang](https://clang.llvm.org/docs/) | Herramientas, diagnósticos e instrumentación |
| [AddressSanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) | Alcance de detección en ejecuciones instrumentadas |
| [UndefinedBehaviorSanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html) | Comprobaciones de comportamiento indefinido instrumentado |
| [Microsoft C++](https://learn.microsoft.com/en-us/cpp/build/walkthrough-compiling-a-native-cpp-program-on-the-command-line) | Instalación y terminal de desarrollo de Windows |
| [Herramientas de Apple](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/) | Preparación del compilador en macOS |
| [Tutorial de CMake](https://cmake.org/cmake/help/latest/guide/tutorial/index.html) | Metas, construcción y pruebas |
| [CTest](https://cmake.org/cmake/help/latest/manual/ctest.1.html) | Ejecución y selección de pruebas |

La base elegida es C++20. No se afirma que sea la versión más reciente ni que cualquier función aparecida en un borrador posterior esté disponible. Las versiones efectivamente utilizadas y resultados se describen en [verificación](VERIFICACION.md).
