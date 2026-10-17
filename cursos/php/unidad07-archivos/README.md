# Unidad 07. Archivos, CSV y JSON

[Anterior](../unidad06-texto/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-errores/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Leer y escribir datos con rutas y formatos controlados.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un archivo conserva información entre ejecuciones. `__DIR__` representa la carpeta del archivo PHP y evita depender de dónde abriste la terminal. `file_get_contents` devuelve texto o false; `file_put_contents` devuelve bytes escritos o false. Comprueba los retornos con comparación estricta. No formes rutas con nombres recibidos de un formulario: una ruta manipulada puede salir de la carpeta prevista.

JSON representa objetos, listas, cadenas, números, booleanos y null. `json_encode` transforma datos a texto; `json_decode($texto, true, 512, JSON_THROW_ON_ERROR)` produce arreglos y lanza una excepción ante formato inválido. Decodificar correctamente no garantiza la estructura: verifica claves y tipos antes de usarlos. En la unidad siguiente gestionaremos los fallos.

CSV guarda filas y columnas. Usa `fgetcsv` y `fputcsv` con separador, delimitador y escape explícitos; no dividas por comas manualmente porque un campo puede contenerlas. Los ejemplos usan memoria o archivos temporales y los eliminan al terminar. Para varios usuarios, un archivo JSON compartido no ofrece las transacciones de una base de datos; el proyecto usará SQLite.

## Ejemplo 1. Ida y vuelta con JSON

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$taller = ["titulo" => "PHP", "cupo" => 12];
$json = json_encode($taller, JSON_THROW_ON_ERROR);
$recuperado = json_decode($json, true, 512, JSON_THROW_ON_ERROR);
echo $json . "\n";
echo $recuperado["titulo"] . "\n";
```

```sh
php unidad07-archivos/ejemplos/01.php
```

Salida esperada:

```text
{"titulo":"PHP","cupo":12}
PHP
```

El texto serializado conserva claves y valores. El segundo argumento true pide arreglos.

## Ejemplo 2. CSV con coma interior

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$archivo = fopen('php://memory', 'w+');
fputcsv($archivo, ['PHP, nivel inicial', '12'], ',', '"', '');
rewind($archivo);
$fila = fgetcsv($archivo, 0, ',', '"', '');
fclose($archivo);
echo $fila[0] . ' | ' . $fila[1] . "\n";
```

```sh
php unidad07-archivos/ejemplos/02.php
```

Salida esperada:

```text
PHP, nivel inicial | 12
```

El delimitador conserva la coma como parte del título, sin convertirla en otra columna.

## Comprueba tu comprensión

1. Agrega una propiedad aula al objeto JSON.
2. Incluye una coma y comillas en un título CSV.
3. Reto: escribe y recupera un taller desde un archivo temporal; comprueba los retornos y elimina el archivo.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad06-texto/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-errores/README.md)
