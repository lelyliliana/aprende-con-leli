# Gestor de talleres · Proyecto PHP

[Curso](../README.md) · [Construcción por etapas](CONSTRUCCION.md) · [Rúbrica](RUBRICA.md)

Aplicación educativa para una docente que administra talleres: título y cupo, búsqueda, paginación, edición y eliminación, con cuenta administradora local y API JSON de lectura. El código de referencia se estudia después de intentar cada etapa.

## Inicio rápido

Requiere PHP 8.4 o 8.5 con pdo_sqlite y mbstring. Desde **cursos/php**, ejecuta:

```sh
php proyecto/bin/inicializar.php
php proyecto/bin/crear_usuario.php docente
php -S 127.0.0.1:8000 -t proyecto/public
```

El segundo comando solicita una contraseña de al menos 12 caracteres y máximo 72 bytes. La terminal muestra lo escrito: utiliza una frase exclusiva de práctica; no reutilices contraseñas personales. La clave no se pasa como argumento ni queda en el historial del comando. La base guarda un hash, no el texto original.

Abre **http://127.0.0.1:8000** en el navegador e inicia sesión con la cuenta creada. Crea un taller con título PHP inicial y cupo 12. Recarga y confirma que sigue allí; edita el cupo y comprueba el nuevo valor. Detén el servidor con Ctrl+C.

Inicializar otra vez conserva la información; no incluye un reinicio destructivo. La cuenta se crea una sola vez por nombre. Si olvidas una clave, para practicar puedes crear otro nombre por CLI; el proyecto no ofrece recuperación de contraseñas.

## Carpetas y flujo

```text
proyecto/
  bin/inicializar.php       crea las tablas sin borrar datos
  bin/crear_usuario.php     crea una cuenta desde la terminal
  public/index.php          recibe HTTP, valida acceso y genera respuestas
  public/styles.css         presentación y foco de teclado
  src/validacion.php        reglas de entrada, escape y token
  src/TallerRepository.php  operaciones SQL con PDO inyectado
  src/bootstrap.php         carga de código y conexión
  schema.sql                tablas y restricciones
  tests/integracion.php     validación, persistencia y contratos
  var/                      base local; su contenido no se versiona
```

Una petición POST pasa por método → token CSRF → identidad → acción → ID si corresponde → validación → repositorio → redirección 303. Una petición GET lista o muestra un formulario. La API requiere sesión y devuelve únicamente id, titulo y cupo. Consulta [el contrato](API.md).

La raíz pública es exclusivamente public. No ejecutes el servidor desde el repositorio completo como raíz web. index.php comprueba también que la cuenta asociada a la sesión continúe existiendo.

## Comprobaciones

Desde cursos/php:

```sh
php scripts/verificar.php
php proyecto/tests/integracion.php
python3 scripts/verificar_http.py
```

En Windows, si tu comando de Python es `py`, usa `py scripts/verificar_http.py`. Las pruebas HTTP crean cuenta, base, puerto y sesiones temporales; al terminar detienen el servidor y borran los temporales. La base de estudio en proyecto/var no se toca. Cada fallo produce un código de salida distinto de cero.

Composer es opcional: desde **proyecto** puedes usar `composer install` y `composer test`. El código funciona con require_once para no exigir paquetes en el primer recorrido. El mapa PSR-4 de composer.json permite experimentar con vendor/autoload.php; use no carga archivos por sí solo.

## Configuración alternativa

Por defecto se utiliza proyecto/var/talleres.sqlite. Para probar otra base, configura APP_DB con una ruta absoluta antes de inicializar y mantenla en la terminal que abre el servidor.

Linux/macOS (ejemplo: sustituye la ruta por la tuya):

```sh
export APP_DB=/ruta/absoluta/talleres.sqlite
php proyecto/bin/inicializar.php
php proyecto/bin/crear_usuario.php docente
php -S 127.0.0.1:8000 -t proyecto/public
```

PowerShell:

```powershell
$env:APP_DB = "C:\ruta\absoluta\talleres.sqlite"
php proyecto/bin/inicializar.php
php proyecto/bin/crear_usuario.php docente
php -S 127.0.0.1:8000 -t proyecto/public
```

Crea primero la carpeta contenedora y confirma que sea escribible. El programa no carga archivos .env. APP_ENV=production oculta detalles de errores, que se registran en el servidor; APP_HTTPS=1 activa cookies Secure y requiere acceder por HTTPS. En el servidor local HTTP conserva APP_HTTPS sin definir.

## Límites que debes explicar

- Proyecto de uso local con una cuenta de administración creada por CLI; toda cuenta creada así tiene el mismo permiso. No hay registro público, roles múltiples ni recuperación de cuentas.
- No incluye limitador compartido de intentos: antes de exponer el acceso a Internet, intégralo en el servidor o la aplicación y pruébalo, junto con HTTPS y gestión de cuentas.
- La búsqueda es una subcadena literal. SQLite básico ignora mayúsculas ASCII al usar lower; no ofrece aquí comparación Unicode completa: Ó y ó pueden no coincidir.
- No incluye inscripciones de estudiantes, pagos, archivos subidos ni datos personales. Una ampliación debe diseñar sus propios contratos.
- La última edición sobrescribe la anterior; no hay detección de conflictos concurrentes. SQLite y las sesiones locales no constituyen un despliegue distribuido.
- La API es de lectura con sesión del mismo origen. No implementa tokens de acceso para integraciones externas ni CORS abierto.

Para un alojamiento real utiliza un servidor apto para producción con la raíz en public, HTTPS, permisos mínimos, respaldos restaurables y límites de acceso. El servidor integrado de PHP es solo para desarrollo.
