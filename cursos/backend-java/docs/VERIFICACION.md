# Verificación de la ruta Backend

[Curso](../README.md) · [Experimentos](EXPERIMENTOS.md) · [Laboratorio](../laboratorio/README.md)

Comprobación del 14 de octubre de 2026 (America/Bogota). Esta ruta utiliza [Spring Boot 2.2, revisión 16c4f54](https://github.com/lelyliliana/Curso-Spring-Boot/tree/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11). Las fuentes enlazadas y los experimentos están fijados a esa revisión.

## Evidencia aplicada de Backend

Se ejecutó recorridos_backend.py con --caso todos contra los JAR de esa copia. El programa crea sus procesos y datos de práctica, usa puertos loopback temporales y genera claves educativas efímeras sin imprimirlas.

| Experimento | Casos | Resultado observado |
|---|---|---|
| REST | 3 | SKU ajeno no cambia el recurso; validación, filtro/página vacía, 204 sin cuerpo y mapa vacío tras reinicio |
| Persistencia | 2 | Versión antigua rechazada y recurso completo conservado al reiniciar sobre el mismo archivo H2 |
| Proveedor | 7 | Cuerpo y SKU correctos, JSON roto, 404, 429, 503 transitorio/permanente e intentos acotados; catálogo intacto |
| Seguridad | 3 | Identidad, permiso, CSRF, validación del cuerpo y acceso diferenciado a métricas/pedidos |
| Total | 15 | 45 peticiones explícitas y 80 comprobaciones correctas |

El contador de peticiones no incluye los auxiliares de arranque/CSRF ni las llamadas internas al proveedor. Las comprobaciones adicionales validan cuerpos, headers y estado posterior; no son pruebas Maven independientes. El proveedor es un servidor HTTP local controlado. El archivo H2 es temporal y se elimina después de cerrar ambos procesos sucesivos.

## Base Java reutilizada

La revisión de Spring Boot se comprobó durante esta misma actualización de cursos: 77 pruebas Maven correctas en cuatro proyectos (8 fundamentos, 7 REST, 7 JPA y 55 integrada), cuatro JAR construidos/arrancados y sus doce recorridos guiados correctos. En Backend se reutilizaron esos mismos artefactos; no se modificaron clases, dependencias ni migraciones Java. Consulta [resultados de la revisión pública](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/VERIFICACION.md).

Los doce recorridos públicos registraron 37 peticiones explícitas y 58 comprobaciones. Ese conjunto y los cuatro experimentos de Backend tienen alcances distintos. No se agregan sus contadores como si fueran una sola clase de prueba.

## Documentación y página

Las nueve unidades incluyen desarrollo específico, práctica paso a paso y soluciones razonadas. Se revisan enlaces locales, fuentes fijadas, bloques de código, codificación, marcas internas y conservación de los contactos contextuales. La página del curso ofrece acceso a los cuatro archivos de cada unidad y a los experimentos. La revisión documental completó 625 comprobaciones correctas.

Se inspeccionó la página en Chromium 151.0.7922.34: 29 comprobaciones correctas, 36 destinos de unidades distintos, sin errores JavaScript ni recursos locales fallidos. Los anchos 320, 375, 768 y 1280 px se comprobaron en claro y oscuro, sin desbordamiento horizontal; se verificó persistencia de la preferencia de tema y se inspeccionaron capturas de móvil/escritorio.

## Entorno y límites

Linux, Amazon Corretto 21.0.12.1, Maven 3.9.16 y Python 3.11 o superior. H2 se utilizó en memoria y archivo. Las pruebas de proveedor usan transporte real local con respuestas controladas; no requieren servicios públicos ni cuentas personales.

No se ejecutaron PostgreSQL, Docker, carga/estrés ni despliegue del backend. No se comprobó ejecución local de Java en Windows/macOS. La duración observada corresponde a reinicio limpio, no a recuperación después de un corte abrupto. La API integrada utiliza cuentas educativas y no acredita identidad de producción.

La regla de precio máximo 500 propuesta en las prácticas es una ampliación para el proyecto propio; no forma parte del comportamiento implementado en el código Java de referencia. Los ejemplos de percentiles son datos didácticos inventados, no mediciones de rendimiento de esta API.

## Repetir

Sigue [experimentos](EXPERIMENTOS.md) para preparar las dos raíces, construir la etapa y ejecutar un caso cada vez. Después de preparar los tres JAR requeridos, desde Aprende con Leli:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso todos
```

Desde la raíz de Curso-Spring-Boot puedes repetir además su verificación completa:

```text
python scripts/verificar.py
```

Los logs backend-*.log de la evidencia aplicada quedan en salidas de Curso-Spring-Boot. Para PostgreSQL/Docker sigue los requisitos del verificador público y consulta los resultados de CI del commit evaluado antes de declarar esos escenarios comprobados.
