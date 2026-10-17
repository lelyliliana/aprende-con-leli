# Soluciones 01. Variables, tipos y operaciones

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Dos cuadernos cuestan 9000 centavos. Con cantidad cero el total es cero. Si guardas el total y después cambias cantidad, el total anterior permanece; debes repetir el cálculo para actualizarlo.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$cantidad = 2;
$total = $cantidad * 4500;
$cambio = 10000 - $total;
echo "Total: $total; cambio: $cambio\n";
```

Desde cursos/php:

```sh
php unidad01-variables/soluciones/reto.php
```

El total es 9000 y el cambio 1000. Con cantidad cero, el total es cero; en una compra real habría que decidir si se acepta una cesta vacía.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
