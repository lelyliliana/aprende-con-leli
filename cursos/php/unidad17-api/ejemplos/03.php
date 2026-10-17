<?php
declare(strict_types=1);

$talleres = [["id" => 1, "titulo" => "PHP", "cupo" => 12], ["id" => 2, "titulo" => "HTML", "cupo" => 8]];
$seleccion = array_filter($talleres, fn (array $taller): bool => $taller["cupo"] < 10);
$respuesta = ["data" => array_values($seleccion), "total" => count($seleccion)];
echo json_encode($respuesta, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
