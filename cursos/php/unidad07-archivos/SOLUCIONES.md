# Soluciones 07. Archivos, CSV y JSON

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Agrega aula al arreglo antes de json_encode: la propiedad aparece en el JSON y se recupera al decodificar. fputcsv rodea y escapa campos según el formato; fgetcsv recupera una coma o comilla interior como parte del mismo campo. Separar por comas manualmente perdería esa estructura.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$ruta = tempnam(sys_get_temp_dir(), "leli-");
if ($ruta === false) { throw new RuntimeException("No se pudo crear el temporal"); }
try {
    $texto = json_encode(["titulo" => "PHP"], JSON_THROW_ON_ERROR);
    if (file_put_contents($ruta, $texto) === false) { throw new RuntimeException("No se pudo escribir"); }
    $leido = file_get_contents($ruta);
    if ($leido === false) { throw new RuntimeException("No se pudo leer"); }
    echo json_decode($leido, true, 512, JSON_THROW_ON_ERROR)["titulo"] . "\n";
} finally { unlink($ruta); }
```

Desde cursos/php:

```sh
php unidad07-archivos/soluciones/reto.php
```

La salida es PHP. try/finally garantiza la limpieza incluso si ocurre un fallo; la siguiente unidad explica esta estructura.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
