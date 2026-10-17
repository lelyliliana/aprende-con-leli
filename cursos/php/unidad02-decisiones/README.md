# Unidad 02. Condiciones y decisiones

[Anterior](../unidad01-variables/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-ciclos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Construir decisiones con límites explícitos y comparación estricta.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

`if` ejecuta un bloque cuando su condición es verdadera; `else` cubre el caso alternativo. `elseif` permite varias decisiones excluyentes. `===` compara valor y tipo; `==` admite conversiones que pueden sorprender. La asignación `=` no es una comparación. Las llaves delimitan el bloque y hacen visible qué instrucciones pertenecen a cada camino.

`&&` exige que ambas condiciones sean verdaderas; `||` acepta al menos una; `!` invierte el resultado. Para validar un rango compara cada extremo: `$edad >= 12 && $edad <= 17`; no encadenes comparaciones como en una fórmula matemática. Prueba siempre debajo, en el límite y encima.

`match` selecciona un resultado por comparación estricta y necesita cubrir los casos o tener `default`. Es útil para traducir estados conocidos, mientras que if expresa mejor rangos. No ocultes varias decisiones complejas en operadores ternarios anidados. Antes de programar escribe las reglas con palabras y verifica que no se contradigan.

## Ejemplo 1. Cupo disponible

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$inscritos = 10;
$capacidad = 10;
if ($inscritos < $capacidad) {
    echo "Hay cupo\n";
} else {
    echo "Taller completo\n";
}
```

```sh
php unidad02-decisiones/ejemplos/01.php
```

Salida esperada:

```text
Taller completo
```

Diez no es menor que diez. El límite pertenece al caso completo.

## Ejemplo 2. Comparar estados

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$estado = "abierto";
$mensaje = match ($estado) {
    "abierto" => "Puedes inscribirte",
    "cerrado" => "Inscripción cerrada",
    default => "Estado desconocido",
};
echo $mensaje . "\n";
echo (5 === "5" ? "Iguales" : "Tipos distintos") . "\n";
```

```sh
php unidad02-decisiones/ejemplos/02.php
```

Salida esperada:

```text
Puedes inscribirte
Tipos distintos
```

match elige el texto por estado. El entero y la cadena no son estrictamente iguales.

## Comprueba tu comprensión

1. Prueba 9, 10 y 11 inscritos para capacidad 10.
2. Explica por qué el último caso también debe rechazarse.
3. Reto: permite inscripción solo si quedan plazas y la edad es al menos 12.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad01-variables/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-ciclos/README.md)
