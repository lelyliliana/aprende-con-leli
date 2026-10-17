# Soluciones 13. CRUD, búsqueda y paginación

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Sin WHERE la actualización alcanza todas las filas de la tabla. Con tamaño de página 10, los inicios de páginas 1, 2 y 3 son 0, 10 y 20. La página no es el ID de una fila y puede quedar vacía tras borrar registros.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT)');
$db->exec("INSERT INTO talleres VALUES (1, 'PHP'), (2, 'Web')");
$stmt = $db->prepare('DELETE FROM talleres WHERE id = :id');
$stmt->execute(['id' => 1]);
echo $db->query('SELECT COUNT(*) FROM talleres')->fetchColumn() . " fila\n";
```

Desde cursos/php:

```sh
php unidad13-crud/soluciones/reto.php
```

Queda una fila, Web. Ejecutar el mismo borrado otra vez no debería anunciar que borró una fila inexistente; consulta su existencia antes de presentar el resultado.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
