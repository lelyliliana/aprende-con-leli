# Soluciones 06. Texto, fechas y validación

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Una cadena vacía y una compuesta solo por espacios quedan vacías después de trim. filter_var devuelve el entero 0 para "0", el entero 5 para "5" y false para "abc". Compara con === false para distinguirlos.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$entrada = "0";
$n = filter_var($entrada, FILTER_VALIDATE_INT);
$valida = $n !== false && $n >= 0 && $n <= 20;
echo $valida ? "Cantidad válida\n" : "Cantidad inválida\n";
```

Desde cursos/php:

```sh
php unidad06-texto/soluciones/reto.php
```

La entrada cero es válida. "abc" es inválida aunque una conversión forzada pudiera producir cero. Prueba también -1 y 21.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
