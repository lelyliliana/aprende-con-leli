# Soluciones 20. Configuración, publicación y mantenimiento

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

GitHub Pages entrega archivos estáticos y no dispone de intérprete PHP para tus peticiones. src, var, bin y tests quedan fuera de la raíz pública. Solo public contiene los archivos que debe servir el sitio de la aplicación.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function exigirRuta(string $ruta): string {
    if (trim($ruta) === "") { throw new InvalidArgumentException("Ruta vacía"); }
    return $ruta;
}
try { exigirRuta(" "); } catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
```

Desde cursos/php:

```sh
php unidad20-despliegue/soluciones/reto.php
```

La salida es Ruta vacía. En el despliegue además debes comprobar que la ruta sea absoluta, esté fuera de public y tenga permisos adecuados.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
