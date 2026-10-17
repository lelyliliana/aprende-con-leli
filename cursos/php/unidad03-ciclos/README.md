# Unidad 03. Ciclos, acumuladores y trazas

[Anterior](../unidad02-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-arreglos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Repetir acciones con una condición de terminación comprensible.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un ciclo evita copiar instrucciones. `for` reúne inicio, condición y actualización. El cuerpo se ejecuta mientras la condición sea verdadera; después ocurre la actualización. En `while` debes garantizar que algún estado cambie hasta terminar. Un contador cuenta elementos; un acumulador reúne valores. Inicialízalos antes del ciclo, no dentro.

Para recorrer una colección usa `foreach`: expresa la intención sin administrar posiciones manualmente. Lo estudiaremos con arreglos en la siguiente unidad. `break` sale del ciclo y `continue` pasa a la siguiente iteración. Úsalos cuando simplifiquen la explicación; una salida escondida puede dificultar el seguimiento.

Una traza es una tabla de valores después de cada vuelta. Para sumar 1, 2 y 3, el acumulador pasa por 1, 3 y 6. Prueba cero vueltas, una y varias. Si usas `<=` donde necesitabas `<`, puedes procesar un elemento de más. Evita ciclos infinitos al leer datos que no cambian.

## Ejemplo 1. Acumular sesiones

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$total = 0;
for ($sesion = 1; $sesion <= 3; $sesion++) {
    $total += $sesion;
    echo "Sesión $sesion: $total\n";
}
```

```sh
php unidad03-ciclos/ejemplos/01.php
```

Salida esperada:

```text
Sesión 1: 1
Sesión 2: 3
Sesión 3: 6
```

El acumulador conserva el total anterior y agrega el número de sesión.

## Ejemplo 2. Reducir pendientes

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$pendientes = 3;
while ($pendientes > 0) {
    echo "$pendientes pendientes\n";
    $pendientes--;
}
```

```sh
php unidad03-ciclos/ejemplos/02.php
```

Salida esperada:

```text
3 pendientes
2 pendientes
1 pendientes
```

La resta garantiza la terminación. Cero ya no satisface la condición.

## Comprueba tu comprensión

1. Suma los números del 1 al 5 y construye la traza.
2. Cambia el límite a cero y explica la salida.
3. Reto: suma solo los pares del 1 al 6.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad02-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-arreglos/README.md)
