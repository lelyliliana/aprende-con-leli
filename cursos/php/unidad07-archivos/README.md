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

## Persistir no consiste solamente en guardar texto

Una variable desaparece al terminar el proceso. Un archivo puede sobrevivirlo, pero necesitas definir dónde se guarda, qué formato utiliza y qué sucede si no puede leerse. Persistencia significa poder reconstruir información útil más adelante. Si escribes datos sin documentar sus claves, unidades o codificación, puedes recuperar los bytes y aun así no saber interpretarlos correctamente.

Distingue una ruta elegida por la aplicación de un nombre recibido de una persona. Para los datos del curso usamos rutas fijas o temporales creados de forma controlada. Concatenar una entrada como ../../otro-archivo a una carpeta no garantiza permanecer dentro de ella. La solución inicial es no permitir que la entrada elija rutas; utiliza identificadores y resuelve internamente los archivos autorizados cuando sea necesario.

### Leer puede fallar y vacío puede ser válido

file_get_contents devuelve false cuando falla y una cadena cuando funciona, incluso una cadena vacía. Una comprobación como `if (!$contenido)` mezcla ambos casos. Compara con === false antes de decidir si el formato vacío está permitido. De manera similar, escribir un archivo de cero bytes puede devolver cero, que no representa necesariamente un fallo. El contrato del formato decidirá si ese archivo vacío es útil.

Los permisos y las carpetas pertenecen al entorno. Si no puedes abrir la ruta, imprimir otro JSON no repara la causa. Comprueba el directorio padre, la cuenta que ejecuta PHP y si intentas escribir en una carpeta pública que no debería guardar datos. No ocultes advertencias con @ como primera reacción: perderías la información que ayuda a distinguir un problema de ruta de uno de contenido.

### Serializar y validar la estructura son pasos distintos

JSON no conserva cualquier detalle del lenguaje PHP. Es un formato de intercambio con sus propias reglas. Una lista con claves consecutivas se codifica como arreglo JSON; una estructura con claves no consecutivas puede codificarse como objeto. Si tu API promete una lista, utiliza array_values cuando corresponda después de filtrar o borrar posiciones. La forma de salida es parte del contrato, no solo el contenido de los títulos.

Después de json_decode, verifica que exista la estructura esperada. Un documento válido puede contener null, un número o una lista donde esperabas un registro. JSON_THROW_ON_ERROR permite separar problemas de sintaxis de problemas de esquema. No anuncies «datos cargados» antes de comprobar ambos. Si importas diez registros y uno falla, decide si rechazas todo o entregas un informe de filas aceptadas y rechazadas.

### CSV y recursos que requieren cierre

fopen devuelve un recurso de archivo o false; fgetcsv lee una fila o false al terminar o fallar según el contexto. Un recurso conserva posición de lectura. Después de escribir en un flujo de memoria, rewind vuelve al comienzo para poder leer lo que acabas de guardar. Sin ese movimiento, puedes estar al final del flujo y creer que desaparecieron los datos.

Un CSV con encabezado necesita comprobar nombres y cantidad de columnas antes de convertir filas. Usa separador y escape explícitos para mantener el comportamiento definido. Un campo entre comillas puede contener una coma y un salto de línea; separar el archivo por líneas y luego por comas no reproduce esas reglas. La biblioteca existe para interpretar el formato y permitirte concentrarte en las reglas del registro.

### Recuperación, concurrencia y archivos temporales

Un archivo compartido puede sufrir actualizaciones perdidas: dos peticiones leen la misma versión y la última escritura borra el cambio de la primera. Agregar LOCK_EX solo al momento de escribir no convierte automáticamente toda la secuencia leer-modificar-escribir en una transacción. Para este curso, utiliza archivos en experimentos individuales y SQLite para el CRUD web.

El tercer ejemplo valida una importación en memoria antes de considerarla utilizable. Conservar temporalmente el origen inválido puede ayudar a investigar, pero no debes publicarlo junto al sitio ni guardar datos personales innecesarios. Documenta qué información puedes regenerar y qué debe respaldarse. Una prueba que use temporales debe limpiarlos incluso cuando la operación no se completa, mediante finally.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | json_encode convierte el registro en texto JSON. |
| 2 | json_decode con true vuelve a producir un arreglo. |
| 3 | La clave titulo recupera PHP sin analizar el JSON a mano. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | fputcsv escribe una fila con un título que contiene coma. |
| 2 | rewind sitúa el recurso al comienzo. |
| 3 | fgetcsv recupera dos campos; la coma interior sigue dentro del título. |

## Ejemplo 3. Validar la forma de un documento JSON

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function titulosDesdeJson(string $texto): array {
    $datos = json_decode($texto, false, 512, JSON_THROW_ON_ERROR);
    if (!is_array($datos) || !array_is_list($datos)) {
        throw new InvalidArgumentException("Se esperaba una lista");
    }
    $titulos = [];
    foreach ($datos as $fila) {
        if (!$fila instanceof stdClass || !is_string($fila->titulo ?? null)) {
            throw new InvalidArgumentException("Fila sin título textual");
        }
        $titulos[] = $fila->titulo;
    }
    return $titulos;
}
echo implode(", ", titulosDesdeJson('[{"titulo":"PHP"},{"titulo":"SQL"}]')) . "\n";
try { titulosDesdeJson('[{"cupo":12}]'); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
try { titulosDesdeJson("{}"); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
echo "Vacía: " . count(titulosDesdeJson("[]")) . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad07-archivos/ejemplos/03.php
```

Resultado que debes obtener:

```text
PHP, SQL
Fila sin título textual
Se esperaba una lista
Vacía: 0
```

### Lectura guiada y experimentos

La función separa decodificación, forma exterior y revisión de cada fila. Aquí json_decode usa false para conservar los objetos JSON como stdClass: así el objeto vacío {} no se confunde con la lista vacía []. Las filas se consultan mediante ->titulo. array_is_list comprueba claves consecutivas desde cero; una lista vacía también cumple ese contrato y devuelve títulos vacíos. No se imprime dentro de la función: el código que la llama decide cómo presentar un resultado o un error.

Las excepciones se estudiarán con detalle en la siguiente unidad; aquí indican que el documento no puede convertirse en la lista prometida. Cambia el segundo JSON por {"titulo":"PHP"}: debe fallar la forma exterior. Cambia el primero por []: debe devolver una lista vacía sin inventar un título. La validación aún no exige longitud de título; agrega esa regla solo si la necesitas en este contrato de importación.

## Comprueba tu comprensión

1. Agrega una propiedad aula al objeto JSON.
2. Incluye una coma y comillas en un título CSV.
3. Reto: escribe y recupera un taller desde un archivo temporal; comprueba los retornos y elimina el archivo.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad06-texto/README.md) · [Índice](../README.md) · [Siguiente](../unidad08-errores/README.md)
