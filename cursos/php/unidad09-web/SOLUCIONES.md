# Soluciones 09. HTML, HTTP y páginas dinámicas

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

En HTML, h1 marca el encabezado principal, p un párrafo y a un enlace con href. Escapar <b>PHP</b> produce &lt;b&gt;PHP&lt;/b&gt; en el documento; el navegador muestra las etiquetas como texto y no resalta PHP por ese fragmento.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$nombre = "Ana & Luis";
echo "<p>" . htmlspecialchars($nombre, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8") . "</p>\n";
```

Desde cursos/php:

```sh
php unidad09-web/soluciones/reto.php
```

La salida HTML contiene Ana &amp; Luis. El navegador presentará el ampersand original sin interpretarlo como inicio de una entidad.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
