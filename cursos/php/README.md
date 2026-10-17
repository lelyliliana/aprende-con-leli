# PHP desde cero: de tu primer programa a una aplicación web

Curso abierto de **Aprende con Leli**, elaborado por Leli Liliana Díaz Izquierdo. Aprende a tu ritmo con 22 unidades, 44 ejemplos con salida esperada, 22 prácticas y 22 retos con solución ejecutable. No necesitas conocimientos previos de programación.

**[Comenzar por la unidad 0](unidad00-entorno/README.md)** · [Proyecto guiado](proyecto/CONSTRUCCION.md) · [Guía de errores frecuentes](docs/ERRORES.md)

## Qué podrás construir

Un gestor local de talleres con formularios, validación, búsqueda, paginación, CRUD con SQLite/PDO, cuenta administradora, sesiones, tokens CSRF y API JSON de lectura autenticada. Aprenderás también a organizar código, probarlo y explicar sus límites. Alcance: principiante a intermedio; no promete dominio profesional de todos los ecosistemas PHP.

## Preparación y ritmo

Necesitas un computador con Windows, Linux o macOS, un editor, terminal y navegador. Recomendamos PHP 8.4 o 8.5 estable con PDO, pdo_sqlite, mbstring, session y JSON. La unidad 0 explica instalación y comprobaciones. Consulta las [ramas con soporte](https://www.php.net/supported-versions.php) antes de instalar. No hace falta contratar hosting, una API ni un servicio de pago. Composer es opcional y se explica en la unidad 15.

Descarga este repositorio como ZIP y abre cursos/php. Todos los comandos parten de esa carpeta. GitHub Pages aloja las lecciones estáticas: los ejemplos PHP se ejecutan en tu equipo. Lee → predice → ejecuta → modifica → explica → resuelve → contrasta. Dedica aproximadamente de dos a cuatro horas por unidad y varias sesiones al proyecto; ajusta el ritmo a tu experiencia.

## Ruta de aprendizaje

- [00. Tu primer programa y cómo estudiar](unidad00-entorno/README.md)
- [01. Variables, tipos y operaciones](unidad01-variables/README.md)
- [02. Condiciones y decisiones](unidad02-decisiones/README.md)
- [03. Ciclos, acumuladores y trazas](unidad03-ciclos/README.md)
- [04. Arreglos, registros y recorridos](unidad04-arreglos/README.md)
- [05. Funciones, parámetros y contratos](unidad05-funciones/README.md)
- [06. Texto, fechas y validación](unidad06-texto/README.md)
- [07. Archivos, CSV y JSON](unidad07-archivos/README.md)
- [08. Errores, excepciones y depuración](unidad08-errores/README.md)
- [09. HTML, HTTP y páginas dinámicas](unidad09-web/README.md)
- [10. Formularios y validación en el servidor](unidad10-formularios/README.md)
- [11. Sesiones, cookies y protección CSRF](unidad11-sesiones/README.md)
- [12. SQL, SQLite y PDO](unidad12-pdo/README.md)
- [13. CRUD, búsqueda y paginación](unidad13-crud/README.md)
- [14. Objetos, interfaces y composición](unidad14-objetos/README.md)
- [15. Namespaces, Composer y organización](unidad15-composer/README.md)
- [16. Contraseñas, autenticación y permisos](unidad16-autenticacion/README.md)
- [17. APIs JSON y contratos HTTP](unidad17-api/README.md)
- [18. Pruebas automatizadas y casos límite](unidad18-pruebas/README.md)
- [19. Arquitectura sencilla y proyecto por etapas](unidad19-arquitectura/README.md)
- [20. Configuración, publicación y mantenimiento](unidad20-despliegue/README.md)
- [21. Proyecto integrador: gestor de talleres](unidad21-proyecto/README.md)

## Puntos de control

- Unidades 0–5: construye un presupuesto en centavos con decisiones, colecciones y funciones.
- Unidades 6–8: valida texto, conserva JSON y explica un error sin ocultarlo.
- Unidades 9–13: explica una petición, diseña un formulario y ejecuta un CRUD con parámetros SQL.
- Unidades 14–18: separa responsabilidades, verifica contraseñas y prueba reglas y acceso.
- Unidades 19–21: completa y explica el proyecto con sus evidencias y limitaciones.

Cada unidad incluye lección, dos programas, salidas comprobables, práctica y solución razonada del reto. Lleva una bitácora; si no puedes explicar un ejemplo, vuelve a ejecutarlo con datos más pequeños.

## Ejecutar y verificar

```sh
php unidad00-entorno/ejemplos/01.php
php scripts/verificar.php
php proyecto/tests/integracion.php
python3 scripts/verificar_http.py
```

El último comando requiere Python 3 solo como herramienta de comprobación HTTP; no necesitas saber Python. Abre un servidor temporal en una dirección local, usa una base y sesiones temporales y no toca tu base de estudio. El proyecto tiene instrucciones propias para inicializarlo y ejecutarlo manualmente. Las comprobaciones también se ejecutan en GitHub Actions para PHP 8.4 y 8.5.

## Referencias para ampliar

- [Manual oficial de PHP en español](https://www.php.net/manual/es/): consulta el contrato exacto de cada función.
- [Tutorial oficial](https://www.php.net/manual/es/tutorial.php): primeros pasos con páginas y formularios.
- [PDO y sentencias preparadas](https://www.php.net/manual/es/pdo.prepared-statements.php).
- [API de contraseñas](https://www.php.net/manual/es/book.password.php).
- [Servidor integrado y sus límites](https://www.php.net/manual/es/features.commandline.webserver.php).
- [Composer](https://getcomposer.org/doc/01-basic-usage.md).

No necesitas leer todo el manual para comenzar. Consulta cada referencia cuando aparezca el concepto. La bibliografía complementa las explicaciones originales del curso.
