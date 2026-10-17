# Soluciones 15. Namespaces, Composer y organización

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

composer.json declara el prefijo Aprende\ asociado con src/ y el script test. La directiva use solo permite escribir un nombre corto; require_once incluye un archivo y el autoloader de Composer puede cargarlo al referenciar la clase. Sin cargador ni require, use no hace aparecer la clase.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$clase = 'Aprende\\Servicio\\Inscripcion';
$relativa = substr($clase, strlen('Aprende\\'));
echo 'src/' . str_replace('\\', '/', $relativa) . ".php\n";
```

Desde cursos/php:

```sh
php unidad15-composer/soluciones/reto.php
```

La ruta es src/Servicio/Inscripcion.php. Respeta mayúsculas: un error que pasa desapercibido en algunos equipos puede fallar al desplegar en Linux.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
