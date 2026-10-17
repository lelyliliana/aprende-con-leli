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

## Solución razonada del taller de profundización

La categoría se describe una vez en categorias; talleres conserva categoria_id. Para Web con dos talleres y Robótica sin ninguno, LEFT JOIN con COUNT(t.id) produce 2 y 0. INNER JOIN omite la categoría vacía y COUNT(*) puede contar la fila exterior de otra manera: debes elegir según la pregunta del informe.

Con PRAGMA foreign_keys activo, un ID de categoría inexistente provoca una excepción y no crea el taller. En la transacción, toma un conteo antes, inserta una fila válida, intenta la fila inválida y ejecuta rollBack en el catch si inTransaction devuelve true. El conteo final debe coincidir con el inicial; mostrar solo el mensaje de excepción no demuestra que se revirtió la primera operación.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
