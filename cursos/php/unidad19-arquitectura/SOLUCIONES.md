# Soluciones 19. Arquitectura sencilla y proyecto por etapas

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

La validación está en src/validacion.php; el SQL en src/TallerRepository.php; el procesamiento HTTP y la presentación en public/index.php; la configuración de conexión en src/bootstrap.php. var queda fuera de public para evitar descargar la base mediante una URL.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function tituloValido(mixed $valor): bool {
    if (!is_string($valor)) { return false; }
    $longitud = mb_strlen(trim($valor), "UTF-8");
    return $longitud >= 3 && $longitud <= 100;
}
echo tituloValido(str_repeat("a", 101)) ? "Válido\n" : "Inválido\n";
```

Desde cursos/php:

```sh
php unidad19-arquitectura/soluciones/reto.php
```

La función devuelve false para 101 caracteres. Comparte la misma función entre controlador y pruebas para que la regla no diverja.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
