# Verificación de la ruta Backend

[Volver al curso](../README.md)

Comprobación del 12 de octubre de 2026 (Colombia). Los proyectos reutilizados corresponden a [Curso-Spring-Boot, revisión 28abba4](https://github.com/lelyliliana/Curso-Spring-Boot/tree/28abba405067d59f8670c144443727772ee5db17).

## Resultados

Se ejecutó el verificador público scripts/verificar.py sin las opciones PostgreSQL/Docker.

| Comprobación | Resultado |
|---|---|
| Maven verify en cuatro proyectos | Correcto |
| Pruebas Maven (fundamentos, REST, JPA e integrado) | 77 correctas |
| Comprobaciones del verificador público | 1.317 correctas |
| Arranque y peticiones reales a los cuatro JAR | Correctos |
| REST/JPA: CRUD, filtros, validación y conflictos | Correctos |
| Integrado: identidad, autoridades y CSRF | Correctos |
| Métricas protegidas y salud | Correctos |
| Pedidos: estados, precio histórico y concurrencia | Correctos |
| Enlaces de esta ruta y catálogo | Verificados |

Las 1.317 comprobaciones incluyen estructura documental, enlaces, informes de pruebas y expectativas HTTP; no son 1.317 pruebas independientes de API.

## Entorno

Linux, Java 21.0.12.1, Maven 3.9.11 y Python 3.11 o superior. El perfil dev utiliza H2. Las claves de comprobación son ficticias y se generan para los procesos de prueba; no se usan credenciales personales.

## Límites

Esta ejecución no verificó PostgreSQL, Docker, carga/estrés ni despliegue. No se comprobó ejecución local en Windows/macOS ni se realizó inspección visual en navegador real. La API integrada usa cuentas educativas en memoria; no acredita identidad ni operación de producción.

La persistencia entre reinicios con H2 en archivo se enlaza a la práctica ya comprobada de Full Stack. La ejecución estándar de este verificador usa H2 en memoria.

## Repetir

Desde raíz de Curso-Spring-Boot en la revisión indicada, con Java/Maven/Python preparados:

```text
python scripts/verificar.py
```

Lee salidas/resultado.json y los logs de cada proceso. Para variantes PostgreSQL/Docker sigue la [guía pública](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/VERIFICACION.md) y sus requisitos de bases locales de práctica.
