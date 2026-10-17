<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)');
$db->beginTransaction();
$db->exec("INSERT INTO talleres (titulo) VALUES ('PHP')");
$db->rollBack();
echo $db->query('SELECT COUNT(*) FROM talleres')->fetchColumn() . " filas\n";
