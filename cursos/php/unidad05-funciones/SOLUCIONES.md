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

## Solución razonada del taller de profundización

Una conversión inicial puede recibir horas int entre 0 y 40, devolver minutos int y no tener efectos externos. Para dos partidas de 1250×3 y 800×2, los resultados son 3750 y 1600; la suma es 5350. La misma función se reutiliza sin necesitar una variable global diferente para cada partida.

Si incrementar devuelve n+1, llamarla con x=4 y descartar el retorno deja x en 4. Asignar x=incrementar(x) conserva 5. Para envío vacío hay dos contratos defendibles: cobrar siempre la preparación o no cobrar cuando no hay compra. Elige uno, documenta el motivo y espera un valor distinto en la prueba de cantidad cero. La ambigüedad del problema no debe esconderse detrás de una condición escrita sin explicación.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
