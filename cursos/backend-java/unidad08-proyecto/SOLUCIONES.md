# Soluciones desarrolladas de la Unidad 08

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Requisitos desarrollados

«Usar Spring Boot» es una elección tecnológica. «Al crear dos veces el mismo SKU, la segunda petición devuelve 409 y queda una sola fila» es aceptación observable. Añade de la misma manera edición con versión vigente y rechazo de una vieja sin pérdida del dato aceptado.

Si eliges máximo 500, la referencia todavía no lo implementa. Debes actualizar contrato, reglas de creación/actualización y pruebas del límite. Una captura con precio 400 no demuestra el rechazo de 500.01.

## 2. Instalación reproducible

Una guía suficiente identifica la raíz del proyecto, revisión, JDK/Maven, comandos, datos ficticios, configuración externa, puerto y respuesta esperada. Debe distinguir iniciar el backend de abrir un cliente y explicar cómo detenerlo. La ruta de H2 en archivo necesita ser la misma después del reinicio.

## 3. Decisiones justificadas

Separar transporte y caso de uso permite probar la regla sin abrir HTTP. UNIQUE protege unicidad en el motor donde convergen transacciones. La versión evita sobrescribir una intención aceptada con una edición vieja. Un proveedor controlado hace repetibles fallos externos sin depender de Internet. Cada decisión se justifica por un riesgo concreto.

## Resolución del reto y rúbrica

La demostración presenta POST válido, rechazo de formato, actualización aceptada y otra vieja rechazada, GET posterior y un registro correlacionado. Dos peticiones sucesivas prueban versión antigua; una carrera real exige coordinarlas y registrar ambas respuestas. No confundas esos escenarios.

Los seis criterios suman 100: 15 + 20 + 20 + 15 + 15 + 15. Adjunta evidencia en cada fila. Declara como límites lo que falta implementar o ejecutar, por ejemplo identidad externa, PostgreSQL o benchmark. El resultado mínimo es un backend pequeño que otra persona pueda ejecutar y explicar, con reglas completas para su alcance.
