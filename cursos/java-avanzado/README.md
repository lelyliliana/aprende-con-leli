# Java avanzado

[Ver esta ruta en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/java-avanzado/) · [Curso completo de Java](https://github.com/lelyliliana/Curso-Java)

Profundiza con genéricos, programación funcional, concurrencia, redes, pruebas y proyectos, sobre el curso público de Java.

## Punto de entrada

Debes poder diseñar clases, manejar excepciones, usar colecciones y explicar una función. Si hace falta, vuelve a [Fundamentos y POO](../java-fundamentos/README.md).

## Preparar y estudiar

Sigue [entorno](https://github.com/lelyliliana/Curso-Java/blob/main/docs/ENTORNO.md). Cada unidad indica carpeta y comandos de su laboratorio; los laboratorios de terminal y los proyectos Maven no se ejecutan todos desde la misma carpeta.

Predice el resultado, ejecuta, modifica un caso y resuelve PRACTICA.md antes de leer SOLUCIONES.md en el curso público. Si una operación no se entiende, consulta su unidad en vez de duplicar el tema en otra ruta.

## Recorrido

### 1. Tipos y procesamiento de datos

Usa genéricos, lambdas y Streams con contratos y valores ausentes explícitos.

- [Unidad 17. Genéricos](https://github.com/lelyliliana/Curso-Java/blob/main/unidad17-genericos/README.md)
- [Unidad 18. Lambdas](https://github.com/lelyliliana/Curso-Java/blob/main/unidad18-lambdas/README.md)
- [Unidad 19. Streams](https://github.com/lelyliliana/Curso-Java/blob/main/unidad19-streams/README.md)
- [Unidad 20. Optional](https://github.com/lelyliliana/Curso-Java/blob/main/unidad20-optional/README.md)

### 2. Concurrencia

Estudia identidad de tareas, coordinación y fallos antes de asumir un orden de ejecución.

- [Unidad 21. Threads y tareas](https://github.com/lelyliliana/Curso-Java/blob/main/unidad21-threads/README.md)
- [Unidad 22. Executors y sincronización](https://github.com/lelyliliana/Curso-Java/blob/main/unidad22-concurrencia/README.md)

### 3. Comunicación

Observa un intercambio TCP local y los límites de la comunicación.

- [Unidad 23. Redes con sockets](https://github.com/lelyliliana/Curso-Java/blob/main/unidad23-redes/README.md)

### 4. Construcción y pruebas

Comprueba reglas y dependencias con Maven, JUnit y Mockito.

- [Unidad 24. Maven](https://github.com/lelyliliana/Curso-Java/blob/main/unidad24-maven/README.md)
- [Unidad 25. JUnit](https://github.com/lelyliliana/Curso-Java/blob/main/unidad25-junit/README.md)
- [Unidad 26. Mockito](https://github.com/lelyliliana/Curso-Java/blob/main/unidad26-mockito/README.md)

### 5. Diagnóstico y diseño

Mejora código con evidencia y configuración externa.

- [Unidad 27. Diagnóstico y configuración](https://github.com/lelyliliana/Curso-Java/blob/main/unidad27-diagnostico/README.md)
- [Unidad 28. Buenas prácticas](https://github.com/lelyliliana/Curso-Java/blob/main/unidad28-buenas-practicas/README.md)

### 6. Integración

Construye y defiende un proyecto propio con pruebas y persistencia.

- [Unidad 29. Taller](https://github.com/lelyliliana/Curso-Java/blob/main/unidad29-taller/README.md)
- [Unidad 30. Proyecto final](https://github.com/lelyliliana/Curso-Java/blob/main/unidad30-proyecto-final/README.md)

## Ejercicios de aplicación

1. Procesa una colección con Streams y compara con un ciclo. Define cómo tratar elementos ausentes.
2. Revisa un contador compartido. Explica por qué un resultado esperado en una ejecución no demuestra ausencia de carreras.
3. Diseña una prueba de fallo al guardar y una de intercambio TCP local. Señala sus fronteras.

[Contrasta después con las soluciones](SOLUCIONES.md).

## Proyecto y comprobación

Usa el [inventario de referencia](https://github.com/lelyliliana/Curso-Java/blob/main/docs/PROYECTO_INVENTARIO.md) para seguir reglas, archivo, servicio y consola. En fundamentos puedes estudiar primero objetos y archivos; en avanzado integra también pruebas y diseño. No necesitas fingir que dominaste todos los temas para revisar una parte concreta del proyecto.

Define un problema propio, tres criterios verificables y un caso de rechazo. Entrega instalación, ejecución, pruebas y límites con datos ficticios. Consulta el [proyecto final público](https://github.com/lelyliliana/Curso-Java/blob/main/unidad30-proyecto-final/README.md) para construir y evaluar tu solución.

Puedes explicar el límite de tus pruebas, el orden no garantizado de tareas y las decisiones de un proyecto con archivos y consola.

[Verificación del curso público](https://github.com/lelyliliana/Curso-Java/blob/main/docs/VERIFICACION.md). [Resultado de la comprobación de estas rutas](../java/REVISION_RUTAS.md).

**Autora:** Leli Liliana Díaz Izquierdo.
