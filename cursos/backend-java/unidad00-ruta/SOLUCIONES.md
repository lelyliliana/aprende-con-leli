# Soluciones desarrolladas de la Unidad 00

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Selección de proyecto

| Tarea | Proyecto | Razón |
|---|---|---|
| Cambiar prefijo | laboratorios/fundamentos | El saludo recibe configuración |
| CRUD sin base | laboratorios/rest-memoria | Separa HTTP de persistencia |
| Versión vieja | laboratorios/jpa-productos | Añade versión y transacción |
| Permiso de escritura | ejemplos/api-productos | Incorpora Security |

No hace falta completar la integrada para observar DTO y HTTP. Empezar allí introduce filtros y credenciales que pueden ocultar el comportamiento que quieres estudiar.

## 2. Diagnóstico del entorno

`mvn -version` debe indicar un JDK compatible con el proyecto, además de la versión de Maven. Si `java -version` muestra 21 pero Maven usa 17, el primer comando no corrige el segundo. Los comandos con `-f laboratorios/.../pom.xml` parten de Curso-Spring-Boot.

## 3. Bitácora desarrollada

Predicción: REST recién iniciado tiene total 0. Acción: GET /api/productos. Observación esperada: 200 y total 0. Explicación: el servicio inicia un mapa vacío. Después de crear A se espera total 1; al terminar Java y arrancar otra JVM se espera nuevamente 0.

## Resolución del reto y criterio de cierre

Construcción: Maven produce un JAR con pruebas correctas. Arranque: el proceso permanece escuchando. Transporte: una ruta recibe respuesta HTTP. Regla: crear y repetir un SKU producen 201 y 409, conservando una sola fila. Cada conclusión tiene una evidencia distinta. Para declarar almacenamiento duradero todavía falta reiniciar usando un modo que lo conserve.
