# Laboratorio 20. Instalar otra vez y restaurar una copia

[Lección](../../unidad20-despliegue/README.md) · [Laboratorios](../README.md) · [Configuración del proyecto](../../proyecto/README.md)

## Objetivo

Demuestra que el proyecto no funciona por archivos olvidados o una configuración que solo recuerdas. Usarás una base nueva con datos ficticios y una restauración en otra ruta. No necesitas hosting, cuentas públicas ni un servicio contratado. Mantén la raíz web en proyecto/public.

## Etapa A. Declarar el entorno

Desde cursos/php registra `php -v`, `php --ini` y `php -m`. No pegues una configuración completa que contenga secretos. Comprueba pdo_sqlite y mbstring. Configura APP_DB con una ruta absoluta nueva, por ejemplo proyecto/var/entrega-practica.sqlite, mediante los comandos de [acceso](../16-acceso/README.md). Si el archivo ya existe, elige otro nombre para este intento: inicializar conserva datos, no los reinicia.

Ejecuta inicializar, crea una cuenta de práctica y abre el servidor local sobre proyecto/public. Anota en qué terminal definiste APP_DB: el proceso debe heredar esa configuración. Abre otra terminal sin la variable y explica por qué podría usar la base predeterminada en vez de la que querías probar.

## Etapa B. Producir evidencia conocida

Crea dos talleres con títulos y cupos que anotes de antemano. Edita uno y elimina el otro. Consulta la API autenticada y guarda solamente el cuerpo con los datos ficticios, sin cookies ni claves. La copia deberá conservar exactamente el taller restante con su cupo editado.

Solicita /src/bootstrap.php y /var/entrega-practica.sqlite. Deben responder 404, porque esas carpetas están fuera de la raíz pública. No basta con que el navegador no muestre enlaces a ellas. Una URL escrita manualmente también debe estar restringida por el diseño del servidor.

## Etapa C. Copiar coherentemente

Detén el servidor con Ctrl+C antes de la copia simple. En el explorador, copia entrega-practica.sqlite a un nombre nuevo como entrega-respaldo.sqlite dentro de la carpeta privada de práctica. No sobrescribas una base existente. También puedes usar el comando de copia de tu sistema, con rutas explícitas que hayas comprobado.

Configura APP_DB apuntando a esa copia y vuelve a iniciar el servidor. No hace falta crear de nuevo las tablas ni la cuenta si la copia contiene la base completa. Inicia sesión, consulta el taller conocido y comprueba el cupo. Esa lectura demuestra más que la mera existencia de un archivo con tamaño parecido.

## Etapa D. Verificar independencia

Agrega un taller solo en la copia y detén el servidor. Vuelve a configurar la ruta original y reinicia: el taller nuevo no debería aparecer allí. Así demuestras que restauraste en otra base y no seguiste leyendo la anterior por error. No utilices datos personales en ninguno de los dos archivos.

Finalmente elimina la variable de entorno de la terminal si quieres regresar al modo local predeterminado. Conserva las bases de ejercicio como evidencia privada o adminístralas tú desde el explorador; las pruebas automáticas del curso nunca las borran.

## Entrega y reflexión

Entrega versiones, rutas relativas de la estructura, comandos, fila conocida, resultado restaurado y prueba de independencia. Explica qué procedimiento cambiarías si no pudieras detener las escrituras: una copia simple ya no sería la decisión adecuada sin un mecanismo coherente del motor. Explica también por qué estos pasos no configuran HTTPS, limitación de intentos ni un servidor productivo automáticamente. La instalación local reproducible es una evidencia concreta; ofrecer un servicio público requiere un alcance adicional.
