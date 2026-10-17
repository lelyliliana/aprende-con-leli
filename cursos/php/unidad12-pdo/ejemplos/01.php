<?php
declare(strict_types=1);

$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)");
$insertar = $db->prepare("INSERT INTO talleres (titulo) VALUES (:titulo)");
$insertar->execute(["titulo" => "PHP"]);
echo $db->query("SELECT titulo FROM talleres")->fetchColumn() . "\n";
