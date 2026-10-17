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
