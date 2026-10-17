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

## Solución razonada del taller de profundización

Después de borrar una clave interior, las claves dejan de ser consecutivas y JSON puede representar el array como objeto. array_values crea una lista nueva; no recupera un elemento borrado. Para el título vacío, comprueba is_string antes de trim y rechaza trim(...) === "". No conviertas null o un arreglo en un título inventado.

En CSV verifica el encabezado y que cada fila tenga dos columnas. Una coma interior entre comillas no añade una columna. En la actualización perdida, A y B leen total 1, A guarda 2 y B también guarda 2 aunque ocurrieron dos incrementos. El error está en tratar varias operaciones dependientes como si fueran una única escritura aislada. La base de datos y sus transacciones permiten diseñar una solución más adecuada.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
