# Soluciones 21. Proyecto integrador: gestor de talleres

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Las etapas deben demostrar reglas en consola, persistencia, acceso web y una entrega comprobada. La rúbrica exige vincular cada afirmación con evidencia: por ejemplo una prueba que devuelva 403 al alterar el token y que compruebe que no se modificó la base. La referencia es apoyo, no sustituye tu explicación.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$casos = ["Categoría permitida" => "aceptar", "Categoría ausente" => "rechazar", "Categoría desconocida" => "rechazar"];
foreach ($casos as $entrada => $esperado) { echo "$entrada: $esperado\n"; }
```

Desde cursos/php:

```sh
php unidad21-proyecto/soluciones/reto.php
```

Una solución de diseño añade una tabla categorias con ID y nombre, una clave foránea en talleres y validación de existencia. La API debe documentar la nueva propiedad. Los tres casos se convierten en pruebas antes de completar la ampliación.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
