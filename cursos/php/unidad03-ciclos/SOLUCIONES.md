# Soluciones 03. Ciclos, acumuladores y trazas

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Para 1 a 5 la traza del total es 1, 3, 6, 10, 15. Con límite cero el cuerpo no se ejecuta y el total inicial queda en cero. La inicialización fuera del ciclo permite conservar el acumulado.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$total = 0;
for ($n = 1; $n <= 6; $n++) {
    if ($n % 2 === 0) { $total += $n; }
}
echo "$total\n";
```

Desde cursos/php:

```sh
php unidad03-ciclos/soluciones/reto.php
```

El módulo cero identifica 2, 4 y 6: el total es 12. Con un límite cero el cuerpo no se ejecuta y el acumulador conserva cero.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
