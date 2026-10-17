<?php
declare(strict_types=1);
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    header('Allow: GET'); http_response_code(405); echo 'Método no permitido'; exit;
}
$nombre = $_GET['nombre'] ?? 'estudiante';
if (!is_string($nombre) || mb_strlen($nombre, 'UTF-8') > 80) {
    http_response_code(400); echo 'Nombre inválido'; exit;
}
header('Content-Type: text/html; charset=utf-8');
$texto = htmlspecialchars($nombre, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
?>
<!doctype html>
<html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Laboratorio HTTP</title></head>
<body><main><h1>Hola, <?= $texto ?></h1><p>Esta respuesta se generó con PHP para una petición GET.</p><p><a href="/?nombre=Leli">Probar otro nombre</a></p></main></body></html>
