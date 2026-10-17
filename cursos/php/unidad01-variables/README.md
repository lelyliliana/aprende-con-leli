# Unidad 01. Variables, tipos y operaciones

[Anterior](../unidad00-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-decisiones/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Representar texto, cantidades y dinero sin confundir su significado.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una variable empieza por `$`, tiene un nombre sensible a mayúsculas y guarda un valor. La asignación `=` evalúa la derecha y conserva el resultado. Los tipos iniciales son int (entero), float (aproximación decimal), string (texto), bool (verdadero o falso) y null (ausencia). `var_dump` ayuda a inspeccionarlos. Un código como "007" debe mantenerse como texto para conservar los ceros.

PHP permite cambiar el tipo de una variable, pero conviene mantener un significado estable. En los ejemplos usamos `declare(strict_types=1)` para que los parámetros tipados de funciones no acepten ciertas conversiones implícitas; no valida por sí solo formularios ni cambia todas las reglas del lenguaje. La concatenación se escribe con punto: `"Hola " . $nombre`. Las comillas dobles admiten interpolación.

`+`, `-`, `*`, `/` y `%` operan sobre números. Usa paréntesis para comunicar el orden. `/` puede producir un decimal; `intdiv(7, 2)` entrega 3. Para precios del curso guardamos centavos enteros y cantidades pequeñas. Un float no representa exactamente todos los decimales. Una constante se declara con `const` y no se reasigna. Un cálculo guardado no se actualiza al cambiar su entrada: debes volver a ejecutarlo.

## Ejemplo 1. Conservar un resultado

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$cantidad = 3;
$precioCentavos = 2500;
$total = $cantidad * $precioCentavos;
$cantidad = 4;
echo "$total centavos; cantidad actual: $cantidad\n";
```

```sh
php unidad01-variables/ejemplos/01.php
```

Salida esperada:

```text
7500 centavos; cantidad actual: 4
```

El total se calculó con tres unidades. Cambiar cantidad después no recalcula total.

## Ejemplo 2. Texto y división

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$codigo = "007";
echo "Código: " . $codigo . "\n";
echo (7 / 2) . " / " . intdiv(7, 2) . "\n";
```

```sh
php unidad01-variables/ejemplos/02.php
```

Salida esperada:

```text
Código: 007
3.5 / 3
```

Las comillas conservan el identificador. La división normal y la entera tienen contratos diferentes.

## Comprueba tu comprensión

1. Calcula el costo de dos cuadernos de 4500 centavos.
2. Cambia la cantidad a cero y predice el total.
3. Reto: calcula el cambio de un pago de 10000 centavos.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad00-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-decisiones/README.md)
