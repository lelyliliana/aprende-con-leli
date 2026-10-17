# Soluciones 04. Arreglos, registros y recorridos

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Agregar el taller con cupo 5 aumenta el total de 20 a 25. Recorrer una lista vacía no produce líneas y conserva el acumulador inicial. Esto es un resultado válido, no una excepción.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 0], ["titulo" => "Web", "cupo" => 8]];
$abiertos = [];
foreach ($talleres as $taller) {
    if ($taller["cupo"] > 0) { $abiertos[] = $taller["titulo"]; }
}
echo implode(", ", $abiertos) . "\n";
```

Desde cursos/php:

```sh
php unidad04-arreglos/soluciones/reto.php
```

La lista resultante contiene Web. La lista vacía no entra al cuerpo de foreach: el total inicial sigue siendo cero.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

Con talleres [id 1, PHP, 12], [id 2, HTML, 0] y [id 3, SQL, 8], la lista de títulos disponibles contiene PHP y SQL. El total de talleres es 3, los talleres con plazas son 2 y las plazas suman 20. Un recorrido puede mantener tres acumuladores con nombres distintos, pero cada actualización debe corresponder a su significado.

La transformación agrega títulos al arreglo nuevo solo cuando cupo > 0; no llama a unset sobre el original. El ID identifica una entidad y la posición solo su lugar en un orden actual. Tras ordenar o filtrar, un botón que conserva id 3 sigue refiriéndose a SQL; uno que use la tercera posición podría apuntar a otro registro o no existir.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
