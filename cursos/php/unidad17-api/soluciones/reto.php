<?php
declare(strict_types=1);

$error = ["error" => ["code" => "titulo_requerido", "message" => "Escribe el título del taller"]];
echo json_encode($error, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
