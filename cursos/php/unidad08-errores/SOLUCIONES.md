# Soluciones 08. Errores, excepciones y depuración

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

php -l debe señalar el error y terminar con código distinto de cero en la copia alterada. subtotal con cantidad cero devuelve cero; con cantidad negativa lanza InvalidArgumentException. Son contratos diferentes: cero es admitido y negativo no.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function dividir(float $a, float $b): float {
    if ($b === 0.0) { throw new InvalidArgumentException("Divisor cero"); }
    return $a / $b;
}
try { echo dividir(10.0, 0.0); }
catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
```

Desde cursos/php:

```sh
php unidad08-errores/soluciones/reto.php
```

El fallo se comunica antes de dividir. Una prueba complementaria debe confirmar que dividir(10.0, 2.0) devuelve 5.0.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

Una comilla sin cerrar sirve para el fallo de sintaxis; cupo negativo para el dominio; sumar precio y cantidad en lugar de multiplicarlos para la lógica. Los dos últimos se ejecutan y requieren distintas estrategias de detección. La excepción de formato debe capturarse con JsonException, la de estructura con InvalidArgumentException.

Para el temporal, verifica primero que tempnam devolvió una ruta. Dentro de try escribe y provoca el fallo; en finally elimina ese archivo. La comprobación exterior debe confirmar que ya no existe. Una regresión del subtotal usa un precio y cantidad cuyo producto difiera de la suma, como 2500 y 3; esperar 7500 detecta el operador equivocado de manera inequívoca.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
