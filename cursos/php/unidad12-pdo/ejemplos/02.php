<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (titulo TEXT NOT NULL)');
$db->exec("INSERT INTO talleres VALUES ('PHP')");
$consulta = $db->prepare('SELECT COUNT(*) FROM talleres WHERE titulo = :titulo');
$consulta->execute(['titulo' => "' OR 1=1 --"]);
echo $consulta->fetchColumn() . " coincidencias\n";
