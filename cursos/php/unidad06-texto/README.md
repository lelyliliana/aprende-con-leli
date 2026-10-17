# Unidad 06. Texto, fechas y validación

[Anterior](../unidad05-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Normalizar entradas sin confundir validación, conversión y escape.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

`trim` retira espacios de los extremos; no elimina los interiores. `strlen` cuenta bytes y `mb_strlen` cuenta caracteres según una codificación: para texto UTF-8 no siempre coinciden. El curso requiere mbstring para manejar títulos. `str_contains` busca una subcadena y distingue mayúsculas. Nunca uses una transformación como sustituto de definir qué datos aceptas.

Una entrada HTTP puede ser una cadena, un arreglo o estar ausente. Primero comprueba `is_string`. Valida un entero con `filter_var(..., FILTER_VALIDATE_INT)` y compara con `=== false`: cero es un entero válido. Convertir directamente `"abc"` con `(int)` puede ocultar el error. La validación decide si el dato sirve; el escape HTML protege el contexto donde lo muestras. Son operaciones distintas.

`DateTimeImmutable` permite operar con fechas sin cambiar el objeto original. Indica la zona horaria para que el resultado no dependa del equipo. Para una fecha con formato estricto comprueba también errores y que el formato de salida coincida, porque algunas entradas se normalizan. Los identificadores y claves deben validarse por su contrato, no por su apariencia numérica.

## Ejemplo 1. Normalizar un título

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$titulo = trim("  Taller PHP  ");
echo "$titulo\n";
echo mb_strlen("Programación", "UTF-8") . " caracteres\n";
```

```sh
php unidad06-texto/ejemplos/01.php
```

Salida esperada:

```text
Taller PHP
12 caracteres
```

trim conserva los espacios interiores. mb_strlen cuenta la ó como un carácter.

## Ejemplo 2. Cero y fecha explícita

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$cantidad = filter_var("0", FILTER_VALIDATE_INT);
echo ($cantidad === false ? "Inválido" : "Entero: $cantidad") . "\n";
$fecha = new DateTimeImmutable("2026-10-17", new DateTimeZone("America/Bogota"));
echo $fecha->modify("+7 days")->format("Y-m-d") . "\n";
```

```sh
php unidad06-texto/ejemplos/02.php
```

Salida esperada:

```text
Entero: 0
2026-10-24
```

La comparación estricta no confunde cero con false. modify crea otra fecha.

## Comprueba tu comprensión

1. Prueba una cadena vacía y otra con espacios.
2. Contrasta filter_var con "0", "5" y "abc".
3. Reto: acepta una cantidad entre 0 y 20 y explica por qué no basta convertir a int.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad05-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)
