<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT)');
$db->exec("INSERT INTO talleres VALUES (1, 'PHP')");
$stmt = $db->prepare('UPDATE talleres SET titulo = :titulo WHERE id = :id');
$stmt->execute(['titulo' => 'PHP web', 'id' => 1]);
echo $db->query('SELECT titulo FROM talleres WHERE id = 1')->fetchColumn() . "\n";
