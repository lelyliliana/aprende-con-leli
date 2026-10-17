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

## Solución razonada del taller de profundización

El grupo toma 1, 2 y 3 dentro del cuerpo y llega a 4 en la comprobación final. La tabla del cinco puede usar un contador desde 1 hasta 5 e imprimir 5 multiplicado por el contador. No hace falta un segundo ciclo si solo quieres una tabla.

Con límite cero no hay valores y el contador de elementos queda en cero; el mensaje debe ser «sin datos» en lugar de calcular un promedio. En el error propuesto, materiales y entregados crecen simultáneamente: su suma pasa a 16 en la primera vuelta y pierde el significado de repartir una cantidad fija. Un ciclo puede terminar correctamente y ejecutar una lógica equivocada; la invariante distingue esos fallos.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
