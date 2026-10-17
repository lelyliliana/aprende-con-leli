# Si algo no funciona

[Volver al curso](../README.md)

| Síntoma | Qué comprobar | Cómo continuar |
|---|---|---|
| php no se reconoce | PATH e intérprete instalado | Abre una terminal nueva; usa where.exe php o which php. |
| No se pudo abrir el archivo | Carpeta actual y nombre | Abre la terminal en cursos/php; copia la ruta exacta del ejemplo. |
| Parse error | Sintaxis y línea anterior | Ejecuta php -l archivo.php; revisa comillas, llaves y punto y coma. |
| could not find driver | PDO SQLite | Consulta php --ini y php -m; activa el módulo del intérprete que ejecutas. |
| mb_strlen no existe | mbstring | Activa o instala la extensión y vuelve a comprobar php -m. |
| Veo código PHP o una descarga | Servidor equivocado | Usa php -S y entra por http://127.0.0.1, sin abrir el archivo directamente. |
| headers already sent | Salida antes de cabeceras | Retira echo, espacios o BOM antes de session_start/header. |
| unable to open database file | Ruta y permisos | Inicializa la base; usa una ruta fuera de public con carpeta escribible. |
| 403 en un formulario | Token o sesión | Recarga el formulario, conserva las cookies e inténtalo de nuevo. |
| No conserva la sesión | Cookies Secure en HTTP local | En local deja APP_HTTPS sin definir; en un servidor público usa HTTPS. |
| 401 en la API | No hay sesión | Inicia sesión en la aplicación; el contrato exige autenticación. |
| Puerto ocupado | Otro proceso escucha allí | Detén tu servidor anterior o elige otro puerto y cambia la URL. |

Investiga con un caso pequeño: guarda el comando, mensaje completo y resultado que esperabas. No compartas claves, cookies, tokens ni bases con datos personales. Si cambias php.ini, reinicia el proceso de PHP que estaba abierto.
