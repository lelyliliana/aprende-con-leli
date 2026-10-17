# Unidad 04. Arreglos, registros y recorridos

[Anterior](../unidad03-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-funciones/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Modelar listas y registros usando claves coherentes.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

En PHP un array es un mapa ordenado: relaciona claves enteras o cadenas con valores. Una lista como `["PHP", "HTML"]` utiliza claves 0 y 1. Un registro como `["titulo" => "PHP", "cupo" => 12]` utiliza nombres. `count` cuenta elementos; `$lista[] = $nuevo` agrega uno. Una lista vacía es `[]`.

`foreach ($lista as $valor)` recorre valores; `foreach ($registro as $clave => $valor)` incluye las claves. Una lista de registros permite representar talleres. Comprueba la existencia antes de acceder: `??` entrega una alternativa cuando el valor no existe o es null. `array_key_exists` distingue una clave presente con null de una ausente. No supongas que borrar una posición reenumera el arreglo: `array_values` crea una lista con índices consecutivos.

Ordenar con `sort` modifica la lista y reasigna claves numéricas; `asort` conserva las asociaciones. Decide si la posición tiene significado. En el proyecto usaremos un identificador estable para editar talleres: la posición en pantalla cambia cuando ordenas y no debe convertirse en identidad.

## Ejemplo 1. Lista de temas

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$temas = ["PHP", "HTML"];
$temas[] = "SQL";
foreach ($temas as $indice => $tema) {
    echo "$indice: $tema\n";
}
```

```sh
php unidad04-arreglos/ejemplos/01.php
```

Salida esperada:

```text
0: PHP
1: HTML
2: SQL
```

El nuevo elemento queda al final. foreach entrega la clave junto con su valor.

## Ejemplo 2. Registros de talleres

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 12], ["titulo" => "Web", "cupo" => 8]];
$total = 0;
foreach ($talleres as $taller) { $total += $taller["cupo"]; }
echo "Plazas: $total\n";
echo ($talleres[0]["aula"] ?? "Aula pendiente") . "\n";
```

```sh
php unidad04-arreglos/ejemplos/02.php
```

Salida esperada:

```text
Plazas: 20
Aula pendiente
```

Cada registro comparte claves. El operador ?? permite mostrar una ausencia prevista.

## Comprueba tu comprensión

1. Agrega un taller con cupo 5 y calcula el total.
2. Recorre una lista vacía.
3. Reto: conserva solo los títulos de talleres con cupo mayor que cero.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad03-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-funciones/README.md)
