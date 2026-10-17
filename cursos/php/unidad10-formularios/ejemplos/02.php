<?php
declare(strict_types=1);

$post = ["titulo" => ["PHP"], "cupo" => "0"];
$errores = [];
if (!is_string($post["titulo"] ?? null)) { $errores[] = "Título inválido"; }
$cupo = filter_var($post["cupo"], FILTER_VALIDATE_INT);
if ($cupo === false || $cupo < 1) { $errores[] = "Cupo inválido"; }
echo implode("; ", $errores) . "\n";
