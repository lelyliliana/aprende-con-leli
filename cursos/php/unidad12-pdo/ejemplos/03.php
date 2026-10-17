<?php
declare(strict_types=1);

$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec("PRAGMA foreign_keys = ON");
$db->exec("CREATE TABLE categorias (id INTEGER PRIMARY KEY, nombre TEXT NOT NULL)");
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY, categoria_id INTEGER REFERENCES categorias(id), titulo TEXT NOT NULL)");
$db->exec("INSERT INTO categorias VALUES (1, 'Web'), (2, 'Robótica')");
$db->exec("INSERT INTO talleres VALUES (1, 1, 'PHP'), (2, 1, 'HTML')");
$sql = "SELECT c.nombre, COUNT(t.id) AS cantidad FROM categorias c
        LEFT JOIN talleres t ON t.categoria_id = c.id GROUP BY c.id, c.nombre ORDER BY c.id";
foreach ($db->query($sql, PDO::FETCH_ASSOC) as $fila) {
    echo $fila["nombre"] . ": " . $fila["cantidad"] . " talleres\n";
}
