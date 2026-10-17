# Soluciones 12. SQL, SQLite y PDO

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

Inserta cada título con la misma sentencia preparada y consulta SELECT id, titulo FROM talleres ORDER BY id. Un título como Taller de Leli's se envía en el parámetro; no hay que concatenar ni quitar su comilla. Se recupera literalmente.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)');
$db->beginTransaction();
$db->exec("INSERT INTO talleres (titulo) VALUES ('PHP')");
$db->rollBack();
echo $db->query('SELECT COUNT(*) FROM talleres')->fetchColumn() . " filas\n";
```

Desde cursos/php:

```sh
php unidad12-pdo/soluciones/reto.php
```

El resultado es cero. La transacción se revirtió; una aplicación real debe usar try/catch y revertir si la operación falla.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
