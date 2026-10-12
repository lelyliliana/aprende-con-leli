# Unidad 00. Punto de entrada y forma de estudiar

[Volver al índice](../README.md)

## Objetivos

- Elegir un punto de entrada según lo que ya puedes hacer.
- Distinguir un curso de integración de los cursos de cada tecnología.
- Preparar dos procesos locales y conservar evidencia de tu aprendizaje.

## Antes de comenzar

Este curso es de nivel intermedio: integra tecnologías que se enseñan en otros cursos públicos de Aprende con Leli. No necesitas haber estudiado en una universidad ni conocer su organización de asignaturas. Tampoco debes completar todos los cursos previos para repasar un tema que ya dominas.

Para desarrollar el recorrido, necesitas un computador donde puedas ejecutar Java 21, Maven, Node.js 24 y npm, además de Git y un navegador. No requiere GPU, Docker ni contratar un servicio en la nube. La instalación exacta está en el [laboratorio](../laboratorio/README.md#paso-1-comprobar-herramientas).

## 1. Qué construirás

Una interfaz permite a una persona consultar y gestionar productos. Una API recibe sus peticiones y valida las entradas; una base de datos conserva la información. El problema de integración es acordar cómo se comunican esas partes y qué sucede cuando algo falla.

Usaremos el mismo catálogo en tres etapas ejecutables:

| Etapa | Pregunta que responde | URL local después de iniciar el laboratorio |
|---|---|---|
| 1. Consulta | ¿Cómo llega un dato de la base a React? | http://127.0.0.1:5173/?etapa=1 |
| 2. Creación | ¿Cómo sale un formulario y vuelve la confirmación? | http://127.0.0.1:5173/?etapa=2 |
| 3. Integración | ¿Cómo editar, borrar, filtrar y resolver fallos? | http://127.0.0.1:5173/?etapa=3 |

Los enlaces locales no funcionan en el celular si el laboratorio está en otro equipo. GitHub presenta código e instrucciones; no inicia Spring Boot para ti.

## 2. Diagnóstico de entrada

Intenta estas tareas sin buscar la solución primero. Si una tarea se dificulta, consulta el enlace puntual y vuelve a intentarla.

| Tarea | Evidencia | Refuerzo si hace falta |
|---|---|---|
| Crear un formulario con label e input | El nombre del campo se lee y el teclado permite recorrerlo | [Formularios HTML](https://github.com/lelyliliana/Curso-HTML-CSS/blob/main/unidad07-formularios/README.md) |
| Distinguir string y number en una entrada | Explicas por qué convertir precio | [Tipos JavaScript](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad01-tipos/README.md) |
| Interpretar async/await y una petición fetch | Separas espera, éxito y fallo | [Fetch](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad20-fetch/README.md) |
| Crear un componente con estado | Un input cambia al escribir | [Estado React](https://github.com/lelyliliana/Curso-React/blob/main/unidad07-usestate/README.md) |
| Reconocer Controller, Service y Repository | Identificas quién recibe, decide y guarda | [Capas Spring Boot](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad10-capas/README.md) |

Si todavía no puedes desarrollar una función o comprender clases Java, usa primero los cursos públicos de [JavaScript](https://github.com/lelyliliana/Curso-JavaScript) y [Java](https://github.com/lelyliliana/Curso-Java). Este recorrido no repite desde cero esos lenguajes.

## 3. Cómo estudiar cada unidad

Primero predice qué debe pasar; luego ejecuta el ejemplo. Observa una petición o salida, cambia una condición y explica el resultado. Resuelve la práctica antes de abrir SOLUCIONES. Las soluciones explican el criterio y no reemplazan tu intento.

No avances solo porque pudiste copiar un comando. Usa las comprobaciones del cierre de la unidad: están diseñadas para mostrar si puedes trasladar lo aprendido a otro caso.

## Ejercicios

1. Escribe qué partes de una creación de producto pertenecen al navegador y cuáles al servidor.
2. Usa el diagnóstico y elige dos temas que puedes omitir y uno que necesitas repasar. Justifica con una tarea realizada, no con “ya lo vi”.
3. Crea una bitácora en tu proyecto con estas columnas: unidad, predicción, resultado, error y explicación. No incluyas credenciales ni datos personales.

## Reto

Explica a otra persona el recorrido de un producto desde un formulario hasta su lectura posterior. Señala qué partes seguirían funcionando si cierras la pestaña y cuáles si detienes Java.

## Errores frecuentes

- Leer todos los cursos enlazados como un requisito obligatorio: usa el diagnóstico para consultar lo que te falta.
- Intentar ejecutar JSX haciendo doble clic: inicia el entorno de Vite.
- Confundir el curso publicado con una API pública disponible: la práctica se ejecuta localmente.

## Comprobación para avanzar

Puedes distinguir las tres capas, elegir tu punto de entrada y explicar cómo estudiarás sin depender de un docente. Consulta las soluciones solo después de intentar los ejercicios.

## Continuar

- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Comunicación HTTP y contrato](../unidad01-http/README.md)
