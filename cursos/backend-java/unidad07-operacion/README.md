# Unidad 07. Observabilidad y rendimiento

[Volver al índice](../README.md)

## Objetivos

- Distinguir salud, métricas, logs y correlación.
- Leer síntomas sin confundirlos con causa.
- Diseñar una medición de rendimiento reproducible.

## Explicación y práctica guiada

La API integrada expone health, info y metrics. El contrato permite consultar health públicamente y protege métricas con OPS_READ. Que exista un endpoint no significa que deba divulgar todos sus detalles operativos.

Consulta /actuator/health y luego observa el cliente autorizado de métricas. Health resume un estado definido; no garantiza por sí solo que un usuario pueda completar todo un flujo. Readiness incorpora dependencias configuradas, por lo que no equivale a una prueba de funcionalidad completa.

El filtro de request ID ayuda a relacionar una respuesta con registros locales. No identifica al usuario ni crea automáticamente una traza distribuida. Conserva datos útiles para diagnóstico sin registrar claves o cuerpos sensibles.

Si necesitas profundizar, consulta [Actuator](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad23-actuator/README.md), [métricas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad24-metricas/README.md) y [logging](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad25-logging/README.md).

Para rendimiento, define demanda, duración, percentil de latencia, errores y entorno antes de elegir herramientas. Sigue [rendimiento](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad26-rendimiento/README.md) para plantear carga/estrés. La prueba funcional del verificador no es un benchmark ni demuestra una capacidad de usuarios.

Una latencia elevada puede venir de base, proveedor, CPU, bloqueos o cola. Mide y compara antes de “optimizar”. Un único promedio puede ocultar solicitudes lentas; documenta distribución y tasa de fallos.

## Ejercicios

1. Compara health público y métricas protegidas; explica por qué tienen políticas distintas.
2. Relaciona una respuesta con un identificador de petición y un registro local.
3. Escribe una hipótesis de rendimiento con demanda, duración, umbral y entorno.

## Reto

Diseña un experimento local pequeño que compare una consulta del catálogo y una del proveedor. Define qué observarías y qué no puedes concluir.

## Errores frecuentes

Interpretar health UP como garantía de todo el sistema; llamar traza distribuida a un ID local; atribuir capacidad a un test funcional; medir solo promedio.

## Comprobación para avanzar

Puedes elegir señales para diagnóstico y declarar el alcance de un experimento sin inventar resultados.

## Continuar

- [Unidad anterior](../unidad06-pruebas/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad08-proyecto/README.md)
