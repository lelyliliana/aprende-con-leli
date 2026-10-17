# Soluciones 04. Arreglos, registros y recorridos

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Agregar el taller con cupo 5 aumenta el total de 20 a 25. Recorrer una lista vacía no produce líneas y conserva el acumulador inicial. Esto es un resultado válido, no una excepción.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 0], ["titulo" => "Web", "cupo" => 8]];
$abiertos = [];
foreach ($talleres as $taller) {
    if ($taller["cupo"] > 0) { $abiertos[] = $taller["titulo"]; }
}
echo implode(", ", $abiertos) . "\n";
```

Desde cursos/php:

```sh
php unidad04-arreglos/soluciones/reto.php
```

La lista resultante contiene Web. La lista vacía no entra al cuerpo de foreach: el total inicial sigue siendo cero.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
