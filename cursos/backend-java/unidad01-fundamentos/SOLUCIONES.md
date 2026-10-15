# Soluciones desarrolladas de la Unidad 01

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Dos nombres y una fuente de tiempo

Con nombre Leli se forma «Hola, Leli»; con Ana, «Hola, Ana». La fecha usa Clock y no procede del cliente. Si ambas peticiones ocurren en el mismo día UTC se espera la misma fecha. Si cruzan su medianoche, podrían diferir correctamente.

## 2. Prueba reproducible

SaludoServiceTest entrega un Clock fijo y propiedades conocidas al constructor. La expectativa de fecha se deriva de ese instante y su zona. No depende de cuándo se ejecutó Maven ni de abrir un servidor. ContenedorTest cubre otra pregunta: ensamblaje de las dependencias administradas.

## 3. Clasificación de fallos

| Acción | Resultado de referencia | Qué demuestra |
|---|---|---|
| Nombre vacío o demasiado largo | 400 | Entrada rechazada |
| POST al saludo, sin solicitar CSRF | 405 | Método no permitido en fundamentos |
| Consultar con Java detenido | Error de conexión | No hubo respuesta HTTP |
| Ruta inexistente con Java activo | 404 | Servidor accesible, recurso no encontrado |

El cliente público obtiene CSRF por defecto para escrituras. En fundamentos se usa `--sin-csrf` para que ese intento auxiliar no oculte el 405 de la ruta elegida.

## Resolución del reto

Desde Curso-Spring-Boot, después de verify:

```text
java -jar laboratorios/fundamentos/target/fundamentos.jar "--saludo.prefijo=Buen día"
```

Consulta el saludo: se espera «Buen día, Leli». El artefacto es el mismo; cambia una propiedad de ejecución. Si el proceso rechaza propiedades inválidas al iniciar, primero corrige la configuración: no existe una petición exitosa que pueda demostrar sobre ese proceso detenido.
