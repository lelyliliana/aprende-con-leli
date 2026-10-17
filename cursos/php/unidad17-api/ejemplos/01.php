<?php
declare(strict_types=1);

$respuesta = ["data" => [["id" => 1, "titulo" => "PHP", "cupo" => 12]], "page" => 1];
echo json_encode($respuesta, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
