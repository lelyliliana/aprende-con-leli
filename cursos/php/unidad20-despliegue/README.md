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

## Comprueba tu comprensión

1. Explica por qué subir un .php a GitHub Pages no ejecuta el programa.
2. Localiza los archivos que no deben estar en la raíz pública.
3. Reto: valida que una ruta de base configurada no esté vacía antes de abrir PDO.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad19-arquitectura/README.md) · [Índice](../README.md) · [Siguiente](../unidad21-proyecto/README.md)
