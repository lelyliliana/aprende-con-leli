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

## Solución razonada del taller de profundización

En la traza, libres termina en 17 aunque reservas sea 5; una nueva resta lo cambiaría a 15. Los subtotales del presupuesto son 3750 y 1600, y el total es 5350 centavos. Separarlos permite comprobar qué precio y cantidad participaron en cada cálculo.

echo de false no agrega caracteres visibles, mientras var_dump identifica bool(false). Para el descuento, 15 % de 999 son 149,85 centavos: el negocio debe decidir si redondea el descuento o el total y con qué criterio. No hay una única respuesta sin esa regla. La práctica se completa al señalar la decisión pendiente, no al inventar una precisión que el problema no definió.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
