<?php
declare(strict_types=1);

final class Resumen {
    public function __construct(private PDO $db) {}
    public function talleres(): int { return (int) $this->db->query("SELECT COUNT(*) FROM talleres")->fetchColumn(); }
}
$db = new PDO("sqlite::memory:");
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY)");
echo (new Resumen($db))->talleres() . " talleres\n";
