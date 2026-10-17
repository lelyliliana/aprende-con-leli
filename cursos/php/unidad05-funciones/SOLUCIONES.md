# Soluciones 05. Funciones, parámetros y contratos

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Cuando capacidad e inscritos coinciden, plazasDisponibles devuelve cero. La función doble puede escribirse como function doble(int $n): int { return $n * 2; }. El retorno se puede comprobar o imprimir fuera de la función.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function subtotal(int $precioCentavos, int $cantidad): int {
    return $precioCentavos * $cantidad;
}
echo subtotal(2500, 3) . "\n";
```

Desde cursos/php:

```sh
php unidad05-funciones/soluciones/reto.php
```

El resultado es 7500. Mostrarlo fuera permite reutilizar subtotal en otros contextos. Aún falta rechazar cantidades negativas; lo haremos al estudiar excepciones.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
