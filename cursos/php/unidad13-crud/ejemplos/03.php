<?php
declare(strict_types=1);

$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)");
$db->exec("INSERT INTO talleres VALUES (1, 'PHP')");
function editarTitulo(PDO $db, int $id, string $titulo): bool {
    $buscar = $db->prepare("SELECT id FROM talleres WHERE id = :id");
    $buscar->execute(["id" => $id]);
    if ($buscar->fetchColumn() === false) { return false; }
    $actualizar = $db->prepare("UPDATE talleres SET titulo = :titulo WHERE id = :id");
    $actualizar->execute(["titulo" => $titulo, "id" => $id]);
    return true;
}
echo editarTitulo($db, 1, "PHP web") ? "Editado\n" : "No encontrado\n";
echo editarTitulo($db, 99, "Otro") ? "Editado\n" : "No encontrado\n";
echo $db->query("SELECT titulo FROM talleres WHERE id = 1")->fetchColumn() . "\n";
