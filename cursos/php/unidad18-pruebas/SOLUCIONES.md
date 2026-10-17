# Soluciones 18. Pruebas automatizadas y casos límite

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Si total suma en lugar de multiplicar, el primer esperado de 7500 deja de cumplirse y el verificador falla. Para un solo producto de 2500 centavos el resultado esperado es 2500. Una prueba útil comprueba el contrato en lugar de copiar la expresión defectuosa.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$casos = [[0, 0], [1, 2500], [3, 7500]];
foreach ($casos as [$cantidad, $esperado]) {
    $obtenido = 2500 * $cantidad;
    if ($obtenido !== $esperado) { throw new RuntimeException("Cantidad: $cantidad"); }
}
echo "3 casos correctos\n";
```

Desde cursos/php:

```sh
php unidad18-pruebas/soluciones/reto.php
```

Cada fila incluye entrada y esperado. Una ampliación significativa sería comprobar los negativos con la función que los rechaza, en vez de repetir la multiplicación.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

Los casos de título pueden ser longitud 2, 3, 100, 101 y un arreglo. Sus esperados se definen sin llamar a la función que está bajo prueba. La mutación del límite cien se detecta solo si ese extremo está cubierto; el experimento se termina restaurando el código correcto y ejecutando la suite de nuevo.

La fecha se comprueba como regla aislada, el CHECK junto con PDO y SQLite como integración, y 403 en una petición real como HTTP. Para persistencia conserva la ruta temporal entre dos conexiones distintas; una conexión nueva a sqlite::memory: crea otra base y no sirve para demostrar que el disco conservó nada. Borra únicamente el temporal creado por la prueba al finalizar.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
