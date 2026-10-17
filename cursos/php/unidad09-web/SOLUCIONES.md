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

## Solución razonada del taller de profundización

El laboratorio responde GET con 200 y Content-Type text/html. La consulta es parte de la URL, no el nombre de un archivo del disco. En HTML el ampersand debe aparecer como &amp; dentro del documento; en JSON puede conservarse como & dentro de una cadena correctamente codificada.

Para el nombre con <b>, la evidencia debe mostrar &lt;b&gt; en el cuerpo y las marcas visibles como texto en pantalla. La página de talleres utiliza una sola estructura ul con tres li. Escapar todo el documento haría visibles también sus etiquetas; escapar únicamente los títulos mantiene la estructura y protege los datos variables.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
