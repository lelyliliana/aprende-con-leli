# Unidad 20. Configuración, publicación y mantenimiento

[Anterior](../unidad19-arquitectura/README.md) · [Índice](../README.md) · [Siguiente](../unidad21-proyecto/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Preparar una entrega reproducible y reconocer lo que requiere un servidor real.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

El entorno local y el público tienen necesidades distintas. GitHub Pages sirve las lecciones estáticas y no ejecuta PHP. Para publicar la aplicación necesitas un alojamiento con PHP y el controlador de base de datos. Configura la raíz del sitio en proyecto/public para que src, var y las herramientas CLI no sean descargables. Requiere HTTPS y activa cookies Secure.

Separa configuración y código. El proyecto lee APP_DB, APP_ENV y APP_HTTPS desde el entorno del proceso. APP_DB debe apuntar a una ruta absoluta fuera de public; APP_ENV=production oculta el detalle de errores y APP_HTTPS=1 activa la cookie Secure. No agregues contraseñas ni bases personales al repositorio. El proyecto no interpreta automáticamente un archivo .env: debes configurar las variables en la terminal o panel del alojamiento.

Antes de publicar comprueba permisos mínimos de lectura y escritura, respaldo y restauración de SQLite, límites de intentos del login y registro de errores. No uses chmod 777 para resolver un fallo sin investigar. Con varias instancias o carga alta, evalúa un motor cliente-servidor y un almacén de sesiones compartido. PDO facilita la interfaz, pero SQL, migraciones y concurrencia deben revisarse al cambiar de motor.

La entrega incluye instrucciones, versiones, pruebas y limitaciones. Una copia de SQLite debe hacerse de manera coherente: detenida la aplicación o con una herramienta de respaldo que respete las transacciones. Prueba restaurar una copia en otra ruta. No anuncies disponibilidad pública solo porque el servidor local funciona.

## Una entrega se reproduce en otro entorno

Publicar significa preparar un entorno capaz de ejecutar el contrato que probaste. Copiar archivos a una URL no demuestra que exista intérprete PHP, controlador de base, permisos de escritura o una raíz pública correcta. El sitio del curso y la aplicación que estudias cumplen funciones diferentes: GitHub Pages publica lecciones y código fuente; un servidor con PHP ejecuta las peticiones de la aplicación.

Antes de elegir un alojamiento, enumera requisitos concretos: versión soportada de PHP, extensiones, capacidad de configurar document root, HTTPS, escritura en una carpeta privada, registros y respaldos. No necesitas contratar nada para completar la ruta local. El objetivo de esta unidad es reconocer qué comprobar y qué cambiar, sin convertir el proyecto de una persona en una promesa de servicio público con todas las operaciones resueltas.

### La raíz pública es una frontera verificable

Si el servidor expone la carpeta proyecto completa, una URL podría revelar datos, comandos auxiliares o configuraciones que nunca debían ser descargables. Apunta la raíz a public y verifica peticiones a rutas de src y var: deben ser inaccesibles. Un archivo .gitignore controla qué se versiona, no qué puede descargar el servidor. Una carpeta ignorada puede seguir expuesta si la raíz está mal configurada.

Para SQLite la cuenta que ejecuta PHP necesita permisos adecuados sobre el archivo y su carpeta. No resuelvas un problema otorgando escritura universal sin investigar. Las sesiones y temporales también necesitan una ubicación accesible para el proceso. Un error de permisos puede variar entre tu terminal y el servidor web porque ejecutan con cuentas distintas; registra qué proceso produce el fallo.

### Configurar sin incrustar secretos

APP_DB define la ruta, APP_ENV la política de errores y APP_HTTPS el atributo Secure de la cookie. Las variables deben configurarse en el entorno que realmente inicia PHP. Definirlas en otra terminal o en un archivo .env que el programa no lee no modifica el proceso activo. Reinicia cuando corresponda y verifica el comportamiento, sin imprimir toda la configuración con posibles secretos.

Un valor por defecto es útil para desarrollo local y puede ser peligroso si oculta una configuración ausente en producción. El tercer ejemplo muestra una configuración que exige base cuando se declara producción. No modifica automáticamente el proyecto: es un ejercicio para pensar qué políticas deberían endurecerse al cambiar de alcance. Los nombres de variables, sus formatos y valores permitidos forman parte de las instrucciones de instalación.

### Observación, respaldo y restauración

Un registro del servidor permite investigar un 500 sin mostrar la traza a la persona usuaria. Registra lo necesario para comprender el fallo y evita claves, cookies y cuerpos completos con información sensible. Un error genérico en pantalla no significa que no deba haber evidencia interna. Decide quién puede leerla y cómo se conserva según el servicio real.

Un respaldo sirve si puedes restaurarlo y verificar sus datos. Para SQLite usa un procedimiento coherente con las escrituras: detén la aplicación durante una copia simple o utiliza mecanismos adecuados del motor. Guarda la copia fuera de la carpeta pública y prueba restaurar en otra ruta sin sobrescribir el original. Ejecuta un conteo o una lectura conocida para demostrar la recuperación; ver que el archivo existe no basta.

### Cambiar de motor y ampliar el acceso son proyectos

PDO reduce diferencias de interfaz, pero una migración a MySQL necesita esquema, tipos, índices, configuración, permisos y pruebas en ese motor. Las funciones específicas como instr o ciertas restricciones pueden requerir revisión. La cadena de conexión cambia y el archivo SQLite no se convierte solo en tablas remotas. Tampoco un almacén de sesiones local se comparte automáticamente entre varias instancias.

El [laboratorio de entrega](../laboratorios/20-entrega/README.md) te guía en una instalación de copia y restauración con datos ficticios. Concluirlo no exige publicar una cuenta en Internet. Exige que puedas explicar qué permanece local, qué configuración se aplicó, cómo sabes que el respaldo funciona y qué controles faltan antes de aceptar usuarios públicos.

## Ejemplo 1. Configuración con valor por defecto

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$entorno = getenv("LELI_ENTORNO_EJEMPLO");
$entorno = $entorno === false ? "local" : $entorno;
echo in_array($entorno, ["local", "production"], true) ? "Configuración reconocida\n" : "Configuración inválida\n";
```

```sh
php unidad20-despliegue/ejemplos/01.php
```

Salida esperada:

```text
Configuración reconocida
```

getenv devuelve false si falta la variable. Una lista permitida evita aceptar valores que no entiendes.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | getenv consulta una variable específica, no imprime todo el entorno. |
| 2 | Si falta, se selecciona local. |
| 3 | La lista de valores permitidos decide si la configuración se reconoce. |

## Ejemplo 2. Un manifiesto de entrega

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$entrega = ["php" => ">=8.4", "extensiones" => ["pdo_sqlite", "mbstring"], "raiz_web" => "proyecto/public"];
echo "PHP " . $entrega["php"] . "\n";
echo "Raíz: " . $entrega["raiz_web"] . "\n";
```

```sh
php unidad20-despliegue/ejemplos/02.php
```

Salida esperada:

```text
PHP >=8.4
Raíz: proyecto/public
```

El manifiesto comunica requisitos; no instala los módulos ni comprueba la configuración del servidor.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El arreglo declara versión, extensiones y raíz como metadatos. |
| 2 | Los mensajes presentan parte de ese contrato de entrega. |
| 3 | No se instala ningún módulo ni se inicia un servidor por mostrar esos textos. |

## Ejemplo 3. Exigir configuración al declarar producción

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function configurar(array $variables): array {
    $entorno = $variables["APP_ENV"] ?? "local";
    if (!in_array($entorno, ["local", "production"], true)) { throw new InvalidArgumentException("Entorno no reconocido"); }
    $ruta = $variables["APP_DB"] ?? "";
    if (!is_string($ruta)) { throw new InvalidArgumentException("Ruta inválida"); }
    if ($entorno === "production" && trim($ruta) === "") { throw new InvalidArgumentException("Falta APP_DB en producción"); }
    return ["entorno" => $entorno, "base" => $ruta === "" ? "var/talleres.sqlite" : $ruta];
}
echo configurar([])["base"] . "\n";
try { configurar(["APP_ENV" => "production"]); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
```

Ejecuta desde cursos/php:

```sh
php unidad20-despliegue/ejemplos/03.php
```

Resultado que debes obtener:

```text
var/talleres.sqlite
Falta APP_DB en producción
```

### Lectura guiada y experimentos

La función recibe un arreglo para poder ensayar configuración sin cambiar el entorno del proceso. En local utiliza una ruta de ejemplo; en producción rechaza una base no declarada. Antes de abrir una conexión real haría falta comprobar que la ruta es apropiada y está fuera de la raíz pública. El ejemplo no abre ni crea archivos.

Prueba un entorno escrito como produccion: debe rechazarse por no pertenecer a las opciones permitidas. Después aporta production y una ruta no vacía para recorrer el camino válido. Comprueba que escribir una palabra reconocida no instala por sí mismo HTTPS, permisos ni base: una configuración selecciona comportamiento, no crea automáticamente infraestructura.

## Comprueba tu comprensión

1. Explica por qué subir un .php a GitHub Pages no ejecuta el programa.
2. Localiza los archivos que no deben estar en la raíz pública.
3. Reto: valida que una ruta de base configurada no esté vacía antes de abrir PDO.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad19-arquitectura/README.md) · [Índice](../README.md) · [Siguiente](../unidad21-proyecto/README.md)
