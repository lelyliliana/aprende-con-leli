# Soluciones de aplicación: Java avanzado

[Volver a la guía](README.md)

Intenta los ejercicios antes de leer.

## 1. Criterio de respuesta

La operación declarativa debe conservar el contrato del resultado. Optional representa ausencia, no una razón para ocultar una excepción indiscriminadamente.

## 2. Criterio de respuesta

Una carrera es no determinista. La corrección exige una estrategia de coordinación y pruebas de su comportamiento; no exigir que el ejemplo incorrecto falle siempre.

## 3. Criterio de respuesta

Mockito controla la dependencia de almacenamiento; un socket local observa comunicación real. Ninguna prueba acredita por sí sola durabilidad ante cortes ni seguridad de un servicio público.

