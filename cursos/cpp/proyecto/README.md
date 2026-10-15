# Proyecto: inventario de materiales ficticios

[Curso](../README.md) · [Construirlo por etapas](CONSTRUCCION.md) · [Unidad21](../unidad21-proyecto/README.md)

Construye una aplicación de consola que lee, valida y resume un lote de materiales. La ruta guiada desarrolla modelo, lectura, cálculo, orden, escritura y argumentos antes de pedir la entrega completa.

## Productos

- Fuentes organizadas en encabezado, biblioteca y programa principal.
- Entrada identificada con su [diccionario](../datos/README.md).
- Reporte de seis productos ordenados, con subtotales y total 55000 centavos.
- Pruebas de contratos y CLI con casos admitidos y rechazados.
- Explicación de decisiones, unidades y límites, aplicando los cinco criterios de la guía.

## Reconstruir la versión terminada

Después de configurar desde cursos/cpp, construye inventario. Ejecuta la aplicación con dos rutas siguiendo la tabla de la [construcción](CONSTRUCCION.md). Elige una salida nueva y conserva la fuente. Revisa el producto frente a la [muestra de reporte](muestra/reporte.csv).

Una entrada inválida debe rechazarse antes de generar resultados. Una salida existente se rechaza. No se ofrecen transacciones de archivos, recuperación automática ante cortes ni acceso concurrente. El formato delimitado es restringido y la información es ficticia.

## Archivos principales

[Interfaz](include/inventario.hpp) · [Biblioteca](src/inventario.cpp) · [Aplicación](src/main.cpp) · [Contratos](tests/contratos.cpp)
