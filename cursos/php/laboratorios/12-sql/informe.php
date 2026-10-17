<?php
declare(strict_types=1);
$db = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$db->exec('PRAGMA foreign_keys = ON');
$db->exec('CREATE TABLE categorias (id INTEGER PRIMARY KEY, nombre TEXT NOT NULL)');
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, categoria_id INTEGER NOT NULL REFERENCES categorias(id), titulo TEXT NOT NULL, cupo INTEGER CHECK(cupo BETWEEN 1 AND 100))');
$db->exec("INSERT INTO categorias VALUES (1, 'Web'), (2, 'Datos'), (3, 'Robótica')");
$insertar = $db->prepare('INSERT INTO talleres (categoria_id, titulo, cupo) VALUES (:categoria, :titulo, :cupo)');
foreach ([[1, 'PHP', 12], [1, 'HTML', 8], [2, 'SQL', 10]] as [$categoria, $titulo, $cupo]) {
    $insertar->execute(compact('categoria', 'titulo', 'cupo'));
}
$sql = 'SELECT c.nombre, COUNT(t.id) AS cantidad, COALESCE(SUM(t.cupo), 0) AS plazas
        FROM categorias c LEFT JOIN talleres t ON t.categoria_id = c.id
        GROUP BY c.id, c.nombre ORDER BY c.id';
foreach ($db->query($sql) as $fila) {
    $palabra = (int) $fila['cantidad'] === 1 ? 'taller' : 'talleres';
    echo $fila['nombre'] . ': ' . $fila['cantidad'] . ' ' . $palabra . ', ' . $fila['plazas'] . " plazas\n";
}
$db->beginTransaction();
try {
    $insertar->execute(['categoria' => 1, 'titulo' => 'Temporal', 'cupo' => 5]);
    $insertar->execute(['categoria' => 999, 'titulo' => 'Inválido', 'cupo' => 5]);
    $db->commit();
} catch (PDOException $e) {
    if ($db->inTransaction()) { $db->rollBack(); }
    echo "Operación revertida\n";
}
echo 'Filas finales: ' . $db->query('SELECT COUNT(*) FROM talleres')->fetchColumn() . "\n";
