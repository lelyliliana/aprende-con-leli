# Unidad 05. Funciones, parámetros y contratos

[Anterior](../unidad04-arreglos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-texto/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Separar cálculos reutilizables de su presentación.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una función da un nombre a una operación. Los parámetros reciben datos; `return` entrega un resultado y termina la llamada. `echo` muestra información y no reemplaza el retorno. Una función que calcula plazas puede servir en una página, una API y una prueba si devuelve un número en lugar de imprimir HTML.

Declara tipos en parámetros y retorno: `function doble(int $n): int`. El contrato también incluye reglas del dominio que el tipo no expresa, por ejemplo capacidad no negativa. Una variable creada dentro de la función tiene alcance local. Pasa los datos explícitamente en vez de depender de globales. Los parámetros se pasan por valor por defecto; no necesitas referencias para devolver un cálculo.

Un parámetro opcional debe tener un valor razonable. Evita funciones que hagan varias tareas sin relación. Para comprobar una función prepara una entrada y un resultado esperado; incluye límites y entradas inválidas cuando incorporemos excepciones. Un nombre como plazasDisponibles explica más que procesar.

## Ejemplo 1. Retornar un cálculo

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function plazasDisponibles(int $capacidad, int $inscritos): int {
    return max(0, $capacidad - $inscritos);
}
echo plazasDisponibles(12, 5) . "\n";
echo plazasDisponibles(5, 8) . "\n";
```

```sh
php unidad05-funciones/ejemplos/01.php
```

Salida esperada:

```text
7
0
```

max evita presentar plazas negativas. El contrato de este ejemplo admite sobrecupo y lo representa como cero disponible.

## Ejemplo 2. Valor opcional y alcance

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

function saludar(string $nombre = "estudiante"): string {
    return "Hola, $nombre";
}
echo saludar() . "\n";
echo saludar("Leli") . "\n";
```

```sh
php unidad05-funciones/ejemplos/02.php
```

Salida esperada:

```text
Hola, estudiante
Hola, Leli
```

Cada llamada recibe su propio parámetro. La primera utiliza el valor por defecto.

## Comprueba tu comprensión

1. Prueba capacidad igual a inscritos.
2. Escribe una función que devuelva el doble de un entero.
3. Reto: calcula el subtotal de un precio en centavos y una cantidad, sin imprimir dentro de la función.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad04-arreglos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-texto/README.md)
