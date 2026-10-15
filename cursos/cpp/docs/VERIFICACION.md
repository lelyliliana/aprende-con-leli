# Verificación y alcance

[Curso](../README.md) · [Proyecto](../proyecto/README.md)

El curso incluye 42 ejemplos, 21 soluciones ejecutables y 4 etapas del proyecto. Se construyen programas separados con C++20 y advertencias exigentes. Las salidas esperadas se conservan en archivos de texto; el verificador no las reescribe para obtener un aprobado.

## Qué se comprueba

- Resultado, código de terminación y stderr de los 67 programas del manifiesto.
- Cuatro rechazos de captura de texto con el mismo programa de la Unidad 05.
- Un ejecutable con 30 comprobaciones de identidad, dominio, conversión, formato, límites y producto.
- Cuatro pruebas de CLI: entrada válida, entrada inválida, uso incorrecto y protección de la misma ruta. El caso válido también revisa que repetir una salida existente se rechace sin alterarla.
- Enlaces locales, bloques de Markdown y marcas de codificación en documentos.

Son 77 pruebas de CTest. Las 30 comprobaciones del ejecutable de contratos están dentro de una de ellas; no se suman como si fueran otras 30 pruebas superiores. Los casos de ejecución usan carpetas aisladas bajo build/ejecuciones y copian datos ficticios para repetir sin depender del estado de otra prueba.

La comparación de texto normaliza finales de línea CRLF/LF y espacios finales. No cambia los valores ni mensajes esperados. Los programas no dependen de direcciones de memoria, tiempos medidos, orden no declarado de contenedores ni números aleatorios que dificulten explicar una salida.

## Repetir paso a paso

Desde cursos/cpp, configura:

```text
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
```

Después construye:

```text
cmake --build build --config Debug --parallel 2
```

Cuando termine, ejecuta:

```text
ctest --test-dir build -C Debug --output-on-failure
```

Consulta build/Testing/Temporary/LastTest.log para investigar fallos. Una comprobación exitosa no requiere editar los esperados. Si cambias código, explica primero la nueva conducta y los casos que deberían detectarla.

## Instrumentación y configuraciones

Para un compilador GNU o Clang compatible, puedes configurar otra carpeta con CURSO_SANITIZERS=ON siguiendo la Unidad 20. Se activa AddressSanitizer y UndefinedBehaviorSanitizer. Sus hallazgos se refieren a los recorridos ejecutados y no prueban ausencia de errores para toda entrada posible.

La automatización prepara Windows con MSVC, macOS con AppleClang y Ubuntu con GCC y Clang, en configuraciones Debug y Release distribuidas entre sus trabajos. Añade una ejecución de Clang con sanitizadores. Consulta el resultado real del trabajo antes de declarar comprobado un entorno. No se utiliza assert como única comprobación que pueda desaparecer con NDEBUG.

## Evidencia local y límites didácticos

El entorno local utiliza GCC 13.3 y CMake 3.31.10. El material acompaña el código con 22 clases, 66 pasos de práctica y 22 retos, con sus respuestas. El código de los documentos se contrasta con los archivos compilados antes de publicar.

La revisión técnica complementa las explicaciones, no mide por sí sola cuánto aprenderá cada estudiante. La ruta cubre fundamentos hasta nivel intermedio y delimita temas posteriores. El proyecto usa un formato restringido y datos ficticios; no ofrece un sistema comercial concurrente ni escritura transaccional. Ninguna prueba del curso demuestra esas garantías adicionales.
