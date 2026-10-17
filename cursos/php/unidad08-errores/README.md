# Unidad 08. Errores, excepciones y depuración

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-web/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Distinguir errores de sintaxis, fallos esperados y errores de programación.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un error de sintaxis impide interpretar el archivo: compruébalo con `php -l archivo.php`. Un resultado incorrecto requiere inspeccionar el estado y la lógica, aunque no aparezca un mensaje. `var_dump` y una traza pequeña ayudan durante el desarrollo. Lee el tipo de error, archivo y línea; reduce el caso antes de cambiar muchas cosas.

Una excepción comunica que una operación no pudo cumplir su contrato. `throw new InvalidArgumentException` expresa una entrada no admitida; `try` delimita una operación y `catch` decide cómo responder. `finally` se ejecuta para liberar un recurso incluso cuando hay una excepción. Captura el tipo concreto que sabes resolver y no conviertas todos los fallos en un mensaje de éxito.

En desarrollo activa los errores para investigarlos. En una aplicación publicada no muestres trazas, rutas ni credenciales: registra el detalle en el servidor y responde con un mensaje general. Las advertencias de funciones tradicionales no se convierten automáticamente en excepciones. Sigue comprobando retornos false cuando el contrato lo indique. En las pruebas una condición incumplida debe producir salida distinta de cero.

## Ejemplo 1. Rechazar cantidades imposibles

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function subtotal(int $precio, int $cantidad): int {
    if ($precio < 0 || $cantidad < 0) { throw new InvalidArgumentException("No se aceptan negativos"); }
    return $precio * $cantidad;
}
try { echo subtotal(2500, -1); }
catch (InvalidArgumentException $error) { echo $error->getMessage() . "\n"; }
```

```sh
php unidad08-errores/ejemplos/01.php
```

Salida esperada:

```text
No se aceptan negativos
```

La excepción evita continuar con un subtotal que carece de sentido.

## Ejemplo 2. Capturar un formato inválido

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

try {
    json_decode("{mal}", true, 512, JSON_THROW_ON_ERROR);
} catch (JsonException $error) {
    echo "JSON inválido\n";
} finally {
    echo "Operación terminada\n";
}
```

```sh
php unidad08-errores/ejemplos/02.php
```

Salida esperada:

```text
JSON inválido
Operación terminada
```

catch resuelve el error de formato. finally se ejecuta después del manejo.

## Comprueba tu comprensión

1. Introduce un error de sintaxis en una copia y usa php -l.
2. Prueba subtotal con cero y con un negativo.
3. Reto: crea una función para dividir que rechace divisor cero.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-web/README.md)
