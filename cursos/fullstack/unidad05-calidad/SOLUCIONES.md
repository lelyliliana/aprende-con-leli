# Soluciones de la Unidad 05

[Volver a la unidad](README.md)

Intenta los ejercicios antes de leer. Las respuestas explican criterios y admiten otras implementaciones coherentes.

1. Testing Library con respuesta controlada verifica que el formulario no se borra. La prueba HTTP contra el backend y las pruebas de persistencia verifican que el servidor no duplica el SKU. Son evidencias complementarias.

2. Una prueba válida provoca rechazo, actúa sobre el botón y espera el mensaje visible. Debe fallar si retiras ese mensaje. Evita afirmar que prueba una base cuando la respuesta está simulada.

3. Clasifica por observación: conexión rechazada es red; 400 con campos es validación HTTP; 409 es conflicto; texto ilegible o foco perdido pertenece a interfaz. Un 500 también es respuesta HTTP, aunque se origine en otro componente.

**Reto:** comprueba que un producto con SKU conocido lo presenta después de la consulta. Asegura que la expectativa depende de los datos devueltos y no de un texto estático repetido.
