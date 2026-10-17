# Soluciones 10. Formularios y validación en el servidor

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Los títulos de 2 y 101 caracteres se rechazan; los de 3 y 100 se aceptan si el cupo es válido. Para el cupo se aceptan 1 y 100; ausente, 0, 101 y un arreglo se rechazan. Usa las funciones compartidas del proyecto para comprobar todos los casos.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$post = ["correo" => "ana@example.test"];
$correo = $post["correo"] ?? null;
$valido = is_string($correo) && filter_var($correo, FILTER_VALIDATE_EMAIL) !== false;
echo $valido ? "Correo con formato válido\n" : "Correo inválido\n";
```

Desde cursos/php:

```sh
php unidad10-formularios/soluciones/reto.php
```

El formato es válido; eso no comprueba que exista el buzón. La condición corta el segundo paso cuando no se recibe una cadena.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

El envío válido produce el resumen sin persistencia. El inválido devuelve 422 y conserva los textos utilizables. id identifica el control en el documento, pero name es la clave que aparece en $_POST: sin name no puedes depender de recibirla.

Los arreglos se detectan con is_string antes de trim y filter_var. Un título válido y cupo "0" deben mantener el título, mostrar el error del cupo y no indicar que se completó una operación. Conservar la entrada reduce trabajo repetido y permite corregir un único campo; no elimina la obligación de escapar lo que vuelva a mostrarse.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
