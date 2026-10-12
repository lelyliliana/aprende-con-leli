# Unidad 00. Punto de entrada y entorno

[Volver al índice](../README.md)

## Objetivos

- Elegir qué repasar según tareas que ya puedes realizar.
- Preparar Java/Maven y distinguir los cuatro proyectos públicos.
- Registrar predicciones, resultados y decisiones.

## Explicación y práctica guiada

Esta ruta integra decisiones de backend. Java se estudia en el [curso público de Java](https://github.com/lelyliliana/Curso-Java); Spring Boot tiene su propio recorrido de conceptos. Aquí relacionarás contratos, persistencia, pruebas, seguridad y operación mediante un catálogo que crece por etapas.

No necesitas completar todos los cursos previos si ya puedes aplicar sus temas. Intenta explicar una clase, una excepción, una colección y una prueba sencilla. Si todavía no puedes, vuelve a Java antes de conectar una base o configurar permisos.

Necesitas Java 21, Maven 3.9.x, Git y un editor. Python 3.11 o superior permite usar los clientes y el verificador públicos; no reemplaza Java ni es requisito para ejecutar los tests Maven. Docker y PostgreSQL no se requieren para comenzar.

Sigue [ENTORNO](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/ENTORNO.md) para preparar herramientas en tu sistema. Comprueba tanto java -version como mvn -version: Maven puede estar utilizando otro JDK.

Los laboratorios son proyectos independientes, no carpetas que debas unir. Fundamentos introduce servidor y configuración; REST usa un mapa en memoria; JPA añade base, categorías y versión; la API integrada añade proveedor, seguridad, métricas y pedidos. Cada proyecto tiene su pom.xml.

La [guía de recorrido](../laboratorio/README.md) fija una revisión compatible y los comandos exactos. Detén una aplicación antes de iniciar otra que utilice 8080. Una API responde HTTP; no necesitas una interfaz gráfica para observar su comportamiento.

## Ejercicios

1. Identifica qué proyecto debes abrir para practicar un saludo, un CRUD sin base y un conflicto de versión.
2. Comprueba Java/Maven y registra dónde ejecutarás los comandos con -f.
3. Crea una bitácora con predicción, petición o prueba, resultado y explicación.

## Reto

Explica qué comprobaciones harías antes de declarar que una API está funcionando: compilación, arranque, respuesta y regla de negocio.

## Errores frecuentes

Unir pom.xml de etapas; iniciar dos aplicaciones en 8080; cambiar código para ocultar un problema de instalación.

## Comprobación para avanzar

Puedes elegir la etapa, localizar su proyecto e iniciar la práctica con el JDK esperado.

## Continuar

- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad01-fundamentos/README.md)
