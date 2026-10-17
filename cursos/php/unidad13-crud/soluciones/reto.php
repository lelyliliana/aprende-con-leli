<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT)');
$db->exec("INSERT INTO talleres VALUES (1, 'PHP'), (2, 'Web')");
$stmt = $db->prepare('DELETE FROM talleres WHERE id = :id');
$stmt->execute(['id' => 1]);
echo $db->query('SELECT COUNT(*) FROM talleres')->fetchColumn() . " fila\n";
