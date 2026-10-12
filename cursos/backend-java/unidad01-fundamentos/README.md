# Unidad 01. Primera API y responsabilidades

[Volver al índice](../README.md)

## Objetivos

- Seguir una petición desde Controller hasta Service y respuesta.
- Reconocer configuración e inyección de dependencias.
- Diferenciar error de compilación, arranque, ruta y entrada.

## Explicación y práctica guiada

Usa el [proyecto de fundamentos](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/laboratorios/fundamentos/README.md). Ejecuta verify y luego spring-boot:run con los comandos del recorrido. Abre /api/saludos?nombre=Leli y observa mensaje y fecha UTC.

Antes de ejecutar, predice qué partes cambiarán si modificas nombre. El Controller recibe el parámetro y delega; el Service construye la respuesta usando configuración y un Clock. La fecha del servidor depende de su reloj; una prueba puede inyectar uno fijo para reproducir el resultado.

Consulta [contenedor e IoC](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad01-spring-ioc/README.md) e [inyección](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad03-dependencias/README.md) cuando necesites entender quién crea y conecta las dependencias. No todos los objetos son beans: un DTO de respuesta es un dato, no un servicio que deba administrar el contenedor.

Cambia la configuración de prefijo en una copia de práctica y explica por qué no necesitas modificar el Controller para cada valor. Para repasar propiedades y perfiles, usa [configuración](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad02-configuracion/README.md).

Envía un nombre vacío y observa 400. Prueba POST sobre la ruta de saludo y observa 405. Una ruta inexistente puede devolver 404; un servidor detenido no puede darte esa respuesta. Si el proceso no inicia, lee la causa del arranque antes de probar otra URL.

## Ejercicios

1. Consulta dos nombres y compara campos de respuesta.
2. Compara la fecha de una prueba con el reloj del servidor; explica cómo hace reproducible la prueba.
3. Clasifica nombre inválido, método no permitido y conexión rechazada.

## Reto

En una copia de práctica, cambia el prefijo del saludo mediante configuración externa y demuestra que el JAR respeta el cambio.

## Errores frecuentes

Poner toda la lógica en el Controller; suponer que un DTO es un bean; interpretar conexión fallida como HTTP 404.

## Comprobación para avanzar

Puedes describir cada responsabilidad, ejecutar el proyecto y justificar cómo se prueba una dependencia temporal.

## Continuar

- [Unidad anterior](../unidad00-ruta/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad02-rest/README.md)
