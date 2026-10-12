# Unidad 05. Identidad, permisos y CSRF

[Volver al índice](../README.md)

## Objetivos

- Separar identidad, permiso y validez de la entrada.
- Ejecutar escrituras con cookie/token CSRF.
- Justificar límites de las cuentas educativas.

## Explicación y práctica guiada

La API integrada utiliza cuentas editor y lector con claves externas al repositorio. Sigue [preparación de credenciales](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/ENTORNO.md) en tu terminal; no pongas claves en Git ni en un comando que las imprima.

Lee la sección de seguridad del [contrato](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/CONTRATO_API.md). El cliente público obtiene /api/csrf, conserva cookie y utiliza el header indicado. Las escrituras necesitan además identidad con PRODUCT_WRITE. Las consultas del catálogo son públicas; no lo son todas las rutas de la aplicación.

Un POST sin CSRF puede recibir 403 antes de comprobar identidad. Con token válido y sin autenticar se espera 401; con lector autenticado y sin permiso de escritura se espera 403. Solo después de pasar estos controles un caso inválido puede probar el DTO con 400.

Usa el cliente público scripts/peticion.py, que solicita contraseña y gestiona token/cookie. No añadas --sin-csrf al integrado para imitar la etapa REST. Ese argumento corresponde a los laboratorios que no tienen Security.

Consulta [Spring Security](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad22-seguridad/README.md) cuando necesites comprender el filtro y las autoridades. Basic y cuentas en memoria son una elección educativa; fuera de HTTP local la identidad necesita transporte protegido, y una solución real debe definir usuarios/permisos adecuados al problema.

La API de pedidos requiere escritura incluso en lectura. No supongas que todas las rutas GET son públicas porque el catálogo lo sea. Define la política de cada recurso antes de añadir otra ruta.

## Ejercicios

1. Predice estados para POST con editor, lector, sin identidad y sin CSRF. Distingue qué dato falta en cada caso.
2. Envía una entrada inválida con un cliente autorizado y explica por qué esa evidencia sí prueba validación.
3. Compara acceso al catálogo y acceso a métricas/pedidos.

## Reto

Diseña la política de acceso de un recurso nuevo: actor, operación y autoridad, con un caso permitido y uno denegado.

## Errores frecuentes

Desactivar CSRF para obtener un test verde; considerar 401 y 403 equivalentes; confundir cuentas educativas con identidad de producción.

## Comprobación para avanzar

Puedes explicar el orden de controles y demostrar un permiso permitido y otro denegado sin publicar claves.

## Continuar

- [Unidad anterior](../unidad04-integracion/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad06-pruebas/README.md)
