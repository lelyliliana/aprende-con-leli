<?php
declare(strict_types=1);

$post = ["correo" => "ana@example.test"];
$correo = $post["correo"] ?? null;
$valido = is_string($correo) && filter_var($correo, FILTER_VALIDATE_EMAIL) !== false;
echo $valido ? "Correo con formato válido\n" : "Correo inválido\n";
