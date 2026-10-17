# Soluciones 02. Condiciones y decisiones

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Con 9 inscritos hay cupo; con 10 y 11 el taller está completo para efectos de admitir otra persona. El último caso indica sobrecupo existente y también debe impedir otra inscripción. No uses igualdad como única condición de rechazo.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$edad = 12;
$inscritos = 9;
$capacidad = 10;
echo ($edad >= 12 && $inscritos < $capacidad) ? "Permitida\n" : "No permitida\n";
```

Desde cursos/php:

```sh
php unidad02-decisiones/soluciones/reto.php
```

Con 12 años y 9 inscritos se permite. Con 11 años o 10 inscritos se rechaza. Cada condición representa una regla independiente.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

&& produce verdadero solo cuando ambas reglas son verdaderas; || lo produce en tres de las cuatro combinaciones. Para la temperatura, el primer if puede ser <18, el elseif <=28 y el else el resto. El primer descarte ya garantiza que la segunda rama empieza en 18. No necesitas repetirlo, aunque puedes hacerlo si ayuda a explicar.

Una nota 4 satisface >=3, de modo que nunca alcanza el elseif. Preguntar primero >=4 corrige ese orden. Con una regla de apertura, la admisión requiere edadPermitida && hayCupo && inscripcionAbierta. Una persona de 12 años con 9 inscritos se rechaza si la apertura es false; ese caso comprueba la nueva regla sin mezclar otro motivo de rechazo.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
