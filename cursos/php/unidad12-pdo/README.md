# Unidad 12. SQL, SQLite y PDO

[Anterior](../unidad11-sesiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-crud/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Consultar datos con sentencias preparadas y restricciones.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una base relacional organiza filas en tablas. Una clave primaria identifica una fila; NOT NULL y CHECK expresan restricciones. SQL permite INSERT (crear), SELECT (leer), UPDATE (editar) y DELETE (borrar). Antes de esta unidad ya sabes validar los datos en PHP; la base también debe proteger sus reglas. Un WHERE ausente puede modificar todas las filas.

PDO es la interfaz de PHP para distintos motores. SQLite guarda la base en un archivo; `sqlite::memory:` crea una base temporal para pruebas. Necesitas el controlador pdo_sqlite: comprueba `php -r "print_r(PDO::getAvailableDrivers());"`. En Windows activa extension=pdo_sqlite en el php.ini que aparece en `php --ini`; en Linux instala el paquete SQLite de tu versión de PHP. Si aparece «could not find driver», revisa el intérprete y sus módulos antes de modificar el SQL.

Una sentencia preparada separa estructura SQL de valores: `prepare("... WHERE titulo = :titulo")` y `execute(["titulo" => $texto])`. No concatenes entradas en SQL. Los parámetros sirven para valores, no para nombres de tablas o columnas; para ordenar por una columna usa una lista explícita de opciones permitidas. PDO::ERRMODE_EXCEPTION facilita detectar fallos. Una transacción agrupa operaciones: commit conserva todas y rollBack revierte si no se completa el conjunto.

## Ejemplo 1. Crear y consultar

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)");
$insertar = $db->prepare("INSERT INTO talleres (titulo) VALUES (:titulo)");
$insertar->execute(["titulo" => "PHP"]);
echo $db->query("SELECT titulo FROM talleres")->fetchColumn() . "\n";
```

```sh
php unidad12-pdo/ejemplos/01.php
```

Salida esperada:

```text
PHP
```

El esquema se crea primero, el parámetro se envía aparte y la consulta devuelve el título.

## Ejemplo 2. Un valor no se vuelve SQL

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (titulo TEXT NOT NULL)');
$db->exec("INSERT INTO talleres VALUES ('PHP')");
$consulta = $db->prepare('SELECT COUNT(*) FROM talleres WHERE titulo = :titulo');
$consulta->execute(['titulo' => "' OR 1=1 --"]);
echo $consulta->fetchColumn() . " coincidencias\n";
```

```sh
php unidad12-pdo/ejemplos/02.php
```

Salida esperada:

```text
0 coincidencias
```

La entrada se busca literalmente como título, no modifica la condición SQL.

## Comprueba tu comprensión

1. Inserta dos títulos y léelos con ORDER BY id.
2. Busca un título con comilla simple usando un parámetro.
3. Reto: inicia una transacción, inserta un taller y revierte; comprueba que no queda la fila.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad11-sesiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad13-crud/README.md)
