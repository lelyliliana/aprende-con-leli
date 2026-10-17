# Soluciones 11. Sesiones, cookies y protección CSRF

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

La cookie con el ID está en el navegador y viaja con la petición; los datos de sesión se conservan en el servidor. Un token correcto pasa, uno distinto o ausente falla. La protección no depende de que el botón esté visible: se comprueba en el servidor.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$token = bin2hex(random_bytes(32));
$copia = $token;
echo strlen($token) . " caracteres\n";
echo hash_equals($token, $copia) ? "Coincide\n" : "No coincide\n";
```

Desde cursos/php:

```sh
php unidad11-sesiones/soluciones/reto.php
```

32 bytes se codifican como 64 caracteres hexadecimales. Cada ejecución genera otro valor; la longitud y la coincidencia sí son resultados deterministas.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
