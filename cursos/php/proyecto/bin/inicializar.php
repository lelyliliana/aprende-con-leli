<?php
declare(strict_types=1);
require_once dirname(__DIR__) . '/src/bootstrap.php';
$db = conectar();
$sql = file_get_contents(dirname(__DIR__) . '/schema.sql');
if ($sql === false) { throw new RuntimeException('No se pudo leer schema.sql'); }
$db->exec($sql);
echo "Base inicializada. Los datos existentes se conservan.\n";
