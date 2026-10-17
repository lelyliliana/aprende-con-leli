<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . "/proyecto/src/bootstrap.php";
$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$db->exec(file_get_contents(dirname(__DIR__, 2) . "/proyecto/schema.sql"));
$repo = new Aprende\TallerRepository($db);
$validacion = Aprende\validarTaller(["titulo" => " Taller PHP ", "cupo" => "12"]);
if ($validacion["errores"] !== []) { throw new RuntimeException("La entrada debería ser válida"); }
$datos = $validacion["datos"];
$id = $repo->crear($datos["titulo"], $datos["cupo"]);
echo "Creado: " . $repo->buscar($id)["titulo"] . "\n";
$repo->actualizar($id, "Taller PHP web", 20);
echo "Cupo editado: " . $repo->buscar($id)["cupo"] . "\n";
$repo->eliminar($id);
echo "Registros finales: " . $repo->contar() . "\n";
