# Rúbrica del proyecto

[Construcción](CONSTRUCCION.md) · [Curso](../README.md)

Evalúa cada criterio con 0 si falta, la mitad si funciona parcialmente y el máximo si tienes evidencia reproducible y puedes explicarla. No uses solo capturas para verificar reglas del servidor.

| Criterio | Puntos | Evidencia necesaria |
|---|---:|---|
| Modelo y reglas | 15 | Casos normales, límites y tipos inválidos; título y cupo normalizados |
| Persistencia y CRUD | 20 | Crear, recuperar, editar y eliminar por ID; datos tras reiniciar; consultas preparadas |
| HTTP y experiencia | 15 | Formularios con etiquetas, errores por campo, datos conservados, redirección y mensajes |
| Acceso y protección | 20 | Rechazos sin sesión y con token inválido; hash de contraseña; ID regenerado; HTML escapado |
| Búsqueda, paginación y API | 10 | Doce filas sin duplicados entre páginas, filtro literal y contrato JSON |
| Pruebas y reproducción | 10 | Comandos de verificación y ejecución desde una copia nueva; base temporal de pruebas |
| Explicación y límites | 10 | Flujo completo, una decisión de diseño, un error investigado y límites del uso local |
| Total | 100 | |

Una referencia de dominio es alcanzar 80 puntos y no dejar pendiente el criterio de acceso y protección. Una nota no sustituye revisar un fallo que permita operaciones sin permiso o pérdida de datos.

## Defensa de cinco minutos

1. Explica qué necesidad resolviste y muestra un alta válida.
2. Demuestra una entrada inválida y un token incorrecto sin modificar la base.
3. Sigue una petición desde el formulario hasta el repositorio y la respuesta.
4. Explica por qué un hash, un token CSRF y el escape HTML resuelven problemas distintos.
5. Muestra las pruebas, una limitación y el diseño de tu siguiente ampliación.

Entrega una bitácora con versiones, comandos, resultados, errores y correcciones. No incluyas tu contraseña ni el archivo SQLite personal.
