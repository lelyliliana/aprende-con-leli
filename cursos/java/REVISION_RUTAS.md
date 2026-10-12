# Revisión de las rutas públicas de Java

Revisión del 12 de octubre de 2026. [Ver el curso completo](https://lelyliliana.github.io/aprende-con-leli/cursos/java/).

Java Fundamentos y Java Avanzado consultan ahora temas, laboratorios, prácticas y soluciones del [Curso-Java público](https://github.com/lelyliliana/Curso-Java/tree/c58a1b1a8a6ba0930643391a58cb1f5519014d42). Sus guías propias orientan selección, ejercicios de aplicación y avance; el material del lenguaje conserva una única fuente pública.

## Comprobación

Se ejecutó scripts/verificar.py del curso público, con Linux, JDK 21.0.12.1, Maven 3.9.16 y Python.

| Evidencia | Resultado |
|---|---|
| Unidades y referencias locales del curso público | 31 unidades y 416 referencias comprobadas |
| Laboratorios | 27 compilados y ejecutados |
| Ejemplos conservados | 26 ejecutados; cliente/servidor compilados |
| Pruebas JUnit/Mockito | 56 correctas |
| JAR de proyecto mínimo e inventario | Ejecutados y comprobados |
| Comprobaciones acumuladas del verificador | 868 correctas |
| Enlaces de las rutas a unidades públicas | Comprobados |

Las 868 comprobaciones incluyen documentación y expectativas de ejecución; no representan 868 pruebas independientes de Java.

## Alcance

Las rutas muestran los temas disponibles en el curso público: fundamentos/POO/archivos y genéricos/funcional/concurrencia/sockets/pruebas. No anuncian Swing, RMI ni cantidades de ejemplos que pertenecían a los antiguos materiales.

La verificación local no incluyó inspección visual, ejecución en Windows/macOS ni una certificación de durabilidad, edición simultánea o seguridad de un servicio público. Una condición de carrera deliberadamente incorrecta no se exige fallar en todas las ejecuciones. El laboratorio de redes comprueba TCP local sobre loopback.

Para repetir, prepara el entorno según la guía pública y ejecuta python scripts/verificar.py desde la raíz de Curso-Java.
